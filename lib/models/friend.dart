class UserFriend {
  String? username;
  String? about;
  String? address;
  String? birthday;
  int? gender;
  String? coverImage;
  String? avartaImage;
  UserFriend(
      {this.username,
      this.about,
      this.gender,
      this.address,
      this.birthday,
      this.avartaImage,
      this.coverImage});
  // factory UserFriend.fromJson(Map<String, dynamic> responseData) {
  //   return UserFriend(
  //     username: responseData['data']['username'],   
  //     gender: responseData['data']['gender'],
  //     about: responseData['data']['about'],
  //     address: responseData['data']['address'],
  //     birthday: responseData['data']['birthday'],
  //     avartaImage: responseData['data']['avatar'],
  //     coverImage: responseData['data']['cover'],
  //   );
  // }
}
