class MessageModel {
  final String message;
  MessageModel({
    required this.message  
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json["message"]  
    );
  }
}