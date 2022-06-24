import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/template_model.dart';
import 'package:gatherthem_mobile_app/ui/custom_loading.dart';
import 'package:gatherthem_mobile_app/ui/tiles/template_tile.dart';

class TemplateList extends StatelessWidget {
  const TemplateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    blocTemplates.fetchTemplates(context);
    return StreamBuilder<List<TemplateModel>>(
      stream: blocTemplates.stream,
      builder: (context, snapshotTemplates) {
        if (snapshotTemplates.hasData) {
          CustomLoading.dismiss();
          snapshotTemplates.data!.sort((a, b) => a.fullName.compareTo(b.fullName));
          return ListView(
            physics: const BouncingScrollPhysics(),
            children: snapshotTemplates.data!.map((template) =>
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TemplateTile(template: template),
                )
            ).toList(),
          );
        } else {
          CustomLoading.customLoadingStyleAndShow(context: context);
          return Container();
        }
      }
    );
  }
}
