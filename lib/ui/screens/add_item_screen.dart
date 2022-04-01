import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_infos_model.dart';
import 'package:gatherthem_mobile_app/services/item_service.dart';
import 'package:gatherthem_mobile_app/ui/screens/collection_screen.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/filled_rect_button.dart';

class AddItemScreen extends StatelessWidget {
  final CollectionModel collection;
  const AddItemScreen({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemInfosModel itemInfosModel = ItemInfosModel();
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(
          children: [
            Center(
              child: Image.asset("assets/logo.png",
                  color: Colors.white.withOpacity(0.2),
                  colorBlendMode: BlendMode.modulate
              )
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 6, vertical: 20),
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("Ajouter un objet",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 30
                            )
                        ),
                        const SizedBox(height: 50),
                        Align(
                          child: Text("Libellé",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15
                              )
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        const SizedBox(height: 10),
                        Container(
                            child: TextFormField(
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                  color: Colors.black
                              ),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.all(8),
                                focusColor: Colors.transparent,
                                focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent)
                                ),
                              ),
                              onChanged: (value) {
                                itemInfosModel.label = value;
                              },
                            ),
                            decoration: BoxDecoration(
                                color: const Color(0xFFD6D6D6),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Theme.of(context).primaryColor, width: 5)
                            )
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FilledRectButton(text: "Annuler", onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CollectionScreen(collection: collection)));
                            }),
                            const SizedBox(width: 10),
                            FilledRectButton(text: "Ajouter", onPressed: (){
                              ItemService().addItem(
                                context,
                                collection,
                                itemInfosModel
                              );
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }


}