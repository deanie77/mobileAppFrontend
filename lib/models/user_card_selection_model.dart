class UserCardSelectionModel {
  String cardnumber;
  double id;

  UserCardSelectionModel({this.cardnumber, this.id});

  factory UserCardSelectionModel.fromJson(Map<String, dynamic> responseData) {
    return UserCardSelectionModel(
        cardnumber: responseData['cardnumber'],
        id: responseData['id']
    );
  }
}

class UserCardSelectionModelResponse {
  final List<UserCardSelectionModel> list;

  UserCardSelectionModelResponse({this.list});

  factory UserCardSelectionModelResponse.fromJson(List<dynamic> parsedJson) {
    List<UserCardSelectionModel> list = new List<UserCardSelectionModel>();
    list = parsedJson.map((e) => UserCardSelectionModel.fromJson(e)).toList();

    return new UserCardSelectionModelResponse(list: list);
  }
}