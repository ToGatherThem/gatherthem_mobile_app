import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/user_update_model.dart';
import 'package:gatherthem_mobile_app/models/profile_model.dart';
import 'package:gatherthem_mobile_app/services/authentication_service.dart';
import 'package:gatherthem_mobile_app/services/user_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/dialogs/error_dialog.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/email_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/password_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/text_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/modals/select_image_modal.dart';

class EditProfileScreen extends StatefulWidget {
  final ProfileModel profile;

  const EditProfileScreen({Key? key, required this.profile}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserUpdateModel userInfosModel = UserUpdateModel();

  @override
  void initState() {
    userInfosModel.username = widget.profile.username;
    userInfosModel.email = widget.profile.email;
    userInfosModel.image = widget.profile.image;
    userInfosModel.password = "";
    userInfosModel.newPassword = "";
    userInfosModel.newPasswordConfirm = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SelectImageModal selectImageModal = SelectImageModal();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Column(
          children: [
            Text(Strings.profileEdit, style: Styles.getTitleStyle(context)),
            const SizedBox(height: 50),
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(90),
                  onTap: () => selectImageModal.show(
                      context: context,
                      onImageSelected: (Uint8List? image) {
                        userInfosModel.image = image;
                        setState(() {});
                      },
                      onImageRemove: (userInfosModel.image != null) ? () {
                        userInfosModel.image = null;
                        setState(() {});
                      } : null
                  ),
                  child: Container(
                      height: 115,
                      width: 115,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1
                          )
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(90),
                          child: (userInfosModel.image == null) ? Stack(
                              children: [
                                Container(
                                  color: Colors.grey,
                                ),
                                const Center(
                                  child: Icon(Icons.image_rounded, color: Colors.white, size: 50),
                                )
                              ]
                          ) : Image(
                            image: MemoryImage(userInfosModel.image!),
                            fit: BoxFit.cover,
                          )
                      )
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextInput(
                    label: Strings.userNameLabel,
                    icon: Icons.person_rounded,
                    initialValue: widget.profile.username,
                    onChanged: (String value) {
                      userInfosModel.username = value;
                    }
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            EmailInput(
              label: Strings.emailLabel,
              icon: Icons.mail_rounded,
              defaultValue: widget.profile.email,
              onChanged: (value) {
                userInfosModel.email = value;
              }
            ),
            const SizedBox(height: 30),
            PasswordInput(
                label: Strings.passwordCurrent,
                icon: Icons.lock_rounded,
                onChanged: (value) {
                  userInfosModel.password = value;
                }
            ),
            const SizedBox(height: 30),
            PasswordInput(
              label: Strings.passwordNew,
              icon: Icons.password,
              onChanged: (value) {
                userInfosModel.newPassword = value;
              }
            ),
            const SizedBox(height: 30),
            PasswordInput(
                label: Strings.passwordNewConfirm,
                icon: Icons.password,
                onChanged: (value) {
                  userInfosModel.newPasswordConfirm = value;
                }
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: Strings.cancelLabel,
                  backgroundColor: Colors.grey,
                  icon: Icons.close_rounded,
                ),
                const SizedBox(width: 10),
                ActionButton(
                  onPressed: () {
                    validate(context);
                  },
                  width: 110,
                  text: Strings.editLabel,
                  icon: Icons.check_circle_outline_rounded,
                ),
              ],
            ),
          ]
        )
      )
    );
  }

  validate(context) {
    String errorText = "";
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);

    if (userInfosModel.username.isEmpty) {
      errorText = Strings.usernameRequired;
    } else if (userInfosModel.email.isEmpty) {
      errorText = Strings.emailRequired;
    } else if (!regex.hasMatch(userInfosModel.email)) {
      errorText = Strings.emailNotValid;
    } else if (userInfosModel.newPassword.isNotEmpty && userInfosModel.newPasswordConfirm.isEmpty) {
      errorText = Strings.passwordNewConfirmRequired;
    } else if (userInfosModel.newPassword.isNotEmpty && userInfosModel.newPasswordConfirm.isNotEmpty
      && (userInfosModel.newPassword != userInfosModel.newPasswordConfirm)) {
      errorText = Strings.passwordsDontMatch;
    } else if (userInfosModel.password.isEmpty) {
      errorText = Strings.passwordCurrentRequired;
    }

    if (errorText != "") {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDialog(message: errorText);
        }
      );
    }

    UserService().updateProfile(context, userInfosModel).then((value) {
      String password = userInfosModel.newPassword.isEmpty ? userInfosModel.password : userInfosModel.newPassword;
      AuthenticationService().login(context, userInfosModel.username, password);
    });
  }
}