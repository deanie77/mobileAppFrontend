class FriendRequestsModel {
  String username;
  String email;

  FriendRequestsModel({this.username, this.email});

  factory FriendRequestsModel.fromJson(Map<String, dynamic> responseData) {
    return FriendRequestsModel(
        email: responseData['email'],
        username: responseData['username']
    );
  }
}