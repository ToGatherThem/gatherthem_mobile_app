import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/template_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';

class TemplateTile extends StatelessWidget{
  final TemplateModel template;

  const TemplateTile({Key? key, required this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return tileBody(context, template);
  }

  Widget tileBody(BuildContext context, TemplateModel template) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        height: 95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).cardColor,
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) =>
            //       TemplateDetailScreen(
            //           template: template,
            //       )
            //   ),
            // );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: Container(
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Icon(
                      Icons.wysiwyg_rounded,
                      size: 55,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                )
              ),
              const Padding(padding: EdgeInsets.only(left: 20)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.fullName,
                      style: Styles.getTextStyle(context, weight: FontWeight.bold, color: Theme.of(context).backgroundColor),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      template.visibility == 'PUBLIC' ? Strings.publicLabel : template.visibility == 'PRIVATE' ? Strings.privateLabel : '',
                      style: Styles.getTextStyle(context, color: Theme.of(context).backgroundColor),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}