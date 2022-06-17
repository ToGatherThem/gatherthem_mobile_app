class UserUpdateModel {
  late String username;
  late String email;
  late String password;
  late String newPassword;
  late String newPasswordConfirm;

  toJson() {
    return {
      "username": username,
      "email": email,
      "password": password,
      "newPassword": newPassword,
      "newPasswordConfirm": newPasswordConfirm
    };
  }
}