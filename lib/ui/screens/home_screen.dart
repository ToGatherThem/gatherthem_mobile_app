import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_profile.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/profile_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/custom_loading.dart';
import 'package:gatherthem_mobile_app/ui/lists/collections_list.dart';
import 'package:gatherthem_mobile_app/ui/lists/templates_list.dart';
import 'package:gatherthem_mobile_app/ui/screens/preferences_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    blocProfile = BlocProfile();
    blocProfile.fetchProfile(context);

    return NavigationScaffoldWidget(
        body: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            physics: const BouncingScrollPhysics(),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverOverlapAbsorber(
                  handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.account_circle_rounded, size: 90),
                              Expanded(
                                child: StreamBuilder<ProfileModel>(
                                  stream: blocProfile.stream,
                                  builder: (context, snapshotProfile) {
                                    if(!snapshotProfile.hasData) {
                                      CustomLoading.customLoadingStyleAndShow(context: context);
                                      return Container();
                                    }
                                    CustomLoading.dismiss();
                                    ProfileModel profile = snapshotProfile.data!;
                                    return Column(
                                      children: [
                                        Text(
                                          profile.username,
                                          style: Styles.getPseudoStyle(context, weight: FontWeight.w600),
                                        ),
                                        const Padding(padding: EdgeInsets.only(bottom: 10)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  profile.nbConnections.toString(),
                                                  style: Styles.getFigureStyle(context, weight: FontWeight.w600),
                                                ),
                                                Text(
                                                  Strings.collectionsLabel,
                                                  style: Styles.getTextStyle(context),
                                                ),
                                              ],
                                            ),
                                            const Padding(padding: EdgeInsets.only(right: 10)),
                                            Column(
                                              children: [
                                                Text(
                                                  profile.nbItems.toString(),
                                                  style: Styles.getFigureStyle(context, weight: FontWeight.w600),
                                                ),
                                                Text(
                                                  Strings.itemsLabel,
                                                  style: Styles.getTextStyle(context),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    );
                                  }
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(top: 10),),
                        ActionButton(
                          text: Strings.editProfileLabel,
                          onPressed: () {  },///TODO
                          width: 180,
                          backgroundColor: Theme.of(context).highlightColor,
                          color: Theme.of(context).primaryColor,
                        ),
                        const Padding(padding: EdgeInsets.only(top: 40),)
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  floating: true,
                  pinned: true,
                  delegate: CustomSliverDelegate()
                )
              ];
            },
            body: const Padding(
              padding: EdgeInsets.only(top: 30),
              child: TabBarView(
                  children: [
                    CollectionsList(),
                    TemplateList()
                  ]
              ),
            ),
          ),
        ),
        trailingWidget: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                // alignment: Alignment.centerRight,
                icon: Icon(Icons.settings, color: Theme.of(context).primaryColor),
                splashRadius: 20,
                tooltip: Strings.preferences,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PreferencesScreen()));
                },
              ),
            ],
          ),
        ),
    );
  }
}


class CustomSliverDelegate extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    Color indicatorColor = Theme.of(context).primaryColor;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          TabBar(
              indicator: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                color: Theme.of(context).dividerColor,
              ),
              unselectedLabelColor: indicatorColor,
              labelColor: Theme.of(context).primaryColor,
              labelStyle: Styles.getTextStyle(context, weight: FontWeight.bold),
              unselectedLabelStyle: Styles.getTextStyle(context),
              tabs: const [
                Tab(
                  text: Strings.yourCollectionsLabel,
                ),
                Tab(
                  text: Strings.templates,
                ),
              ]),
          Container(
            height: 2,
            color: Theme.of(context).dividerColor,
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }

}
