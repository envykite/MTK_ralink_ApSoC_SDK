/* test.h */
/* $Id: //WIFI_SOC/release/SDK_4_1_0_0/source/user/openssl-0.9.8e/demos/easy_tls/test.h#1 $ */


void test_process_init(int fd, int client_p, void *apparg);
#define TLS_APP_PROCESS_INIT test_process_init

#undef TLS_CUMULATE_ERRORS

void test_errflush(int child_p, char *errbuf, size_t num, void *apparg);
#define TLS_APP_ERRFLUSH test_errflush
