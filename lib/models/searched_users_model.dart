class SearchedUsersModel {
  String username;
  String email;
  int id;

  SearchedUsersModel({this.username, this.email, this.id});

  factory SearchedUsersModel.fromJson(Map<String, dynamic> responseData) {
    return SearchedUsersModel(
        username: responseData['username'],
        email: responseData['email'],
        id: responseData['id'].toInt()
    );
  }
}

class SearchedUserModelResponse {
  final List<SearchedUsersModel> list;

  SearchedUserModelResponse({this.list});

  factory SearchedUserModelResponse.fromJson(List<dynamic> parsedJson) {
    List<SearchedUsersModel> list = new List<SearchedUsersModel>();
    list = parsedJson.map((e) => SearchedUsersModel.fromJson(e)).toList();

    return new SearchedUserModelResponse(list: list);
  }
}