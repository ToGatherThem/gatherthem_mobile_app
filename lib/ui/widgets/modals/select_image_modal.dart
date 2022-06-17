import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/widgets/toast_body.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

/// Modal used to select an image
class SelectImageModal {
  void sendImage(XFile? file, onImageSelected, context) {
    if(file != null) {
      ImageCropper imageCropper = ImageCropper();

      imageCropper.cropImage(
          sourcePath: file.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Redimensionner',
              toolbarColor: Theme.of(context).bottomAppBarColor,
              toolbarWidgetColor: Theme.of(context).primaryColor,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true
          ),
      ).then((cropFile) => {
        if(cropFile != null) {
          cropFile.readAsBytes().then((bytes) => {
            onImageSelected(bytes),
            Navigator.of(context).pop(),
          })
        }
      });
    }
  }

  void show({required BuildContext context, required Function(Uint8List? image) onImageSelected, Function? onImageRemove
  }) {
    if(Platform.isAndroid) {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          ImagePicker picker = ImagePicker();

          return Wrap(
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt_rounded),
                  title:  const Text(Strings.camera),
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
                  title: const Text(Strings.gallery),
                  onTap: () {
                    picker
                        .pickImage(source: ImageSource.gallery)
                        .then((file) => {
                      sendImage(file, onImageSelected, context)
                    }
                    );
                  },
                ),
                Visibility(
                  visible: onImageRemove != null,
                  child: ListTile(
                    leading: const Icon(Icons.delete_rounded),
                    title: const Text(Strings.deletePicture),
                    onTap: () {
                      onImageRemove!();
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ]
          );
        },
      );
    } else {
      FToast fToast = FToast();
      fToast.init(context);
      fToast.showToast(child: ToastBody(text: Strings.cannotAddPictureFrom + Platform.operatingSystem),);
    }
  }
}