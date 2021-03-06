/*
 * Copyright (c) 2018, Koninklijke Philips N.V.
 */

/**
 * @file
 * Implementation of the deterministic random bits (bytes) functions.
 *
 * Uses cSHAKE128 (seed size <= 16 bytes) or cSHAKE256 (seed size > 16 bytes) to
 * generate the random bytes. Unless USE_AES_DRBG is defined, in which case AES
 * in CTR mode on a zero input block with the seed as key is used to generate
 * the random data.
 *
 * Note: in case there is no customization, we use SHAKE directly instead of
 * cSHAKE since this saves some overhead.
 */

#include "drbg.h"
#include "shake.h"
#include "little_endian.h"
#include "r5_hash.h"

#ifdef USE_AES_DRBG
#include <assert.h>
#endif

#undef drbg_sampler16_2
#undef drbg_sampler16_2_once
#undef drbg_sampler16_2_once_customization

/*******************************************************************************
 * Private data & functions
 ******************************************************************************/

#ifdef USE_AES_DRBG

#include "misc.h"
#include "r5_memory.h"
#include "little_endian.h"
#include <openssl/opensslv.h>
#include <openssl/evp.h>
#include <string.h>

/**
 * The DRBG context data structure.
 */
typedef struct {
    EVP_CIPHER_CTX *aes_ctx; /**< The AES cipher context */
    uint8_t input[16]; /**< Input block (always 0). */
    uint8_t output[16]; /**< Buffer for output. */
    size_t index; /**< Current index in buffer. */
} drbg_ctx;

/**
 * The context for the DRBG.
 */
static drbg_ctx ctx = {NULL,
    {0},
    {0},
    0};

#if OPENSSL_VERSION_NUMBER >= 0x1010100f
/**
 * Macro to initialize the AES DRBG context
 * With OpenSSL >= 1.1.1 we can reuse the AES context by resetting it.
 * @param ctx the DRBG context
 */
#define AES_INIT(ctx) \
    if (ctx.aes_ctx == NULL) { \
        if (!(ctx.aes_ctx = EVP_CIPHER_CTX_new())) { \
            DEBUG_ERROR("Error: failed to create encryption context of the DRBG.\n"); \
            abort(); \
        } \
    } else { \
        if (EVP_CIPHER_CTX_reset(ctx.aes_ctx) != 1) { \
            DEBUG_ERROR("Error: failed to reset encryption context of the DRBG.\n"); \
            abort();\
        } \
    } \
    do { } while (0)
#else
/**
 * Macro to initialize the AES DRBG context
 * With OpenSSL < 1.1.1 we need to always create a new AES context since there is no EVP_CIPHER_CTX_reset.
 * @param ctx the DRBG context
 */
#define AES_INIT(ctx) \
    if (ctx.aes_ctx != NULL) { \
        EVP_CIPHER_CTX_free(ctx.aes_ctx); \
    } \
    if (!(ctx.aes_ctx = EVP_CIPHER_CTX_new())) { \
        DEBUG_ERROR("Error: failed to create encryption context of the DRBG.\n"); \
        abort(); \
    } \
    do { } while (0)
#endif

#else

/**
 * The DRBG context data structure.
 */
typedef struct {

    union {
        shake_ctx shake; /**< Context in case of a SHAKE generator */
        cshake_ctx cshake; /**< Context in case of a cSHAKE generator */
    } generator_ctx; /**< The generator context */
    uint8_t output[SHAKE128_RATE > SHAKE256_RATE ? SHAKE128_RATE : SHAKE256_RATE]; /**< Buffer for output. */
    size_t index; /**< Current index in buffer. */
    void (* generate)(uint8_t *output, const size_t output_len); /**< The generation function. */
} drbg_ctx;

/**
 * The context for the DRBG.
 */
static drbg_ctx ctx;

/**
 * Function to generate the random data using SHAKE256.
 *
 * @param output the output buffer for the random bytes
 * @param output_len the number of bytes to generate
 */
static void generate_shake256(uint8_t *output, const size_t output_len) {
    size_t i, j;

    i = ctx.index;
    for (j = 0; j < output_len; j++) {
        if (i >= SHAKE256_RATE) {
            shake256_squeezeblocks(&ctx.generator_ctx.shake, ctx.output, 1);
            i = 0;
        }
        output[j] = ctx.output[i++];
    }
    ctx.index = i;
}

