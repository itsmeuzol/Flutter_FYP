// import 'package:encrypt/encrypt.dart';

// class User {
//   int id;
//   String full_name;
//   String location;
//   int houseno;
//   int wardno;
//   String email;
//   String password;
//    Encrypter _encrypter;
//  late Encrypted _hash;

  

//   // Getter and setter for id
//   int get getId => id;
//   set setId(int value) => id = value;

//   // Getter and setter for full_name
//   String get getFullName => full_name;
//   set setFullName(String value) => full_name = value;

//   // Getter and setter for location
//   String get getLocation => location;
//   set setLocation(String value) => location = value;

//   // Getter and setter for houseno
//   int get getHouseNo => houseno;
//   set setHouseNo(int value) => houseno = value;

//   // Getter and setter for wardno
//   int get getWardNo => wardno;
//   set setWardNo(int value) => wardno = value;

//   // Getter and setter for email
//   String get getEmail => email;
//   set setEmail(String value) => email = value;

//   // Getter and setter for password
//   String get getPassword => password;
//   set setPassword(String value) => password = value;

//   set hash(String password) {
//     _encrypter = Encrypter(Salsa20(Key.fromUtf8(
//       '$full_name$location$houseno$wardno$email '
//     )));
//     _hash = _encrypter.encrypt(password, iv: IV.fromUtf8(password));
//   }

//   String get hashBase64 {
//     if (_hash == null) {
//       return '';
//     } else {
//       return _hash.base64;
//     }
//   }

//   User.db(
//     this.id,
//     this.full_name,
//     this.location,
//     this.houseno,
//     this.wardno,
//     this.email,
//     this.password,
//    {
//     _encrypter = Encrypter(Salsa20(Key.fromUtf8(
//       '$full_name$location$houseno$wardno$email '
//     )));
//    }
//   );
// }
