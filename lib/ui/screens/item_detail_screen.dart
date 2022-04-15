import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_collection_item.dart';
import 'package:gatherthem_mobile_app/models/collection_item_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';
import 'package:intl/intl.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({Key? key, required this.collectionItem})
      : super(key: key);
  final CollectionItemModel collectionItem;

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle =
        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    TextStyle subtitleStyle =
        const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle descriptionStyle = const TextStyle(fontSize: 16);
    BlocCollectionItem blocCollectionItem = BlocCollectionItem();
    //blocCollectionItem.fetchCollections(collection.id);
    Widget body =  bodyConfig(context, titleStyle, descriptionStyle);
    return NavigationScaffoldWidget(body: body, leading: true);
  }

  Scaffold bodyConfig(BuildContext context, TextStyle titleStyle, TextStyle descriptionStyle) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Container(
                color: Theme.of(context).backgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Icon(
                            Icons.photo_album_outlined,
                            color: Theme.of(context).primaryColor,
                            size: 80,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(collectionItem.label, style: titleStyle),
                              // TODO need to be add with template
                              /*Text(
                                collection.type,
                                style: subtitleStyle
                            ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Card(

            child: Padding(
              padding: const EdgeInsets.all(5),
              child:
              ListView(

                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  Text("Id : "+collectionItem.id, style: descriptionStyle),
                  Text("Date : "+
                      DateFormat(Strings.dayFormat)
                          .format(DateTime.parse(collectionItem.obtentionDate))
                          .toString(),
                      style: descriptionStyle)
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
//
}
