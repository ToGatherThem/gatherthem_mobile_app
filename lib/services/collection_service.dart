import 'package:gatherthem_mobile_app/globals.dart';
import 'package:gatherthem_mobile_app/models/collection_infos_model.dart';
import 'package:gatherthem_mobile_app/models/collection_model.dart';
import 'package:gatherthem_mobile_app/models/item_infos_model.dart';
import 'package:gatherthem_mobile_app/models/item_model.dart';
import 'package:gatherthem_mobile_app/services/service.dart';


class CollectionService extends Service {

  Future<dynamic> createCollection(CollectionInfosModel collectionInfosModel) {
    return post(apiHost + "/collections", collectionInfosModel.toJson());
  }

  Future<List<CollectionModel>> fetchCollections() async {
    List<dynamic> resultRequest = await getList(apiHost + "/collections");
    return resultRequest.map((json) => CollectionModel.fromJson(json)).toList();
  }
  Future<List<ItemModel>> fetchCollectionItems(String id) async {
    List<dynamic> resultRequest = await getList(apiHost + "/collections/"+id+"/items");
    return resultRequest.map((json) => ItemModel.fromJson(json)).toList();
  }

  Future<bool> deleteCollection(String id) async{
    return await delete(apiHost + "/collections?id=" + id);
  }

  Future<dynamic> editCollection(CollectionInfosModel collectionInfosModel, String id) {
    return put(apiHost + "/collections?id="+id, collectionInfosModel.toJson());
  }

  Future<dynamic> addItem( CollectionModel collectionModel, ItemInfosModel itemInfosModel) {
    String url = apiHost + "/collections/" + collectionModel.id + "/items";
    return post(url, itemInfosModel.toJson());
  }

  Future<List<CollectionModel>> fetchPublicCollections() async {
    List<dynamic> resultRequest = await getList(apiHost + "/collections/public");
    return resultRequest.map((json) => CollectionModel.fromJson(json)).toList();
  }
}