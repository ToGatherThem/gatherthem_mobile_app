import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc_item.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/item_infos_model.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/item_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/filled_rect_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/dialogs/error_dialog.dart';

class EditItemScreen extends StatelessWidget {
  final ItemModel item;
  final String collectionId;
  final BlocItem? blocSingleItem;
  final ItemInfosModel itemInfosModel = ItemInfosModel();
  EditItemScreen({Key? key, required this.item, required this.collectionId, this.blocSingleItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    itemInfosModel.label = item.label;
    itemInfosModel.obtentionDate = item.obtentionDate;
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
                      Text(Strings.itemEdit,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30
                          )
                      ),
                      const SizedBox(height: 50),
                      Align(
                        child: Text(Strings.itemLabel,
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
                            initialValue: itemInfosModel.label,
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
                      Align(
                        child: Text(Strings.itemObtentionDate,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15
                            )
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      const SizedBox(height: 10),
                      Container(
                          child: DateTimePicker(
                            type: DateTimePickerType.date,
                            dateMask: Strings.dateMask,
                            locale: const Locale("fr", "FR"),
                            firstDate: DateTime(1970),
                            lastDate: DateTime.now(),
                            // initialDate: DateTime.now().toString(),
                            timePickerEntryModeInput: true,
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
                            initialValue: DateTime.parse(itemInfosModel.obtentionDate).toLocal().toIso8601String(),
                            onChanged: (value) {
                              itemInfosModel.obtentionDate = value;
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
                          FilledRectButton(text: Strings.cancelLabel, onPressed: (){
                            Navigator.pop(context);
                          }),
                          const SizedBox(width: 10),
                          FilledRectButton(text: Strings.editLabel, onPressed: (){
                            validate(context, itemInfosModel);
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

  validate(BuildContext context, ItemInfosModel itemInfosModel) {
    String errorText = "";

    if (itemInfosModel.label.trim().isEmpty) {
      errorText = Strings.itemLabelRequired;
    } else if (itemInfosModel.obtentionDate.trim().isEmpty) {
      errorText = Strings.itemObtentionDateRequired;
    }

    if (errorText != "") {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: errorText);
          }
      );
    }

    ItemService().editItem(
        item.id,
        itemInfosModel,
        context
    ).then((value) {
      Navigator.pop(context);
      if(blocSingleItem == null) {
        blocItems.fetchItems(collectionId, context);
      }
      else{
        blocSingleItem!.fetchItem(item.id, context);
      }
    });
  }

}