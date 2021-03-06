#include <openssl/crypto.h>
#include <openssl/engine.h>
#include <stdio.h>
#include <string.h>
#include <err.h>
#include <openssl/err.h>
#include <openssl/evp.h>
#include <openssl/conf.h>
#include <openssl/ssl.h>
#include "meths/round5_meth.h"
#include "meths/asn1_meth.h"
#include "keypair.h"
#include <openssl/bio.h>
#include <openssl/x509v3.h>
#include <openssl/sha.h>
#include "ossl/objects.h"
#include "network/linux/client.h"
#include "network/linux/server.h"
#include <time.h>

#define cDBLUE	"\033[0;34m"
#define cNORM	"\033[m"
#define cBLUE	"\033[1;34m"
#define T(e) ({ if (!(e)) { \
		ERR_print_errors_fp(stderr); \
		OpenSSLDie(__FILE__, __LINE__, #e); \
	    } \
        })

#define TE(e) ({ if (!(e)) { \
		ERR_print_errors_fp(stderr); \
		fprintf(stderr, "Error at %s:%d %s\n", __FILE__, __LINE__, #e); \
		return -1; \
	    } \
        })


struct certKey{
  X509 *cert;
  EVP_PKEY *key;
};

static void print_pkey(EVP_PKEY *pkey){

  BIO *b = NULL;
  b = BIO_new(BIO_s_mem());
  ASN1_PCTX *pctx = NULL;
  pctx = ASN1_PCTX_new();

  unsigned char *private_key_text = NULL;
  if(!pkey){
    printf("\n!pkey\n");
  }

  EVP_PKEY_print_public(b, pkey, 4, pctx);

  BIO_get_mem_data(b, &private_key_text);

  printf("%s\n", private_key_text);
  BIO_free(b);
  ASN1_PCTX_free(pctx);
}

EVP_PKEY *test_dilithium(){
  const char *algoname = OBJ_nid2sn(NID_DILITHIUM);
  EVP_PKEY *ckey;
  T(ckey = EVP_PKEY_new());

  T(EVP_PKEY_set_type_str(ckey, algoname, strlen(algoname)));
  EVP_PKEY_set_type(ckey, NID_DILITHIUM);

  EVP_PKEY_CTX *tx;
  (tx = EVP_PKEY_CTX_new(ckey, NULL));
  T(EVP_PKEY_keygen_init(tx));

  EVP_PKEY *qkey = NULL;
  qkey = EVP_PKEY_new();
  ((EVP_PKEY_keygen(tx, &qkey)));
  if(!qkey){
    printf("\n!qkey\n");
  }
  // print_pkey(qkey);
  EVP_PKEY_free(ckey);

  return qkey;
}

struct certKey *gen_cert(){
  // Testing Engine functions
  char *algname = "Round5";
  EVP_PKEY *tkey;
  T(tkey = EVP_PKEY_new());
  T(EVP_PKEY_set_type_str(tkey, algname, strlen(algname)));
  EVP_PKEY_CTX *ctx = NULL;
  T(ctx = EVP_PKEY_CTX_new(tkey, NULL));
  T(EVP_PKEY_keygen_init(ctx));

  EVP_PKEY *pkey = NULL;
  pkey = EVP_PKEY_new();
  T((EVP_PKEY_keygen(ctx, &pkey)) == 1);
  EVP_PKEY_free(tkey);

  X509_REQ *req = NULL;
  T(req = X509_REQ_new());
  T(X509_REQ_set_version(req, 0L));
  X509_NAME *name;
  T(name = X509_NAME_new());
  X509_NAME_add_entry_by_txt(name, "C",  MBSTRING_ASC, (unsigned char *)"US", -1, -1, 0);
  X509_NAME_add_entry_by_txt(name, "ST",  MBSTRING_ASC, (unsigned char *)"MA", -1, -1, 0);
  X509_NAME_add_entry_by_txt(name, "L",  MBSTRING_ASC, (unsigned char *)"Cambridge", -1, -1, 0);
  X509_NAME_add_entry_by_txt(name, "O",  MBSTRING_ASC, (unsigned char *)"Draper", -1, -1, 0);
  X509_NAME_add_entry_by_txt(name, "CN", MBSTRING_ASC, (unsigned char *)"localhost", -1, -1, 0);
  T(X509_REQ_set_subject_name(req, name));
  T(X509_REQ_set_pubkey(req, pkey));
  X509_NAME_free(name);
  /* Cert. */
  X509 *x509ss = NULL;
  T(x509ss = X509_new());
  T(X509_set_version(x509ss, 2));
  BIGNUM *brnd = BN_new();
  T(BN_rand(brnd, 20 * 8 - 1, -1, 0));
  T(BN_to_ASN1_INTEGER(brnd, X509_get_serialNumber(x509ss)));
  T(X509_set_issuer_name(x509ss, X509_REQ_get_subject_name(req)));
  T(X509_gmtime_adj(X509_getm_notBefore(x509ss), 0));
  T(X509_time_adj_ex(X509_getm_notAfter(x509ss), 1, 0, NULL));
  T(X509_set_subject_name(x509ss, X509_REQ_get_subject_name(req)));
  T(X509_set_pubkey(x509ss, X509_REQ_get0_pubkey(req)));
  X509_REQ_free(req);
  BN_free(brnd);

