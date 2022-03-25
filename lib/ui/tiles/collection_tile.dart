import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_collection.dart';
import 'package:gatherthem_mobile_app/ui/widgets/custom_navigation_bar.dart';

import '../widgets/app_brand.dart';

class Collection extends StatelessWidget {
  const Collection({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(8))),
        elevation: 0,
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: const AppBrand(),
        automaticallyImplyLeading: false,
      ),
      body: BodyConfig(title: title, context: context),
      bottomSheet: const CustomNavigationBar(),
    );
  }

  BodyConfig({String? title, required BuildContext context}) {
    BlocCollection blocString = BlocCollection(initValue: null);
    blocString.fetchCollection();
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        elevation: 0,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.abc_rounded,
                size: 55,
              ),
              StreamBuilder<String>(
                  stream: blocString.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data != null) {
                      return Expanded(
                        child: Text(
                          snapshot.data!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Text(
                          "noText",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).primaryColor),
                        ),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
