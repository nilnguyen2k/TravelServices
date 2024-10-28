class ChatRequestModel {
  final int sendById;
  final int sendToId;
  final DateTime createDate;
  final DateTime modifiedDate;
  final String message;
  final String type;

  ChatRequestModel({
    required this.sendById,
    required this.sendToId,
    required this.createDate,
    required this.modifiedDate,
    required this.message,
    required this.type
  });

  Map<String, dynamic> toJson() => {
    "sendById": sendById,
    "sendToId": sendToId,
    "message": message,
    "type": type,
    "createDate": createDate,
    "modifiedDate": modifiedDate,
  };

}