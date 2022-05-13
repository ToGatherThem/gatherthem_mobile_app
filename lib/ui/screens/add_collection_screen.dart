import 'package:flutter/material.dart';
import 'dart:core';
import 'package:gatherthem_mobile_app/blocs/bloc_templates.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_infos_model.dart';
import 'package:gatherthem_mobile_app/models/template_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/filled_rect_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/dialogs/error_dialog.dart';

class AddCollectionScreen extends StatelessWidget {
  final CollectionInfosModel collectionInfosModel = CollectionInfosModel();
  final String? templateFullName;
  AddCollectionScreen({Key? key, this.templateFullName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocTemplates blocTemplates = BlocTemplates();
    blocTemplates.fetchTemplates();
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
                      Text(Strings.createColl,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30
                          )
                      ),
                      const SizedBox(height: 30),
                      Align(
                        child: Text(Strings.labelTemplate,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 15
                            )
                        ),
                        alignment: Alignment.centerLeft,
                      ),
                      const SizedBox(height: 10),
                      StreamBuilder<List<TemplateModel>>(
                        stream: blocTemplates.stream,
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {
                            if(templateFullName != null) {
                              collectionInfosModel.templateId = snapshot.data!.firstWhere((template) => template.fullName == templateFullName).id;
                            }
                            return Container(
                              child: Autocomplete<TemplateModel>(
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
                                fieldViewBuilder: (
                                    BuildContext context,
                                    TextEditingController controller,
                                    FocusNode focusNode,
                                    VoidCallback onFieldSubmitted
                                ) {
                                  return TextFormField(
                                    controller: controller,
                                    focusNode: focusNode,
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
                                  );
                                },
                                onSelected: (TemplateModel selected) {
                                  collectionInfosModel.templateId = selected.id;
                                },
                              ),
                              decoration: BoxDecoration(
                                  color: const Color(0xFFD6D6D6),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Theme.of(context).primaryColor, width: 5)
                              )
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                      const SizedBox(height: 30),
                      Align(
                        child: Text(Strings.labelName,
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
                              collectionInfosModel.name = value;
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
                        child: Text(Strings.labelDesc,
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
                            minLines: 4,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
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
                              collectionInfosModel.description = value;
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
                          FilledRectButton(text: Strings.createLabel, onPressed: (){
                            validate(context, collectionInfosModel);
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]
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