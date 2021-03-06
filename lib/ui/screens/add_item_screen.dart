import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_infos_model.dart';
import 'package:gatherthem_mobile_app/models/property_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/dialogs/error_dialog.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/date_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/property_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/modals/select_image_modal.dart';

import '../widgets/inputs/text_input.dart';

class AddItemScreen extends StatefulWidget {
  final CollectionModel collection;

  const AddItemScreen({Key? key, required this.collection}) : super(key: key);

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final ItemInfosModel itemInfosModel = ItemInfosModel();

  @override
  Widget build(BuildContext context) {
    SelectImageModal selectImageModal = SelectImageModal();

    itemInfosModel.obtentionDate = DateTime.now().toLocal().toIso8601String();
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            children: [
              RichText(text: TextSpan(
                style: Styles.getTitleStyle(context),
                children: <TextSpan>[
                  const TextSpan(
                    text: Strings.addItemToCollection
                  ),
                  TextSpan(
                    text: widget.collection.name,
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
                    InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () => selectImageModal.show(
                          context: context,
                          onImageSelected: (image) {
                            itemInfosModel.image = image;
                            setState(() {});
                          },
                          onImageRemove: (itemInfosModel.image != null) ? () {
                            itemInfosModel.image = null;
                            setState(() {});
                          } : null,
                      ),
                      child: Container(
                        height: 115,
                        width: 115,
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
                          child: (itemInfosModel.image == null) ? Stack(
                            children: [
                              Container(
                                color: Colors.grey,
                              ),
                              const Center(
                                child: Icon(Icons.image_rounded, color: Colors.white, size: 50),
                              )
                            ]
                          ) : Image(
                            image: MemoryImage(itemInfosModel.image!),
                            fit: BoxFit.cover,
                          )
                        )
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        children: [
                          TextInput(
                            label: widget.collection.template.itemLabelName,
                            maxLength: 50,
                            onChanged: (String value) {
                              itemInfosModel.label = value;
                            },
                          ),
                          DateInput(
                            label: Strings.itemObtentionDate,
                            firstDate: DateTime(1700),
                            lastDate: DateTime.now().add(const Duration(days: 60)),
                            defaultValue: itemInfosModel.obtentionDate,
                            onChanged: (String value) {
                              itemInfosModel.obtentionDate = value;
                            },
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
              for(PropertyModel property in widget.collection.template.allProperties) PropertyInput(
                  property: property,
                  onChanged: (String value) {
                    itemInfosModel.setProperty('', property.id, value);
                  }
              ),
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
        widget.collection,
        itemInfosModel,
        context
    ).then((value) {
      Navigator.pop(context);
      blocItems.fetchItems(widget.collection.id, context);
    });
  }
}