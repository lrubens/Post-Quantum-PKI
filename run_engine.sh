gcc engine_check.c -o engine_check -lcrypto -I reference/src -DR5ND_5PKE_0d install/K12.o install/KangarooTwelve.o install/Keccak-compact-test.o install/Keccak-more-compact.o install/Keccak-readable-and-compact.o install/KeccakDuplexWidth1600.o install/KeccakDuplexWidth200.o install/KeccakDuplexWidth400.o install/KeccakDuplexWidth800.o install/KeccakHash.o install/KeccakP-1600-compact64.o install/KeccakP-1600-inplace32BI.o install/KeccakP-1600-opt64.o install/KeccakP-1600-reference.o install/KeccakP-1600-reference32BI.o install/KeccakP-1600-times2-on1.o install/KeccakP-1600-times4-on1.o install/KeccakP-1600-times4-on2.o install/KeccakP-1600-times8-on1.o install/KeccakP-1600-times8-on2.o install/KeccakP-1600-times8-on4.o install/KeccakP-200-compact.o install/KeccakP-200-reference.o install/KeccakP-400-reference.o install/KeccakP-800-compact.o install/KeccakP-800-opt32.o install/KeccakP-800-reference.o install/KeccakPRGWidth1600.o install/KeccakPRGWidth200.o install/KeccakPRGWidth400.o install/KeccakPRGWidth800.o install/KeccakSpongeWidth1600.o install/KeccakSpongeWidth200.o install/KeccakSpongeWidth400.o install/KeccakSpongeWidth800.o install/KeccakSum.o install/KetJr.o install/KetMj.o install/KetMn.o install/KetSr.o install/KetjeJr.o install/KetjeMj.o install/KetjeMn.o install/KetjeSr.o install/Kravatte.o install/KravatteModes.o install/LakeKeyak.o install/LunarKeyak.o install/OceanKeyak.o install/RiverKeyak.o install/SHA3-224.o install/SHA3-256.o install/SHA3-384.o install/SHA3-512.o install/SHAKE128.o install/SHAKE256.o install/SP800-185.o install/SeaKeyak.o install/SimpleFIPS202.o install/TweetableFIPS202-stub.o install/TweetableFIPS202.o install/a_fixed.o install/a_random.o install/asn1_meth.o install/base64.o install/cca_encrypt.o install/cpa_kem.o install/displayIntermediateValues.o install/drbg.o install/encrypt.o install/genKAT.o install/keypair.o install/little_endian.o install/misc.o install/objects.o install/ossl_compat.o install/pack.o install/parameters.o install/r5_cca_kem.o install/r5_cca_pke.o install/r5_core.o install/r5_cpa_kem.o install/r5_cpa_pke.o install/r5_dem.o install/r5_hash.o install/r5_memory.o install/r5_parameter_sets.o install/round5_engine.o install/round5_meth.o install/shake.o install/testKangarooTwelve.o install/testKetjev2.o install/testPlSnP.o install/testSP800-185.o install/testSnP.o install/test_crypto_aead.o install/test_crypto_hash.o install/true_rng.o install/xef_ref.o -lkeccak -lm -Xlinker -zmuldefs -g
valgrind --tool=memcheck --leak-check=full ./engine_check
