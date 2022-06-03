import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_infos_model.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/dialogs/error_dialog.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/text_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/modals/select_image_modal.dart';

class EditCollectionScreen extends StatefulWidget {
  const EditCollectionScreen({Key? key, required this.collection}) : super(key: key);
  final CollectionModel collection;

  @override
  State<EditCollectionScreen> createState() => _EditCollectionScreenState();
}

class _EditCollectionScreenState extends State<EditCollectionScreen> {
  final CollectionInfosModel collectionInfosModel = CollectionInfosModel();
  @override
  void initState() {
    collectionInfosModel.name = widget.collection.name;
    collectionInfosModel.description = widget.collection.description;
    collectionInfosModel.image = widget.collection.image;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SelectImageModal selectImageModal = SelectImageModal();
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: ScrollConfiguration(
          behavior:
              ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Column(
                children: [
                  Text(
                      Strings.collectionEdit,
                      style: Styles.getTitleStyle(context)
                  ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => selectImageModal.show(
                            context: context,
                            onImageSelected: (Uint8List? image) {
                              collectionInfosModel.image = image;
                              setState(() {});
                            },
                            onImageRemove: (collectionInfosModel.image != null) ? () {
                              collectionInfosModel.image = null;
                              setState(() {});
                            } : null
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
                                child: (collectionInfosModel.image == null) ? Stack(
                                    children: [
                                      Container(
                                        color: Colors.grey,
                                      ),
                                      const Center(
                                        child: Icon(Icons.image_rounded, color: Colors.white, size: 50),
                                      )
                                    ]
                                ) : Image(
                                  image: MemoryImage(collectionInfosModel.image!),
                                  fit: BoxFit.cover,
                                )
                            )
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextInput(
                          label: Strings.collectionEditName,
                          initialValue: widget.collection.name,
                          maxLength: 50,
                          onChanged: (String value) {
                            collectionInfosModel.name = value;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  TextInput(
                    label: Strings.collectionEditDescription,
                    initialValue: widget.collection.description,
                    onChanged: (String value) {
                      collectionInfosModel.description = value;
                    },
                    minLines: 1,
                    maxLines: 10,
                    maxLength: 1000,
                  ),
                  const SizedBox(height: 30),
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
                          validate(context, collectionInfosModel);
                        },
                        width: 110,
                        text: Strings.editLabel,
                        icon: Icons.check_circle_outline_rounded,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  validate(BuildContext context, CollectionInfosModel collectionInfosModel) {
    String errorText = "";

    if (collectionInfosModel.name.trim().isEmpty) {
      errorText = Strings.collectionNameRequired;
    }

    if (errorText != "") {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: errorText);
          }
      );
    }

    CollectionService().editCollection(
        collectionInfosModel,
        widget.collection.id,
        context
    ).then((value) {
      Navigator.pop(context);
      blocCollection.fetchCollections(context);
    });
  }
}
