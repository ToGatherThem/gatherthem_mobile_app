import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:core';
import 'package:gatherthem_mobile_app/blocs/bloc_templates.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_infos_model.dart';
import 'package:gatherthem_mobile_app/models/property_creation_model.dart';
import 'package:gatherthem_mobile_app/models/template_infos_model.dart';
import 'package:gatherthem_mobile_app/models/template_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:gatherthem_mobile_app/services/template_service.dart';
import 'package:gatherthem_mobile_app/theme/strings.dart';
import 'package:gatherthem_mobile_app/theme/styles.dart';
import 'package:gatherthem_mobile_app/ui/widgets/buttons/action_button.dart';
import 'package:gatherthem_mobile_app/ui/widgets/dialogs/error_dialog.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/autocomplete_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/inputs/text_input.dart';
import 'package:gatherthem_mobile_app/ui/widgets/modals/select_image_modal.dart';
import 'package:gatherthem_mobile_app/utils.dart';

class AddTemplateScreen extends StatefulWidget {
  final String? parentName;
  const AddTemplateScreen({Key? key, this.parentName}) : super(key: key);

  @override
  State<AddTemplateScreen> createState() => _AddTemplateScreenState();
}

class _AddTemplateScreenState extends State<AddTemplateScreen> {
  final TemplateInfosModel templateInfosModel = TemplateInfosModel();
  PropertyCreationModel propertyCreationModel = PropertyCreationModel();

  @override
  Widget build(BuildContext context) {
    templateInfosModel.parentId = blocTemplates.getTemplates().firstWhere((template) => template.fullName == widget.parentName).id;

    blocTemplates.fetchTemplates(context);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.createTemplateLabel,
                    style: Styles.getTitleStyle(context)
                ),
                const SizedBox(height: 30),
                TextInput(
                  label: Strings.createTemplateInputName,
                  maxLength: 50,
                  onChanged: (String value) {
                    templateInfosModel.name = value;
                  },
                ),
                TextInput(
                  label: Strings.collectionEditDescription,
                  onChanged: (String value) {
                    templateInfosModel.description = value;
                  },
                  minLines: 1,
                  maxLines: 10,
                  maxLength: 1000,
                ),
                StreamBuilder<List<TemplateModel>>(
                  stream: blocTemplates.stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return Autocomplete<TemplateModel>(
                        displayStringForOption: (TemplateModel option) => option.fullName,
                        initialValue: widget.parentName != null ? TextEditingValue(text: snapshot.data!.firstWhere((TemplateModel template) => template.fullName == widget.parentName).fullName) : null,
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
                          controller.addListener(() {
                            if(blocTemplates.getTemplates().where((element) => element.fullName == controller.text).isEmpty) {
                              setState(() {
                                templateInfosModel.parentId = "";
                              });
                            }
                          });
                          return AutoCompleteInput(
                            focusNode: focusNode,
                            controller: controller,
                            label: Strings.createTemplateInputTemplateParent,
                          );
                        },
                        onSelected: (TemplateModel selected) {
                          templateInfosModel.parentId = selected.id;
                          setState(() {

                          });
                        },
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SizedBox(height: 30),
                TextInput(
                  label: Strings.createTemplateInputItemLabelName,
                  onChanged: (String value) {
                    templateInfosModel.itemLabelName = value;
                  },
                  initialValue: templateInfosModel.itemLabelName,
                  maxLength: 20,
                ),
                const SizedBox(height: 10),
                const Text("Ajouter une propriété", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                TextInput(
                    label: "Nom",
                    onChanged: (String value) {
                      setState(() {
                        propertyCreationModel.name = value;
                      });
                    }
                ),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      DropdownButton<String>(
                        value: (propertyCreationModel.type.isNotEmpty) ? propertyCreationModel.type : "TEXT",
                        onChanged: (value) {
                          setState(() {
                            propertyCreationModel.type = value!;
                          });
                        },
                        items: const [
                          DropdownMenuItem<String>(
                            value: "TEXT",
                            child: Text("Texte"),
                          ),
                          DropdownMenuItem<String>(
                            value: "LONGTEXT",
                            child: Text("Texte long"),
                          ),
                          DropdownMenuItem<String>(
                            value: "INTEGER",
                            child: Text("Nombre"),
                          ),
                          DropdownMenuItem<String>(
                            value: "DATE",
                            child: Text("Date"),
                          ),
                          DropdownMenuItem<String>(
                            value: "DURATION",
                            child: Text("Durée"),
                          ),
                        ],
                      ),
                      const Spacer(),
                      ActionButton(
                        onPressed: () {
                          setState(() {
                            if(propertyCreationModel.name.isNotEmpty && propertyCreationModel.type.isNotEmpty) {
                              PropertyCreationModel property = PropertyCreationModel();
                              property.name = propertyCreationModel.name;
                              property.type = propertyCreationModel.type;
                              templateInfosModel.properties.add(property);
                            }
                          });
                        },
                        width: 25,
                        icon: Icons.add,
                        backgroundColor: (propertyCreationModel.name.isNotEmpty && propertyCreationModel.type.isNotEmpty) ? Theme.of(context).highlightColor : Colors.grey,
                        color: (propertyCreationModel.name.isNotEmpty && propertyCreationModel.type.isNotEmpty) ? Colors.white : Colors.grey[400],
                      )
                    ]
                ),
                const SizedBox(height: 20),
                const Text(Strings.properties, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 10),
                for(var property in templateInfosModel.properties) Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Row(
                      children: [
                        Text(property.name),
                        const Spacer(),
                        Text(Utils.propertyTypeToHumanText(property.type)),
                        const SizedBox(width: 10),
                        InkWell(
                          child: const Icon(Icons.highlight_remove_rounded, color: Colors.red, size: 20),
                          onTap: () {
                            setState(() {
                              templateInfosModel.properties.remove(property);
                            });
                          },
                        ),
                      ]
                  ),
                ),
                const SizedBox(height: 20),
                if(templateInfosModel.parentId.isNotEmpty) for(var property in blocTemplates.getTemplates().where((element) => element.id == templateInfosModel.parentId).first.allProperties) Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      Text(property.name),
                      const Spacer(),
                      Text(Utils.propertyTypeToHumanText(property.type)),
                      const SizedBox(width: 30),
                    ]
                  ),
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
                        validate(context, templateInfosModel);
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

  validate(BuildContext context, TemplateInfosModel templateInfosModel) {
    String errorText = "";

    if (templateInfosModel.name.trim().isEmpty) {
      errorText = Strings.collectionNameRequired;
    } else if(templateInfosModel.itemLabelName.trim().isEmpty) {
      errorText = Strings.itemLabelNameRequired;
    }

    if (errorText != "") {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: errorText);
          }
      );
    }

    TemplateService().addTemplate(templateInfosModel, context).then((value) {
      Navigator.pop(context);
      blocTemplates.fetchTemplates(context);
    });
  }
}