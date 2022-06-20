import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/property_model.dart';
import 'package:gatherthem_mobile_app/models/template_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_collection_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_template_screen.dart';
import 'package:gatherthem_mobile_app/ui/tiles/template_property_tile.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';

class TemplateDetailScreen extends StatelessWidget {
  final TemplateModel template;

  const TemplateDetailScreen({Key? key, required this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget body = bodyConfig(context);
    return NavigationScaffoldWidget(body: body, leading: true);
  }

  Widget bodyConfig(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(template.fullName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800))
            ),
            if (template.description != "")
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(Strings.labelDesc, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(template.description, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Libellé des objets", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(template.itemLabelName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(Strings.templateVisibility, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(template.visibility == 'PUBLIC' ? Strings.publicLabel : template.visibility == 'PRIVATE' ? Strings.privateLabel : '', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (template.parent != null) InkWell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(Strings.templateParent, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(template.parent!.fullName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios)
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TemplateDetailScreen(template: template.parent!)));
              }
            ),
            if (template.parent != null) const SizedBox(height: 20),
            for (PropertyModel property in template.allProperties) TemplatePropertyTile(property: property),
            ActionButton(
              onPressed: () {
                const Icon(Icons.arrow_forward_ios);
              },
              text: Strings.templateCreateCollection,
              icon: Icons.collections_bookmark_rounded,
              width: 200,
            ),
            const SizedBox(height: 20),
            ActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddTemplateScreen(parentName: template.fullName)));
              },
              text: Strings.templateCreateTemplate,
              icon: Icons.wysiwyg_rounded,
              width: 200,
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}