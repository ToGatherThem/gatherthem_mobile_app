import 'dart:typed_data';

class UserUpdateModel {
  late String username;
  late String email;
  Uint8List? image;
  late String password;
  late String newPassword;
  late String newPasswordConfirm;

  toJson() {
    return {
      "username": username,
      "email": email,
      "image": image,
      "password": password,
      "newPassword": newPassword,
      "newPasswordConfirm": newPasswordConfirm
    };
  }
}