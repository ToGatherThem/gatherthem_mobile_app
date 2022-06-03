import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/blocs/bloc.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/item_service.dart';
import 'package:rxdart/rxdart.dart';

class BlocPublicItems extends Bloc {
  final _streamController = BehaviorSubject<List<ItemModel>>();

  Stream<List<ItemModel>> get stream => _streamController.stream;

  Sink<List<ItemModel>> get sink => _streamController.sink;

  fetchItems(BuildContext context) async {
    var resultRequest = await ItemService().fetchPublicItems(context);
    setItems(resultRequest);
  }

  setItems(List<ItemModel> items) async {
    sink.add(items);
  }

  @override
  dispose() {
    _streamController.close();
  }
}