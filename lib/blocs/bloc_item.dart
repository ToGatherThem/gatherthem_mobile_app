import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/item_service.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class BlocItem extends Bloc {
  final _streamController = BehaviorSubject<ItemModel>();

  Stream<ItemModel> get stream => _streamController.stream;

  Sink<ItemModel> get sink => _streamController.sink;

  fetchItem(String id) async {
    var resultRequest = await ItemService().fetchItem(id);
    setItem(resultRequest);
  }

  setItem(ItemModel item) async {
    sink.add(item);
  }

  @override
  dispose() {
    _streamController.close();
  }
}
