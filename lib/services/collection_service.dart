import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';

class CollectionService extends Service {
  Future<List<CollectionModel>> fetchCollections() async {
    List<dynamic> resultRequest = await getList(apiHost + "/collections");
    return resultRequest.map((json) => CollectionModel.fromJson(json)).toList();
  }

  Future<bool> deleteCollection(String id) async{
    return await delete(apiHost + "/collections?id=" + id);
  }
}