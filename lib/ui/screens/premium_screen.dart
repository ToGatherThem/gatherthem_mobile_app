
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/profile_model.dart';
import 'package:gatherthem_mobile_app/services/user_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/custom_loading.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';


class PremiumScreen extends StatelessWidget{
  const PremiumScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    blocProfile.fetchProfile(context);
    return NavigationScaffoldWidget(
      leading : true,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
        child: StreamBuilder<ProfileModel>(
            stream: blocProfile.stream,
            builder: (context, snapshotProfile) {
              print(snapshotProfile.data!.authorities.map((e) => e.code).toList());
              if (snapshotProfile.hasData && snapshotProfile.data!.authorities.where((element) => element.code == "PREMIUM").isNotEmpty){ // if user is premium
                CustomLoading.dismiss();
                return Text(Strings.alreadyGotPremium, style: Styles.getPseudoStyle(context),);
              }
              else if(snapshotProfile.hasData){
                CustomLoading.dismiss();
                return Column(
                  children: [
                    Text(Strings.premiumTitle, style: Styles.getTitleStyle(context)),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Text(Strings.premiumBody, style: Styles.getTextStyle(context),),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    ActionButton(
                      text : Strings.premiumButton,
                      onPressed: () async {
                        await blocProfile.buyPremium(context);
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

}