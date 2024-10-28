import 'package:dio/dio.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/area_model.dart';

class AreaRepository {
  Api api = Api();

  Future<List<AreaData>> getListArea(String endPoint) async {
    Response response;
    response = await api.getRequest(Api.url, endPoint);
    return (response.data as List).map((e) => AreaData.fromJson(e)).toList();
  }
  
}