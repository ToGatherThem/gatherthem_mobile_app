import 'package:flutter/material.dart';
import 'dart:core';
import 'package:gatherthem_mobile_app/blocs/bloc_templates.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_infos_model.dart';
import 'package:gatherthem_mobile_app/models/template_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/dialogs/error_dialog.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/autocomplete_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/text_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/modals/select_image_modal.dart';

class AddCollectionScreen extends StatelessWidget {
  final CollectionInfosModel collectionInfosModel = CollectionInfosModel();
  final String? templateFullName;
  AddCollectionScreen({Key? key, this.templateFullName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocTemplates blocTemplates = BlocTemplates();
    blocTemplates.fetchTemplates();
    SelectImageModal selectImageModal = SelectImageModal();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              children: [
                Text(Strings.createColl,
                    style: Styles.getTitleStyle(context)
                ),
                const SizedBox(height: 30),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => selectImageModal.show(context),
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
                              child: Stack(
                                  children: [
                                    Container(
                                      color: Colors.grey,
                                    ),
                                    const Center(
                                      child: Icon(Icons.image_rounded, color: Colors.white, size: 50),
                                    )
                                  ]
                              )
                          )
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: Column(
                          children: [
                            TextInput(
                              label: "Nom de la collection",
                              onChanged: (String value) {
                                collectionInfosModel.name = value;
                              },
                            ),
                            const SizedBox(height: 10),
                            StreamBuilder<List<TemplateModel>>(
                              stream: blocTemplates.stream,
                              builder: (context, snapshot) {
                                if(snapshot.hasData) {
                                  if(templateFullName != null) {
                                    collectionInfosModel.templateId = snapshot.data!.firstWhere((template) => template.fullName == templateFullName).id;
                                  }
                                  return Autocomplete<TemplateModel>(
                                    displayStringForOption: (TemplateModel option) => option.fullName,
                                    initialValue: templateFullName != null ? TextEditingValue(text: snapshot.data!.firstWhere((TemplateModel template) => template.fullName == templateFullName).fullName) : null,
                                    optionsBuilder: (TextEditingValue textEditingValue) {
                                      if (textEditingValue.text.isEmpty) {
                                        return <TemplateModel>[];
                                      } else {
                                        var templateNames = snapshot.data!.where((TemplateModel option) {
                                          return option.fullName.toLowerCase().contains(textEditingValue.text.toLowerCase());
                                        }).toList();

                                        templateNames.sort((TemplateModel a, TemplateModel b) {
                                          return a.fullName.compareTo(b.fullName);
                                        });

                                        return templateNames;
                                      }
                                    },
                                    optionsViewBuilder: (context, onSelected, options) {
                                      return Align(
                                        alignment: Alignment.topLeft,
                                        child: Material(
                                          color: Theme.of(context).dividerColor,
                                          child: ConstrainedBox(
                                            constraints: BoxConstraints(maxHeight: 250, maxWidth: MediaQuery.of(context).size.width *0.515),
                                            child: ListView.builder(
                                              physics: const BouncingScrollPhysics(),
                                                padding: EdgeInsets.zero,
                                                itemCount: options.length,
                                                shrinkWrap: true,
                                                itemBuilder: (context, index) {
                                                  final TemplateModel option = options.elementAt(index);
                                                  return ListTile(
                                                    title: Text(option.fullName),
                                                    onTap: () {
                                                      onSelected(option);
                                                    },
                                                  );
                                                }
                                            )
                                          )
                                        ),
                                      );
                                    },
                                    fieldViewBuilder: (
                                        BuildContext context,
                                        TextEditingController controller,
                                        FocusNode focusNode,
                                        VoidCallback onFieldSubmitted
                                        ) {
                                      return AutoCompleteInput(
                                          focusNode: focusNode,
                                          controller: controller,
                                          label: 'Template',
                                      );
                                    },
                                    onSelected: (TemplateModel selected) {
                                      collectionInfosModel.templateId = selected.id;
                                    },
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              },
                            ),
                          ],
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextInput(
                  label: 'Description',
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
                      text: Strings.createLabel,
                      icon: Icons.check_circle_outline_rounded,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  validate(BuildContext context, CollectionInfosModel collectionInfosModel) {
    String errorText = "";

    if (collectionInfosModel.name.trim().isEmpty) {
      errorText = Strings.collectionNameRequired;
    } else if(collectionInfosModel.templateId.trim().isEmpty) {
      errorText = Strings.templateRequired;
    }

    if (errorText != "") {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: errorText);
          }
      );
    }

    CollectionService().createCollection(
        collectionInfosModel
    ).then((value) {
      Navigator.pop(context);
      blocCollection.fetchCollections();
    });
  }

}