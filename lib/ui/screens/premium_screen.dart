
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/profile_model.dart';
import 'package:gatherthem_mobile_app/services/authentication_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/custom_loading.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/password_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';
import 'package:intl/intl.dart';


class PremiumScreen extends StatelessWidget{
  const PremiumScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    String password = "";
    return NavigationScaffoldWidget(
      leading : true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: StreamBuilder<ProfileModel>(
            stream: blocProfile.stream,
            builder: (context, snapshotProfile) {
              if (snapshotProfile.hasData && snapshotProfile.data!.authorities.where((element) => element.code == "PREMIUM").isNotEmpty){ // if user is premium
                CustomLoading.dismiss();
                return Column(
                  children: [
                    Text(Strings.alreadyGotPremium, style: Styles.getPseudoStyle(context),),
                    const SizedBox(height: 50),
                    Text(Strings.validUntil + DateFormat(Strings.dayFormat).format(DateTime.now().add(const Duration(days: 7))), style: Styles.getTextStyle(context))
                  ],
                );
              }
              else if(snapshotProfile.hasData){
                CustomLoading.dismiss();
                return Column(
                  children: [
                    Text(Strings.premiumTitle, style: Styles.getTitleStyle(context)),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Text(Strings.premiumBody, style: Styles.getTextStyle(context),),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    buildPremiumItem(label: Strings.unlimitedColls, icon: Icons.collections_bookmark_rounded, context: context),
                    buildPremiumItem(label: Strings.unlimitedItems, icon: Icons.add_to_photos_outlined, context: context),
                    buildPremiumItem(label: Strings.noPub, icon: Icons.tv_off_rounded, context: context),
                    buildPremiumItem(label: Strings.chatFeature, icon: Icons.chat_rounded, context: context),
                    buildPremiumItem(label: Strings.exchangeFeature, icon: Icons.connect_without_contact_rounded, context: context),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    Text(Strings.loginToContinue, style: Styles.getTextStyle(context),),
                    PasswordInput(
                        label: Strings.passwordLabel,
                        icon: Icons.lock_rounded,
                        onChanged: (value){
                          password = value;
                        }
                    ),
                    const Padding(padding: EdgeInsets.only(top: 30)),
                    ActionButton(
                      text : Strings.premiumButton,
                      onPressed: () async {
                        if(password != ""){
                          blocProfile.buyPremium(context, snapshotProfile.data!.username, password);
                        }
                      },
                    ),
                  ],
                );
              }
              else{
                CustomLoading.customLoadingStyleAndShow(context: context);
                return Container();
              }

          }
        ),
      ),
    );
  }

  Widget buildPremiumItem({required String label, required IconData icon, required BuildContext context}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor,),
          const Padding(padding: EdgeInsets.only(right: 10)),
          Expanded(child: Text(label, style: Styles.getTextStyle(context),)),
        ],
      ),
    );
  }
}