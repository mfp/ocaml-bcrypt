type salt
type error = Invalid_seed | Corrupted_salt | Hash_error
exception Bcrypt_error of error * string

val salt_of_string : string -> salt
val string_of_salt : salt -> string

val encode_salt : int -> string -> salt
val hash : salt -> string -> string
