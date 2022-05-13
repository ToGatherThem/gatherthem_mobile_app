import 'package:flutter/material.dart';

class TemplateTile extends StatelessWidget{

  final String templateName;
  final IconData templateIcon;


  const TemplateTile({Key? key, required this.templateName, required this.templateIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              'Ajouter des $templateName'
          ),
        ],
      ),
    );
  }


}