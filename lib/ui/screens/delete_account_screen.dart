import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/screens/home_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';
import 'package:gatherthem_mobile_app/ui/widgets/toast_body.dart';

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationScaffoldWidget(
      leading: true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: Column(
          children: [
            Text(Strings.deleteAccountTitle, style: Styles.getTitleStyle(context)),
            const Padding(padding: EdgeInsets.only(top: 20)),
            Text(Strings.deleteAccountBody, style: Styles.getTextStyle(context)),
            const Padding(padding: EdgeInsets.only(top: 30)),
            ActionButton(
              width: 180,
              backgroundColor: Colors.redAccent,
              text: Strings.deleteAccountButton,
              onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen()), (Route<dynamic> route) => false);
                FToast fToast = FToast();
                fToast.init(context);
                fToast.showToast(
                  child: const ToastBody(text: Strings.deleteAccountSuccess),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}