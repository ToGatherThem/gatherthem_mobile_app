import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_profile.dart';
import 'package:gatherthem_mobile_app/ui/lists/collections_list.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProfile blocProfile = BlocProfile();
    blocProfile.fetchProfile();

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
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 50,
                                margin: EdgeInsets.zero,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                      Icons.perm_identity,
                                      color: Colors.black,
                                      size: 30
                                  ),
                                )
                              ),
                              Column(
                                children: [
                                  Text(
                                    'John Doe',
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '0',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                          Text(
                                            'Collections',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        ],
                                      ),
                                      const Padding(padding: EdgeInsets.only(right: 10)),
                                      Column(
                                        children: [
                                          Text(
                                            '0',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                          Text(
                                            'Objets',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {  },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            child: Text(
                              'Modifier mon profil',
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        )
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
              child: CollectionsList(),
            ),
          ),
        )
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
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                color: indicatorColor,
              ),
              unselectedLabelColor: indicatorColor,
              tabs: [
                Tab(
                  text: 'Vos Collections',
                ),
                Tab(
                  text: 'Ajouter une collection',
                ),
              ]),
          Container(
            height: 2,
            color: indicatorColor,
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
