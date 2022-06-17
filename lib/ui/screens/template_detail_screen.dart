import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/property_model.dart';
import 'package:gatherthem_mobile_app/models/template_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_collection_screen.dart';
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
              child: Text(template.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800))
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
                    Text(template.visibility, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (template.parent != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(Strings.templateParent, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text(template.parent!.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    splashRadius: 20,
                    tooltip: Strings.templateParentGo,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => TemplateDetailScreen(template: template.parent!)));
                    },
                  )
                ],
              ),
            if (template.parent != null)
              const SizedBox(height: 20),
            for (PropertyModel property in template.allProperties)
              TemplatePropertyTile(property: property),
            ActionButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddCollectionScreen(templateFullName: template.fullName)));
              },
              text: Strings.templateCreateCollection,
              icon: Icons.collections_bookmark_rounded,
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 20),
            ActionButton(
              onPressed: () {
                //TODO
              },
              text: Strings.templateCreateTemplate,
              icon: Icons.wysiwyg_rounded,
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}