import 'package:dio/dio.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/favorite_model.dart';
import 'package:travelservices/models/message_model.dart';

class FavoriteRepository {
  
  Api api = Api();

  Future<List<FavoriteResponseModel>> getListFavorite(String endPoint) async {
    var object = await api.getRequestAuth(Api.url, endPoint);
    if (object is Response) {
      return (object.data as List).map((e) => FavoriteResponseModel.fromJson(e)).toList();
    } else {
      return <FavoriteResponseModel>[];
    }
  }

  Future<Object> insertFavorite(String endPoint, String id) async {
    var object = await api.postFavorite(Api.url, endPoint, id);
    if (object is Response) {
      return (object.data as List).map((e) => FavoriteResponseModel.fromJson(e)).toList();
    } else {
      return object;
    }
  }

  Future<Object> deleteFavorite(String endPoint, String id) async {
    var object = await api.deleteFavorite(Api.url, endPoint, id);
    if (object is Response) {
      return (object.data as List).map((e) => FavoriteResponseModel.fromJson(e)).toList();
    } else {
      return object;
    }
  }
  
}