  X509V3_CTX v3ctx;
  X509V3_set_ctx_nodb(&v3ctx);
  X509V3_set_ctx(&v3ctx, x509ss, x509ss, NULL, NULL, 0);
  X509_EXTENSION *ext;
  T(ext = X509V3_EXT_conf_nid(NULL, &v3ctx, NID_basic_constraints, "critical,CA:TRUE"));
  T(X509_add_ext(x509ss, ext, 0));
  X509_EXTENSION_free(ext);
  T(ext = X509V3_EXT_conf_nid(NULL, &v3ctx, NID_subject_key_identifier, "hash"));
  T(X509_add_ext(x509ss, ext, 1));
  X509_EXTENSION_free(ext);
  T(ext = X509V3_EXT_conf_nid(NULL, &v3ctx, NID_authority_key_identifier, "keyid:always,issuer"));
  T(X509_add_ext(x509ss, ext, 2));
  X509_EXTENSION_free(ext);

  struct certKey *c = (struct certKey *)malloc(sizeof(struct certKey));
  c->cert = (X509 *)malloc(sizeof(x509ss));
  c->key = (EVP_PKEY *)malloc(sizeof(pkey));
  c->cert = x509ss;
  // memcpy(c->key, pkey, sizeof(pkey));
  c->key = pkey;
  EVP_MD_CTX *mctx = NULL;
  T(mctx = EVP_MD_CTX_new());
  EVP_MD_CTX_free(mctx);
  cleanup:
  EVP_PKEY_CTX_free(ctx);
  return c;
}

int validate_peer_cert(X509 *cert, EVP_PKEY *pkey){
  unsigned char *result;
  int r = X509_verify(cert, pkey);
  return r;
}

void validate_self_signed_cert(X509 * cert){
  int status;
  X509_STORE_CTX *ctx;
  ctx = X509_STORE_CTX_new();
  X509_STORE *store = X509_STORE_new();

  X509_STORE_add_cert(store, cert);

  X509_STORE_CTX_init(ctx, store, cert, NULL);

  status = X509_verify_cert(ctx);
  if(status == 1)
  {
      printf("Certificate verified ok\n");
  }else
  {
      ps("INTRUDER");
  }
}

int main(int argc, const char* argv[]){
  printf(cBLUE "Testing Certificate Generation\n" cNORM);
  OPENSSL_add_all_algorithms_conf();
  ERR_load_crypto_strings();
  ENGINE_load_dynamic();
  ENGINE *round5_engine;
	T(round5_engine = ENGINE_by_id("round5"));
	T(ENGINE_init(round5_engine));
  T(ENGINE_set_default(round5_engine, ENGINE_METHOD_ALL));
  clock_t start, end;
  double time_elapsed;
  start = clock();
  struct certKey *c = gen_cert();
  end = clock();
  time_elapsed = ((double) (end - start)) / CLOCKS_PER_SEC;
  X509 *cert = c->cert;
  EVP_PKEY *pkey = test_dilithium();
  EVP_MD_CTX *mctx;
  T(mctx = EVP_MD_CTX_new());
  EVP_PKEY_CTX *pkctx = NULL;
  EVP_MD_CTX_init(mctx);
  T(EVP_DigestSignInit(mctx, &pkctx, EVP_sha512(), NULL, pkey));
  T(X509_sign_ctx(c->cert, mctx));
  EVP_MD_CTX_free(mctx);
  X509_print_fp(stdout, c->cert);
  int with_dilithium = validate_peer_cert(c->cert, pkey);
  if(with_dilithium == 1)
    printf("Certificate verification successful!");
  if(!c->key){
    printf("\n!c->key\n");
    return 1;
  }
  FILE * f = fopen("certs/key.pem", "wb");
  PEM_write_PrivateKey(
    f,                  /* write the key to the file we've opened */
    c->key,               /* our key from earlier */
    EVP_des_ede3_cbc(), /* default cipher for encrypting the key on disk */
    (unsigned char *)"hello",       /* passphrase required for decrypting the key on disk */
    5,                 /* length of the passphrase string */
    NULL,               /* callback for requesting a password */
    NULL                /* data to pass to the callback */
  );
  fclose(f);
  FILE * f2 = fopen("certs/cert.pem", "wb");
  PEM_write_X509(
      f2,   /* write the certificate to the file we've opened */
      c->cert /* our certificate */
  );
  printf("\n********************************************************\n");
  printf("\nComputation time: %f\n", time_elapsed);
  printf("\n********************************************************\n");

  fclose(f2);
  X509_free(c->cert);
  EVP_PKEY_free(c->key);
  free(c);
  ENGINE_finish(round5_engine);
  ENGINE_free(round5_engine);
  ENGINE_cleanup();
  return 0;
}
