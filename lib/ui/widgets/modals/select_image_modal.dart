import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';

class SelectImageModal {
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text(Strings.camera),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text(Strings.gallery),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ]
        );
      },
    );
  }
}