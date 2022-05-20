import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/services/authentication_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/screens/login_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/dialogs/error_dialog.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/email_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/password_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/text_input.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Image(
                height: 100,
                image: Image.asset('assets/logoWhite.png').image
            ),
            Text(
              Strings.registerTitle,
              style: Styles.getTitleStyle(context),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            TextInput(
                label: Strings.userNameLabel,
                icon: Icons.person_rounded,
                onChanged: (value){
                  credentials["username"] = value;
                }
            ),
            EmailInput(
                label: Strings.emailLabel,
                icon: Icons.mail_rounded,
                onChanged: (value){
                  credentials["email"] = value;
                }
            ),
            PasswordInput(
                label: Strings.passwordLabel,
                icon: Icons.lock_rounded,
                onChanged: (value){
                  credentials["password"] = value;
                }
            ),
            PasswordInput(
                label: Strings.confirmPasswordLabel,
                icon: Icons.lock_rounded,
                onChanged: (value){
                  credentials["confirm_password"] = value;
                }
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            ActionButton(
              onPressed: () {
                validate(context);
              },
              text: Strings.signUpLabel,
              icon: Icons.login_rounded,
              width: 120,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.alreadyRegistered,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                }, child: Text(Strings.signInNow, style: TextStyle(color: Theme.of(context).highlightColor),)),
              ],
            )
          ],
        ),
      ),
    );
  }

  validate(context) {
    String errorText = "";
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);

    if (credentials["email"] == null || credentials["email"]!.isEmpty) {
      errorText = Strings.emailRequired;
    } else if (!regex.hasMatch(credentials["email"]!)) {
      errorText = Strings.emailNotValid;
    } else if (credentials["username"] == null || credentials["username"]!.isEmpty) {
      errorText = Strings.usernameRequired;
    } else if (credentials["password"] == null || credentials["password"]!.isEmpty) {
      errorText = Strings.passwordRequired;
    } else if (credentials["confirm_password"] == null || credentials["confirm_password"]!.isEmpty) {
      errorText = Strings.confirmPasswordRequired;
    } else if (credentials["password"] != credentials["confirm_password"]) {
      errorText = Strings.passwordsDontMatch;
    }

    if (errorText != "") {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: errorText);
          }
      );
    }

    AuthenticationService().register(context, credentials["email"]!, credentials["username"]!, credentials["password"]!);
  }

}