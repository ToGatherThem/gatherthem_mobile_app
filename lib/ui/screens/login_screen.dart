import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/services/authentication_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/register_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/password_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/text_input.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
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
              Strings.loginTitle,
              style: getTitleStyle(context),
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
            PasswordInput(
                label: Strings.passwordLabel,
                icon: Icons.lock_rounded,
                onChanged: (value){
                  credentials["password"] = value;
                }
            ),
            const Padding(padding: EdgeInsets.only(top: 50)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ActionButton(
                  onPressed: () {
                    AuthenticationService().login(
                        context,
                        "admin",
                        "exemple"
                    );
                  },
                  text: "Admin",
                  backgroundColor: Colors.orangeAccent,
                  icon: Icons.admin_panel_settings_rounded,
                  width: 90,
                ),
                ActionButton(
                  onPressed: () {
                    AuthenticationService().login(
                        context,
                        credentials["username"]!,
                        credentials["password"]!
                    );
                  },
                  text: Strings.loginLabel,
                  icon: Icons.login_rounded,
                  width: 120,
                ),
              ]
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.notRegistered,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                TextButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                }, child: Text(Strings.signUpNow, style: TextStyle(color: Theme.of(context).highlightColor),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}