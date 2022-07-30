import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_collection_screen.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_template_screen.dart';

class AddCollectionOrTemplateModal {
  static void show({required BuildContext context
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.collections_bookmark_rounded),
                title:  const Text(Strings.addCollectionLabel),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddCollectionScreen())
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.wysiwyg_rounded),
                title: const Text(Strings.createTemplateLabel),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddTemplateScreen())
                  );
                },
              ),
            ]
        );
      },
    );
  }
}