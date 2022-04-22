import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class BlocItem extends Bloc {
  final _streamController = BehaviorSubject<List<ItemModel>>();

  Stream<List<ItemModel>> get stream => _streamController.stream;

  Sink<List<ItemModel>> get sink => _streamController.sink;

  fetchItems(String id) async {
    var resultRequest = await CollectionService().fetchCollectionItems(id);
    setItems(resultRequest);
  }

  setItems(List<ItemModel> collections) async {
    sink.add(collections);
  }

  @override
  dispose() {
    _streamController.close();
  }
}
