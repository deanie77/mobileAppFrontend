class UserMessages {
  String username;
  String email;
  int id;

  UserMessages({this.username, this.email, this.id});

  factory UserMessages.fromJson(Map<String, dynamic> responseData) {
    return UserMessages(
        id: responseData['id'],
        username: responseData['username'],
        email: responseData['email']
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email
  };
}