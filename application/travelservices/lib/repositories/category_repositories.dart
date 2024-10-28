import 'package:dio/dio.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/category_model.dart';

class CategoryRepository {
  Api api = Api();

  Future<List<CategoryData>> getListCategories(String endPoint) async {
    Response response;
    response = await api.getRequest(Api.url, endPoint);
    return (response.data as List).map((e) => CategoryData.fromJson(e)).toList();
  }
}