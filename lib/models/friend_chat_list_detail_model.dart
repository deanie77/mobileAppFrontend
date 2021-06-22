class FriendChatListDetail {
  String username;
  String email;
  String avatar;
  int id;

  FriendChatListDetail({this.username, this.email, this.avatar, this.id});

  factory FriendChatListDetail.fromJson(Map<String, dynamic> responseData) {
    return FriendChatListDetail(
        email: responseData['email'],
        username: responseData['username'],
        avatar: responseData['avatar'],
        id: responseData['id'].toInt()
    );
  }
}