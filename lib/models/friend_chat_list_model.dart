class FriendChatList {
  int user_one;
  int user_two;
  int status;

  FriendChatList({this.user_one, this.user_two, this.status});

  factory FriendChatList.fromJson(Map<String, dynamic> responseData) {
    return FriendChatList(
        user_one: responseData['user_one'],
        user_two: responseData['user_two'],
        status: responseData['status']
    );
  }
}

class FriendChatListResponse {
  final List<FriendChatList> list;

  FriendChatListResponse({this.list});

  factory FriendChatListResponse.fromJson(List<dynamic> parsedJson) {
    List<FriendChatList> list = new List<FriendChatList>();
    list = parsedJson.map((e) => FriendChatList.fromJson(e)).toList();

    return new FriendChatListResponse(list: list);
  }
}