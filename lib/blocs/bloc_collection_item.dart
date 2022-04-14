
import 'package:rxdart/rxdart.dart';

import '../models/collection_item_model.dart';
import '../services/collection_service.dart';
import 'bloc.dart';

class BlocCollectionItem extends Bloc {
  final _streamController = BehaviorSubject<List<CollectionItemModel>>();

  Stream<List<CollectionItemModel>> get stream => _streamController.stream;

  Sink<List<CollectionItemModel>> get sink => _streamController.sink;

  fetchCollections(String id) async {
    var resultRequest = await CollectionService().fetchCollectionItems(id);
    setCollections(resultRequest);
  }

  setCollections(List<CollectionItemModel> collections) async {
    sink.add(collections);
  }

  @override
  dispose() {
    _streamController.close();
  }
}
