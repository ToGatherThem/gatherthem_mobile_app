import 'authority.dart';

class ProfileModel{
  String username;
  String email;
  List<Authority> authorities;

  ProfileModel({required this.username, required this.email, required this.authorities});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'],
      email: json['email'],
      authorities: json['authorities'] != null ? (json['authorities'] as List).map((i) => Authority.fromJson(i)).toList() : [],
    );
  }
}