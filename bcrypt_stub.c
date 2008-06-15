
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>
#include <string.h>

char *bcrypt_do_hash(const char *, const char *);
void bcrypt_do_encode_salt(char *, u_int8_t *, u_int16_t, u_int8_t);

CAMLprim value
bcrypt_encode_salt(value cost, value seed)
{
  CAMLparam1(seed);
  CAMLlocal1(ret);
  char buf[64];

  bcrypt_do_encode_salt(buf, (unsigned char *)String_val(seed), 16, Int_val(cost));
  ret = caml_copy_string(buf);
  CAMLreturn(ret);
}

CAMLprim value bcrypt_hash(value salt, value secret)
{
  CAMLparam2(salt, secret);
  CAMLlocal1(ret);
  char *s;
  
  s = bcrypt_do_hash(String_val(secret), String_val(salt));

  ret = caml_copy_string(s);
  CAMLreturn(ret);
}
