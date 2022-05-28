class ApiUrl {
  static const String url = 'https://yue-backend-netword.herokuapp.com/api/';
  static const String loginUrl = url + 'auth/login';
  static const String signupUrl = url + 'auth/register';
  static const String logoutUrl = url + 'auth/logout';
  static const String profileUrl = url + 'user/profile/';
  static const String updateAvatar = url + 'user/upload-avatar';
  static const String updateCover = url + 'user/upload-cover';
  static const String imageUrl =
      'https://yue-backend-netword.herokuapp.com/uploads/avatars/';
  static const String newPostUrl = url + 'user/new-post';
  static const String getAllPostUrl = url + 'all-post/';
  static const String getPostUserUrl = url + 'user/get-post/';
  static const String likePost = url + 'user/like-post/';
  static const String getAllUser = url + 'all-user';
  static const String followUrl = url + 'user/follow/';
  static const String unfollowUrl = url + 'user/un-follow/';
}
