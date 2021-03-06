import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/template_infos_model.dart';
import 'package:gatherthem_mobile_app/models/template_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';


/// Specific service for requests to the template API
class TemplateService extends Service {
  Future<List<TemplateModel>> fetchTemplates(BuildContext context) async {
    List<dynamic> resultRequest = await getList("$apiHost/templates", context);
    return resultRequest.map((json) => TemplateModel.fromJson(json)).toList();
  }

  Future<dynamic> addTemplate(TemplateInfosModel templateInfosModel, BuildContext context) {
    return post(apiHost + "/templates", templateInfosModel.toJson(), context)
        .catchError((e){});
  }
}