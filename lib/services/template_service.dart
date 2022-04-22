import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/template_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';

class TemplateService extends Service {
  Future<List<TemplateModel>> fetchTemplates() async {
    List<dynamic> resultRequest = await getList("$apiHost/templates");
    return resultRequest.map((json) => TemplateModel.fromJson(json)).toList();
  }
}