/**
 * Function to generate the random data using SHAKE128.
 *
 * @param output the output buffer for the random bytes
 * @param output_len the number of bytes to generate
 */
static void generate_shake128(uint8_t *output, const size_t output_len) {
    size_t i, j;

    i = ctx.index;
    for (j = 0; j < output_len; j++) {
        if (i >= SHAKE128_RATE) {
            shake128_squeezeblocks(&ctx.generator_ctx.shake, ctx.output, 1);
            i = 0;
        }
        output[j] = ctx.output[i++];
    }
    ctx.index = i;
}

/**
 * Function to generate the random data using cSHAKE256.
 *
 * @param output the output buffer for the random bytes
 * @param output_len the number of bytes to generate
 */
static void generate_cshake256(uint8_t *output, const size_t output_len) {
    size_t i, j;

    i = ctx.index;
    for (j = 0; j < output_len; j++) {
        if (i >= SHAKE256_RATE) {
            cshake256_squeezeblocks(&ctx.generator_ctx.cshake, ctx.output, 1);
            i = 0;
        }
        output[j] = ctx.output[i++];
    }
    ctx.index = i;
}

/**
 * Function to generate the random data using cSHAKE128.
 *
 * @param output the output buffer for the random bytes
 * @param output_len the number of bytes to generate
 */
static void generate_cshake128(uint8_t *output, const size_t output_len) {
    size_t i, j;

    i = ctx.index;
    for (j = 0; j < output_len; j++) {
        if (i >= SHAKE128_RATE) {
            cshake128_squeezeblocks(&ctx.generator_ctx.cshake, ctx.output, 1);
            i = 0;
        }
        output[j] = ctx.output[i++];
    }
    ctx.index = i;
}

#endif

/*******************************************************************************
 * Public functions
 ******************************************************************************/

void drbg_init(const void *seed, const size_t seed_size) {
    /* Since without customization, SHAKE == CSHAKE, we use SHAKE here directly. */

#ifdef USE_AES_DRBG
    uint8_t key[32];

    AES_INIT(ctx);

    int res;
    assert(seed_size == 16 || seed_size == 24 || seed_size == 32);
    hash(key, seed_size, seed, seed_size, (uint8_t) seed_size);
    switch (seed_size) {
        case 16:
            shake128(key, seed_size, seed, seed_size);
            res = EVP_EncryptInit_ex(ctx.aes_ctx, EVP_aes_128_ctr(), NULL, key, NULL);
            break;
        case 24:
            shake256(key, seed_size, seed, seed_size);
            res = EVP_EncryptInit_ex(ctx.aes_ctx, EVP_aes_192_ctr(), NULL, key, NULL);
            break;
        case 32:
            shake256(key, seed_size, seed, seed_size);
            res = EVP_EncryptInit_ex(ctx.aes_ctx, EVP_aes_256_ctr(), NULL, key, NULL);
            break;
    }
    if (res != 1) {
        DEBUG_ERROR("Error: failed to initialize encryption context for the DRBG.\n");
        abort();
    }

    ctx.index = 16;

#else

    if (seed_size > 16) {
        shake256_init(&ctx.generator_ctx.shake);
        shake256_absorb(&ctx.generator_ctx.shake, seed, seed_size);
        ctx.index = SHAKE256_RATE;
        ctx.generate = &generate_shake256;
    } else {
        shake128_init(&ctx.generator_ctx.shake);
        shake128_absorb(&ctx.generator_ctx.shake, seed, seed_size);
        ctx.index = SHAKE128_RATE;
        ctx.generate = &generate_shake128;
    }

#endif

}

