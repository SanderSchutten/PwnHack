#ifndef _snx_encrypt_decrypt_h
#define _snx_encrypt_decrypt_h

void snx_setkey();
int snx_encrypt(unsigned long long *data);
int snx_decrypt(unsigned long long *data);

#endif /* _snx_encrypt_decrypt_h */

