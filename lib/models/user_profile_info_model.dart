class UserProfileInfoModel{
  String first_name;
  String last_name;
  String username;
  String email;

  UserProfileInfoModel({
    this.first_name,
    this.last_name,
    this.username,
    this.email
  });

  factory UserProfileInfoModel.fromJson(Map<String, dynamic> responseData) {
    return UserProfileInfoModel(
        email: responseData['email'],
        first_name: responseData['first_name'],
        last_name:  responseData['last_name'],
        username: responseData['username']
    );
  }
}