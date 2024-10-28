import 'package:dio/dio.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/models/manage_order_model.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/order_model.dart';

class OrderRepository {
  Api api = Api();

  Future<Object> createOrder(OrderRequestModel requestModel) async {
    return await api.postOrder(Api.url, "order", requestModel);
  }

  Future<List<OrderDataModel>> getOrderForAdmin(String enpoint) async {
    var object = await api.getRequestAuth(Api.url, enpoint);
    if (object is Response) {
      return (object.data['data'] as List).map((e) => OrderDataModel.fromJson(e)).toList();
    } else {
      return <OrderDataModel>[];
    }
  } 

  Future<Object> updateStatusOrderItemForAdmin(String endPoint) async {
    var object = await api.updateStatusOrderItemForAdmin(Api.url, endPoint);
    if (object is Response) {
      return (object.data['data'] as List).map((e) => OrderDataModel.fromJson(e)).toList();
    } else {
      return MessageModel(message: "");
    }
  }

}