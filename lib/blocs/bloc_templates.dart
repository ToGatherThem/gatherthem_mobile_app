import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc.dart';
import 'package:gatherthem_mobile_app/models/template_model.dart';
import 'package:gatherthem_mobile_app/services/template_service.dart';
import 'package:rxdart/rxdart.dart';

class BlocTemplates extends Bloc {
  final _streamController = BehaviorSubject<List<TemplateModel>>();

  Stream<List<TemplateModel>> get stream => _streamController.stream;

  Sink<List<TemplateModel>> get sink => _streamController.sink;

  fetchTemplates(BuildContext context) async {
    var resultRequest = await TemplateService().fetchTemplates(context);
    setTemplates(resultRequest);
  }

  setTemplates(List<TemplateModel> templates) async {
    sink.add(templates);
  }

  List<TemplateModel> getTemplates() {
    return _streamController.value;
  }

  @override
  dispose() {
    _streamController.close();
  }
}