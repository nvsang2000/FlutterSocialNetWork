import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:test/api/api_url.dart';
import 'package:test/models/comments.dart';
import 'package:test/models/rep_comment.dart';

class CommentProvider extends ChangeNotifier {
  Future<void> addComment(String id, String token, String comment) async {
    Response response = await post(Uri.parse(ApiUrl.addComment + id),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        },
        body: json.encode({'message': comment}));
    if (response.statusCode == 200) {
      print('ok');
    } else
      print("addComment ${response.statusCode}");
  }

  List<Comments> commentsList = [];
  Future<List<Comments>> getComment(String id, String token) async {
    List<Comments> newComments = [];
    Response response = await get(Uri.parse(ApiUrl.addComment + id), headers: {
      'Authorization': 'Bearer ' + token,
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      for (Map i in responseData['comments']) {
        Comments comments = await Comments(
            iduser: i['userid']['_id'],
            idcomment: i['_id'],
            repComment: i['rep_comment'],
            idpost: i['postid'],
            image: i['userid']['avatar'],
            message: i['message'],
            username: i['userid']['username'],
            time: i['createdAt']);
        newComments.add(comments);
        commentsList = newComments;

        // notifyListeners();
      }
      commentsList = newComments;
      // print(newComments.length);
      return newComments;
    } else {
      print("getComment ${response.statusCode}");
      return newComments;
    }
  }

  get clearComment {
    return commentsList = [];
  }

  get commentList {
    // commentsList.clear();
    return commentsList;
  }

  Future<void> deleteCmt(String idpost, String idcomment, String token) async {
    var body = {'commentID': idcomment};
    Response response = await delete(Uri.parse(ApiUrl.deleteCmtPost + idpost),
        body: jsonEncode(body),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      print('ok');
    } else
      print(response.statusCode);
  }

  Future<void> repCmt(String idcmt, String token, String message) async {
    Response response = await post(Uri.parse(ApiUrl.repComment + idcmt),
        body: jsonEncode({'message': message}),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        });
    print(response.statusCode);
    if (response.statusCode == 200) {
      print('ok');
    } else
      print(response.statusCode);
  }

  List<RepComment> listRepCmt = [];
  Future<void> getRepCmt(String token, String idcomment) async {
    List<RepComment> listNewRepCmt = [];
    Response response =
        await get(Uri.parse(ApiUrl.getRepCmt + idcomment), headers: {
      'Authorization': 'Bearer ' + token,
    });
    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      for (Map i in responseData['repcomment']) {
        RepComment repComment = RepComment(
            avatar: i['userid']['avatar'],
            creatAt: i['createdAt'],
            idrepcmt: i['_id'],
            idcomment: i['commentid'],
            iduser: i['userid']['_id'],
            message: i['message'],
            username: i['userid']['username']);
        listNewRepCmt.add(repComment);
      }
      listRepCmt = listNewRepCmt;
      notifyListeners();
    } else
      print(response.statusCode);
  }

  get getRepCmtList {
    return listRepCmt;
  }

  get clearRepCmtList {
    return listRepCmt.clear();
  }

  Future<void> deleteRepCmt(
      String idcomment, String idrepcomment, String token) async {
    var body = {'commentID': idcomment};
    Response response = await post(
        Uri.parse(ApiUrl.deleteRepCmt + idrepcomment),
        body: jsonEncode(body),
        headers: {
          'Authorization': 'Bearer ' + token,
          'Content-Type': 'application/json'
        });

    if (response.statusCode == 200) {
      print('ok');
    } else
      print(response.statusCode);
  }
}