void drbg_init_customization(const void *seed, const size_t seed_size, const uint8_t *customization, const size_t customization_len) {

#ifdef USE_AES_DRBG
    uint8_t key[32];

    AES_INIT(ctx);

    int res;
    assert(seed_size == 16 || seed_size == 24 || seed_size == 32);
    hash_customization(key, seed_size, seed, seed_size, customization, customization_len, (uint8_t) seed_size);
    switch (seed_size) {
        case 16:
            res = EVP_EncryptInit_ex(ctx.aes_ctx, EVP_aes_128_ctr(), NULL, key, NULL);
            break;
        case 24:
            res = EVP_EncryptInit_ex(ctx.aes_ctx, EVP_aes_192_ctr(), NULL, key, NULL);
            break;
        case 32:
            res = EVP_EncryptInit_ex(ctx.aes_ctx, EVP_aes_256_ctr(), NULL, key, NULL);
            break;
    }
    if (res != 1) {
        DEBUG_ERROR("Error: failed to initialize encryption context for the DRBG.\n");
        abort();
    }

    ctx.index = 16;

#else

    if (seed_size > 16) {
        cshake256_init(&ctx.generator_ctx.cshake, customization, customization_len);
        cshake256_absorb(&ctx.generator_ctx.cshake, seed, seed_size);
        ctx.index = SHAKE256_RATE;
        ctx.generate = &generate_cshake256;
    } else {
        cshake128_init(&ctx.generator_ctx.cshake, customization, customization_len);
        cshake128_absorb(&ctx.generator_ctx.cshake, seed, seed_size);
        ctx.index = SHAKE128_RATE;
        ctx.generate = &generate_cshake128;
    }

#endif

}

int drbg(void *x, const size_t xlen) {
#ifdef USE_AES_DRBG

    size_t i, j;

    i = ctx.index;
    for (j = 0; j < xlen; j++) {
        if (i >= 16) {
            int len;
            if (EVP_EncryptUpdate(ctx.aes_ctx, ctx.output, &len, ctx.input, 16) != 1) {
                DEBUG_ERROR("Error: failed to generate deterministic random data.\n");
                abort();
            }
            i = 0;
        }
        ((uint8_t *) x)[j] = ctx.output[i++];
    }
    ctx.index = i;

#else

    ctx.generate(x, xlen);

#endif

    return 0;
}

uint16_t drbg_sampler16(const uint32_t range) {
    DRBG_SAMPLER16_INIT(range);
    uint16_t rnd;
    DRBG_SAMPLER16(rnd, range);
    return rnd;
}

uint16_t drbg_sampler16_2() {
    uint16_t rnd;
    drbg(&rnd, sizeof (rnd));
    rnd = (uint16_t) LITTLE_ENDIAN16(rnd);
    return rnd;
}

int drbg_sampler16_2_once(uint16_t *x, const size_t xlen, const void *seed, const size_t seed_size) {
    /* Since without customization, SHAKE == CSHAKE, we use SHAKE here directly. */

#ifdef USE_AES_DRBG
    uint8_t key[32];

    EVP_CIPHER_CTX * aes_ctx;
    if (!(aes_ctx = EVP_CIPHER_CTX_new())) {
        DEBUG_ERROR("Error: failed to create encryption context of the DRBG.\n");
        abort();
    }

    int res;
    hash(key, seed_size, seed, seed_size, (uint8_t) seed_size);
    switch (seed_size) {
        case 16:
            res = EVP_EncryptInit_ex(aes_ctx, EVP_aes_128_ctr(), NULL, key, NULL);
            break;
        case 24:
            res = EVP_EncryptInit_ex(aes_ctx, EVP_aes_192_ctr(), NULL, key, NULL);
            break;
        case 32:
            res = EVP_EncryptInit_ex(aes_ctx, EVP_aes_256_ctr(), NULL, key, NULL);
            break;
        default:
            DEBUG_ERROR("Error: Invalid seed size for DRBG %zu.\n", seed_size);
            abort();
    }
    if (res != 1) {
        DEBUG_ERROR("Error: failed to initialize encryption context for the DRBG.\n");
        abort();
    }

    size_t nr_full_blocks = (xlen * sizeof (uint16_t)) >> 4;
    int len;
    if (nr_full_blocks) {
        uint8_t *input = checked_calloc(nr_full_blocks, 16);
        if (EVP_EncryptUpdate(aes_ctx, (uint8_t *) x, &len, input, (int) (nr_full_blocks << 4)) != 1) {
            DEBUG_ERROR("Error: failed to generate deterministic random data.\n");
            abort();
        }
        free(input);
    }
    if ((xlen * sizeof (uint16_t)) & 15) {
        uint8_t final_block_output[16];
        uint8_t final_input[16] = {0};
        u64_to_le(final_input, (uint64_t) (nr_full_blocks + 1));
        if (EVP_EncryptUpdate(aes_ctx, final_block_output, &len, final_input, 16) != 1) {
            DEBUG_ERROR("Error: failed to generate deterministic random data.\n");
            abort();
        }
        memcpy(((uint8_t *) x) + (nr_full_blocks << 4), final_block_output, (xlen * sizeof (uint16_t)) & 15);
    }

    EVP_CIPHER_CTX_free(aes_ctx);

#else

    if (seed_size > 16) {
        shake256((uint8_t *) x, xlen * sizeof (uint16_t), (const uint8_t *) seed, seed_size);
    } else {
        shake128((uint8_t *) x, xlen * sizeof (uint16_t), (const uint8_t *) seed, seed_size);
    }

#endif

#if __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
    /* Flip byte order if necessary */
    for (size_t i = 0; i < xlen; ++i) {
        x[i] = (uint16_t) LITTLE_ENDIAN16(x[i]);
    }
#endif

    return 0;
}

