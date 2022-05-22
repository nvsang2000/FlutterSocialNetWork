class Post {
  String content;
  List<dynamic> images;
  int type;
  Post({required this.content, required this.images, required this.type});
  // factory Post.fromJson(Map<String, dynamic> responseData) {

  //   return Post(
  //     content: responseData['content'],
  //     images: responseData['images'],
  //     type: responseData['type'],
  //   );
  // }
}
