
type salt = string

type error =
    Invalid_seed
  | Corrupted_salt
  | Hash_error

exception Bcrypt_error of error * string

let salt_of_string s = s (* TODO: check that it's a valid bcrypt salt *)
let string_of_salt s = s

external encode_salt : int -> string -> salt = "bcrypt_encode_salt"
external hash : salt -> string -> string = "bcrypt_hash"

let encode_salt log_rounds s =
  if String.length s <> 16 then
    raise (Bcrypt_error (Invalid_seed, "The seed must be of length 16 bytes."));
  encode_salt (min (max log_rounds 4) 31) s

let hash salt secret = match hash salt secret with
    ":" -> raise (Bcrypt_error (Hash_error, ""));
  | s -> s
