import 'package:gatherthem_mobile_app/blocs/bloc.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/services/collection_service.dart';
import 'package:rxdart/rxdart.dart';

class BlocPublicCollections extends Bloc {
  final _streamController = BehaviorSubject<List<CollectionModel>>();

  Stream<List<CollectionModel>> get stream => _streamController.stream;

  Sink<List<CollectionModel>> get sink => _streamController.sink;

  fetchCollections() async {
    var resultRequest = await CollectionService().fetchPublicCollections();
    setCollections(resultRequest);
  }

  setCollections(List<CollectionModel> collections) async {
    sink.add(collections);
  }

  @override
  dispose() {
    _streamController.close();
  }
}