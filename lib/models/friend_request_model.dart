class FriendRequest {
  int id;

  FriendRequest({this.id});

  factory FriendRequest.fromJson(Map<String, dynamic> responseData) {
    return FriendRequest(
        id: responseData['user_one']
    );
  }
}

class FriendRequestResponse {
  final List<FriendRequest> list;

  FriendRequestResponse({this.list});

  factory FriendRequestResponse.fromJson(List<dynamic> parsedJson) {
    List<FriendRequest> list = new List<FriendRequest>();
    list = parsedJson.map((e) => FriendRequest.fromJson(e)).toList();

    return new FriendRequestResponse(list: list);
  }
}