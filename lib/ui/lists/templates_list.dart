import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/ui/tiles/template_tile.dart';

class TemplateList extends StatelessWidget {
  const TemplateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisSpacing: 50,
      mainAxisSpacing: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      crossAxisCount: 2,
      children: const <Widget>[
        TemplateTile(
          templateName: 'Livres',
          templateIcon: Icons.menu_book,
        ),
        TemplateTile(
          templateName: 'DVDs',
          templateIcon: Icons.video_library,
        ),
        TemplateTile(
            templateName: "Pin's",
            templateIcon: Icons.push_pin
        ),
        TemplateTile(
            templateName: "Autres",
            templateIcon: Icons.square_rounded
        ),
      ],
    );
  }
}
