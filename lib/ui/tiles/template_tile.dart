import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/screens/add_collection_screen.dart';

class TemplateTile extends StatelessWidget{

  final String templateName;
  final IconData templateIcon;
  final String? templateFullName;


  const TemplateTile({Key? key, required this.templateName, required this.templateIcon, this.templateFullName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddCollectionScreen(templateFullName: templateFullName,))
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
            Stack(
              children: [
                Icon(
                    templateIcon,
                    size: 50,
                    color: Theme.of(context).backgroundColor,
                ),
                Positioned(
                  top: 25,
                  left: 30,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                        Icons.add,
                      size: 15,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
            Text(
                'Ajouter des $templateName',
              style: Styles.getTextStyle(context, color: Theme.of(context).backgroundColor),
            ),
          ],
        ),
      ),
    );
  }


}