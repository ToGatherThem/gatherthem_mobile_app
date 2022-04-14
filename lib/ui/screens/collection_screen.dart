import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/widgets/navigation_scaffold_widget.dart';
import 'package:intl/intl.dart';
import '../widgets/navigation_scaffold_widget.dart';

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key, required this.collection}) : super(key: key);
  final CollectionModel collection;

  @override
  Widget build(BuildContext context) {
    currentCollection = collection;
    Widget body = bodyConfig(collection: collection, context: context);
    return NavigationScaffoldWidget(body: body, leading: true);
  }

  Widget bodyConfig({required CollectionModel collection, required BuildContext context}) {
    TextStyle titleStyle = const TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
    TextStyle subtitleStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    TextStyle descriptionStyle = const TextStyle(fontSize: 16);
    return Scaffold(
        body:Column(
          children: [
            SizedBox(
      width : MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/3,
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
                          Icons.add_photo_alternate_outlined,
                          color: Theme.of(context).primaryColor,
                          size: 80,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                collection.name,
                                style: titleStyle
                            ),
                            // TODO need to be add with template
                            /*Text(
                                collection.type,
                                style: subtitleStyle
                            ),*/
                            Text(
                                DateFormat(Strings.dayFormat).format(DateTime.parse(collection.creationDate)).toString(),
                                style: subtitleStyle
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 10)),
                  Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width/1.2,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Card(
                          elevation: 0,
                          margin: EdgeInsets.zero,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            child: Text(
                              collection.description,
                              style: descriptionStyle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    ),
            StreamBuilder<List<CollectionModel>>(
              stream: blocCollection.stream,
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Container();//TODO loading
                }

                return ListView(
                  shrinkWrap : true,
                  physics: const BouncingScrollPhysics(),

                  children: snapshot.data!.map((collection)
                      {return Padding(
                        padding: const EdgeInsets.only(left: 400, right: 400),
                        child: Card(
                          elevation: 0,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(top: 20, bottom: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               // Text(collection.items.first.toString()),
                                Text(collection.creationDate.toString()),

                              ],
                            ),
                          ),
                        ),
                      );}
                  ).toList(),);
              }
            ) ],
          )

    );
  }
}
