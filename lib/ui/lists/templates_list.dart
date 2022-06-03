import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_collection_screen.dart';
import 'package:gatherthem_mobile_app/ui/tiles/template_tile.dart';

class TemplateList extends StatelessWidget {
  const TemplateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      crossAxisSpacing: 50,
      mainAxisSpacing: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      crossAxisCount: 2,
      children: <Widget>[
        const TemplateTile(
          templateName: Strings.books,
          templateIcon: Icons.menu_book,
          templateFullName: Strings.booksTemplateName,
        ),
        const TemplateTile(
          templateName: Strings.dvds,
          templateIcon: Icons.video_library,
          templateFullName: Strings.dvdsTemplateName,
        ),
        const TemplateTile(
            templateName: Strings.pins,
            templateIcon: Icons.push_pin,
            templateFullName: Strings.pinsTemplateName
        ),
        InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCollectionScreen())
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.add,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  Strings.other,
                  style: Styles.getTextStyle(context, color: Theme.of(context).backgroundColor),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
