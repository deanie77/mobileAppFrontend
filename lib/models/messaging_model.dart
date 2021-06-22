class MessagingModel {
  int sender_id;
  int receiver_id;
  String message;
  String timeSent;

  MessagingModel({this.sender_id, this.receiver_id, this.message, this.timeSent});

  factory MessagingModel.fromJson(Map<String, dynamic> responseData) {
    return MessagingModel(
        sender_id: responseData['sender_id'],
        receiver_id: responseData['receiver_id'],
        message: responseData['message'],
        timeSent: responseData['created']
    );
  }
}

class MessagingModelResponse {
  final List<MessagingModel> list;

  MessagingModelResponse({this.list});

  factory MessagingModelResponse.fromJson(List<dynamic> parsedJson) {
    List<MessagingModel> list = new List<MessagingModel>();
    list = parsedJson.map((e) => MessagingModel.fromJson(e)).toList();

    return new MessagingModelResponse(list: list);
  }
}