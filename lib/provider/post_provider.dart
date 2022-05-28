import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:test/api/api_url.dart';
import 'package:test/models/post.dart';

class PostProvider extends ChangeNotifier {
  Future<StreamedResponse> newPost(
      String token, String content, String type, File image) async {
    String name = image.path.split("/").last;
    var request = MultipartRequest('POST', Uri.parse(ApiUrl.newPostUrl));

    request.fields['content'] = content;
    request.fields['type'] = type;
    // request.fields['type'] = type;
    request.files.add(
      await MultipartFile(
          'upload_posts', image.readAsBytes().asStream(), image.lengthSync(),
          contentType: MediaType('image', 'jpg'), filename: name),
    );
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ' + token
    });

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("upload ok");
    } else {
      print("upload fail");
    }
    return response;
  }

  List<Post> listPost = [];
  Future<List<Post>> getAllPost() async {
    List<Post> listNewPost = [];
    Response response = await get(
      Uri.parse(ApiUrl.getAllPostUrl),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (Map i in responseData['posts']) {
        Post post = await Post(
            id: i['_id'],
            userID: i['ownerid']['_id'],
            like: i['like'],
            content: i['content'],
            images: i['images'],
            type: i['type'],
            avatar: i['ownerid']['avatar'],
            createdAt: i['createdAt'],
            username: i['ownerid']['username']);
        listNewPost.add(post);
        listPost = listNewPost;
      }

      notifyListeners();
      return listPost;
    } else {
      throw Exception('Failed to load.');
    }
  }

  get getAllList {
    return listPost;
  }
  List<Post> listPostUser = [];
  Future<List<Post>> getAllPostUser(String token) async {
    List<Post> listNewPostUser = [];
    Response response = await get(
      Uri.parse(ApiUrl.getPostUserUrl),headers: {'Authorization':'Bearer '+token}
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (Map i in responseData['posts']) {
        Post post = await Post(
            id: i['_id'],
            userID: i['ownerid']['_id'],
            like: i['like'],
            content: i['content'],
            images: i['images'],
            type: i['type'],
            avatar: i['ownerid']['avatar'],
            createdAt: i['createdAt'],
            username: i['ownerid']['username']);
        listNewPostUser.add(post);
        listPostUser = listNewPostUser;
      }

      notifyListeners();
      return listPostUser;
    } else {
      throw Exception('Failed to load.');
    }
  }

  get getPostUserList {
    return listPostUser;
  }

  Future<void> likePost(String token, String id) async {
    Map<String, dynamic> body = {'statusLike': '1'};

    Response response = await put(Uri.parse(ApiUrl.likePost + id),
        body: body, headers: {'Authorization': 'Bearer ' + token});
    print(response.bodyBytes);
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      print(responseData['message']);
    } else
      throw Exception('Failed to load.');
  }

  notify() {
    notifyListeners();
  }
}