int drbg_sampler16_2_once_customization(uint16_t *x, const size_t xlen, const void *seed, const size_t seed_size, const void *customization, const size_t customization_len) {

#ifdef USE_AES_DRBG
    uint8_t key[32];

    EVP_CIPHER_CTX * aes_ctx;
    if (!(aes_ctx = EVP_CIPHER_CTX_new())) {
        DEBUG_ERROR("Error: failed to create encryption context of the DRBG.\n");
        abort();
    }

    int res;
    hash_customization(key, seed_size, seed, seed_size, customization, customization_len, (uint8_t) seed_size);
    switch (seed_size) {
        case 16:
            res = EVP_EncryptInit_ex(aes_ctx, EVP_aes_128_ctr(), NULL, key, NULL);
            break;
        case 24:
            res = EVP_EncryptInit_ex(aes_ctx, EVP_aes_192_ctr(), NULL, key, NULL);
            break;
        case 32:
            res = EVP_EncryptInit_ex(aes_ctx, EVP_aes_256_ctr(), NULL, key, NULL);
            break;
        default:
            DEBUG_ERROR("Error: Invalid seed size for DRBG %zu.\n", seed_size);
            abort();
    }
    if (res != 1) {
        DEBUG_ERROR("Error: failed to initialize encryption context for the DRBG.\n");
        abort();
    }

    size_t nr_full_blocks = (xlen * sizeof (uint16_t)) >> 4;
    int len;
    if (nr_full_blocks) {
        uint8_t *input = checked_calloc(nr_full_blocks, 16);
        if (EVP_EncryptUpdate(aes_ctx, (uint8_t *) x, &len, input, (int) (nr_full_blocks << 4)) != 1) {
            DEBUG_ERROR("Error: failed to generate deterministic random data.\n");
            abort();
        }
        free(input);
    }
    if ((xlen * sizeof (uint16_t)) & 15) {
        uint8_t final_block_output[16];
        uint8_t final_input[16] = {0};
        u64_to_le(final_input, (uint64_t) (nr_full_blocks + 1));
        if (EVP_EncryptUpdate(aes_ctx, final_block_output, &len, final_input, 16) != 1) {
            DEBUG_ERROR("Error: failed to generate deterministic random data.\n");
            abort();
        }
        memcpy(((uint8_t *) x) + (nr_full_blocks << 4), final_block_output, (xlen * sizeof (uint16_t)) & 15);
    }

    EVP_CIPHER_CTX_free(aes_ctx);

#else

    if (seed_size > 16) {
        cshake256((uint8_t *) x, xlen * sizeof (uint16_t), (const uint8_t *) seed, seed_size, (const uint8_t *) customization, customization_len);
    } else {
        cshake128((uint8_t *) x, xlen * sizeof (uint16_t), (const uint8_t *) seed, seed_size, (const uint8_t *) customization, customization_len);
    }

#endif

#if __BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__
    /* Flip byte order if necessary */
    for (size_t i = 0; i < xlen; ++i) {
        x[i] = (uint16_t) LITTLE_ENDIAN16(x[i]);
    }
#endif

    return 0;
}
