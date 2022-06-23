import 'dart:convert';
import 'dart:typed_data';

import 'authority.dart';

class ProfileModel{
  String username;
  String email;
  Uint8List? image;
  List<Authority> authorities;
  int nbConnections;
  int nbItems;

  ProfileModel({required this.username, required this.email, this.image, required this.authorities, required this.nbConnections, required this.nbItems});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      username: json['username'],
      email: json['email'],
      image: (json['image'] != null) ? const Base64Decoder().convert(json["image"]).buffer.asUint8List() : null,
      authorities: json['authorities'] != null ? (json['authorities'] as List).map((i) => Authority.fromJson(i)).toList() : [],
      nbConnections: json['nbCollections'],
      nbItems: json['nbItems'],
    );
  }
}