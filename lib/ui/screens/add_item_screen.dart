import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_infos_model.dart';
import 'package:gatherthem_mobile_app/models/property_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/dialogs/error_dialog.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/property_input.dart';

class AddItemScreen extends StatelessWidget {
  final CollectionModel collection;
  final ItemInfosModel itemInfosModel = ItemInfosModel();
  AddItemScreen({Key? key, required this.collection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    itemInfosModel.obtentionDate = DateTime.now().toLocal().toIso8601String();
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              RichText(text: TextSpan(
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                children: <TextSpan>[
                  const TextSpan(
                    text: "Ajouter un objet à "
                  ),
                  TextSpan(
                    text: collection.name,
                    style: TextStyle(
                      color: Theme.of(context).highlightColor
                    )
                  )
                ]
              )),
              SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 115,
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1
                        )
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: Image.network(
                          "https://m.media-amazon.com/images/I/51rdksF61YL._SL500_.jpg",
                        )
                      )
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: "${collection.template?.itemLabelName}",
                            ),
                            onChanged: (value) {
                              itemInfosModel.label = value;
                            },
                          ),
                          const SizedBox(height: 10),
                          DateTimePicker(
                            type: DateTimePickerType.date,
                            dateMask: "d MMMM yyyy",
                            locale: const Locale("fr", "FR"),
                            firstDate: DateTime(1970),
                            lastDate: DateTime.now(),
                            timePickerEntryModeInput: true,
                            decoration: const InputDecoration(
                              labelText: "Date d'obtention",
                            ),
                            initialValue: itemInfosModel.obtentionDate,
                            onChanged: (value) {
                              itemInfosModel.obtentionDate = value;
                            },
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
              for(PropertyModel property in collection.template?.allProperties ?? []) PropertyInput(property: property),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: Strings.cancelLabel,
                    backgroundColor: Colors.grey,
                    icon: Icons.close_rounded,
                  ),
                  const SizedBox(width: 10),
                  ActionButton(
                    onPressed: () {
                      validate(context, itemInfosModel);
                    },
                    text: Strings.createLabel,
                    icon: Icons.check_circle_outline_rounded,
                  ),
                ],
              ),
            ],
          ),
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

    CollectionService().addItem(
        collection,
        itemInfosModel
    ).then((value) {
      Navigator.pop(context);
      blocItems.fetchItems(collection.id);
    });
  }
}