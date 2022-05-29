class User {
  String? username;
  String? token;
  String? iduser;
  String? about;
  String? address;
  String? birthday;
  List<String>? following;
  List<String>? followers;
  int? gender;
  String? coverImage;
  String? avatarImage;

  User(
      {this.username,
      this.followers,
      this.following,
      this.token,
      this.iduser,
      this.about,
      this.gender,
      this.address,
      this.birthday,
      this.avatarImage,
      this.coverImage});
  factory User.fromJson(Map<String, dynamic> responseData, String token) {
    print(token);
    return User(
      username: responseData['data']['username'],
      followers: List<String>.from(responseData['data']['followers']),
      following: List<String>.from(responseData['data']['following']),
      token: token,
      gender: responseData['data']['gender'],
      iduser: responseData['data']['_id'],
      about: responseData['data']['about'],
      address: responseData['data']['address'],
      birthday: responseData['data']['birthday'],
      avatarImage: responseData['data']['avatar'],
      coverImage: responseData['data']['cover'],
    );
  }
}
