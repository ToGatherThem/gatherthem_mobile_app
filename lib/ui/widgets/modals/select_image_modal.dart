import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageModal {
  void sendImage(XFile? file, onImageSelected, context) {
    if(file != null) {
      ImageCropper imageCropper = ImageCropper();

      imageCropper.cropImage(
          sourcePath: file.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
      ).then((cropFile) => {
        if(cropFile != null) {
          cropFile.readAsBytes().then((bytes) => {
            log('Image selected: ${bytes.length} bytes'),
            onImageSelected(bytes),
            Navigator.of(context).pop(),
          })
        }
      });
    }
  }

  void show(BuildContext context, Function(Uint8List? image) onImageSelected) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        ImagePicker picker = ImagePicker();

        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_rounded),
              title: const Text('Appareil photo'),
              onTap: () {
                picker
                    .pickImage(source: ImageSource.camera)
                    .then((file) => {
                      sendImage(file, onImageSelected, context)
                    }
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_rounded),
              title: const Text('Galerie'),
              onTap: () {
                picker
                    .pickImage(source: ImageSource.gallery)
                    .then((file) => {
                      sendImage(file, onImageSelected, context)
                    }
                );
              },
            ),
          ]
        );
      },
    );
  }
}