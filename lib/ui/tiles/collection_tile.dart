import 'package:flutter/material.dart';

class CollectionTile extends StatelessWidget{

  final String title;
  const CollectionTile({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.photo,
                size: 55,
              ),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).primaryColor
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}