import 'package:flutter/material.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class BlocItems extends Bloc {
  List<ItemModel> _items = [];
  final _streamController = BehaviorSubject<List<ItemModel>>();

  Stream<List<ItemModel>> get stream => _streamController.stream;

  Sink<List<ItemModel>> get sink => _streamController.sink;

  fetchItems(String id, BuildContext context) async {
    var resultRequest = await CollectionService().fetchCollectionItems(id, context);
    _items = resultRequest;
    filter("");
  }

  filter(String filter) {
    var filteredItems = _items.where((item) => item.label.toLowerCase().contains(filter.toLowerCase())).toList();
    setItems(filteredItems);
  }

  setItems(List<ItemModel> items) async {
    sink.add(items);
  }

  @override
  dispose() {
    _streamController.close();
  }
}