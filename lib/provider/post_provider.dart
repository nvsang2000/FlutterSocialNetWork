import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:test/api/api_url.dart';
import 'package:test/models/post.dart';
import 'package:test/models/users.dart';

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
  Future<List<Post>> getAllPost(List<Users> list, String id) async {
    List<Post> listNewPost = [];
    List<String> allID = [id];
    Response response = await get(
      Uri.parse(ApiUrl.getAllPostUrl),
    );
    list.forEach((element) {
      allID.add(element.iduser!);
    });
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (Map i in responseData['posts']) {
        for (String p in allID) {
          if (p != i['ownerid']['_id']) continue;
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
      }
    } else {
      throw Exception('Failed to load.');
    }
    notifyListeners();
    return listPost;
  }

  get getAllList {
    return listPost;
  }

  List<Post> listPostForUser = [];
  Future<List<Post>> getAllPostForUser(String id) async {
    List<Post> listNewPostForUser = [];
    Response response = await get(
      Uri.parse(ApiUrl.getAllPostUrl),
    );

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (Map i in responseData['posts']) {
        if (i['ownerid']['_id'] != id) continue;
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
        listNewPostForUser.add(post);
        listPostForUser = listNewPostForUser;
      }
    } else {
      throw Exception('Failed to load.');
    }
    notifyListeners();
    return listPostForUser;
  }

  get getAllListForUser {
    return listPostForUser;
  }

  List<Post> listPostUser = [];
  Future<List<Post>> getAllPostUser(String token) async {
    List<Post> listNewPostUser = [];
    Response response = await get(Uri.parse(ApiUrl.getPostUserUrl),
        headers: {'Authorization': 'Bearer ' + token});

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (Map i in responseData['posts']) {
        if (i['ownerid'] == null) continue;
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
    } else {
      throw Exception('Failed to load.');
    }
    notifyListeners();
    return listPostUser;
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

  Future<void> deletePost(String id, String token) async {
    Response response = await post(Uri.parse(ApiUrl.deletePost),
        body: {'postID': id}, headers: {'Authorization': 'Bearer ' + token});
    if (response.statusCode == 200) {
      print('ok');
    } else
      print(response.statusCode);
  }
}
