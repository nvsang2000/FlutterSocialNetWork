class User {
  String? username;
  String? token;
  User({this.username, this.token});
  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(username: responseData['email'], token: responseData['token']);
  }
}
