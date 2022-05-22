import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
import 'package:test/api/api_url.dart';
import 'package:test/item/tittle/list_tittle_image.dart';
import 'package:test/models/user.dart';
import 'package:test/provider/edit_infor_provider.dart';
import 'package:test/provider/user_provider.dart';
import 'package:test/screens/profile_widget/profile_user/avarta_image_widged.dart';
import 'package:test/screens/profile_widget/profile_user/cover_image_widget.dart';

class TopWidget extends StatefulWidget {
  const TopWidget({
    Key? key,
    required this.coverHeight,
    required this.avartaHeight,
  }) : super(key: key);

  final double coverHeight;
  final double avartaHeight;

  @override
  State<TopWidget> createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> {
  EditInforProvider? edit;
  User? user;
  UserProvider? _setuser;
  bool typeImage = true;
  XFile? _file;
  CroppedFile? _croppedFile;
  String? token;
  bool isBool = false;
  void initState() {
    super.initState();

    getToken();
  }

  @override
  Widget build(BuildContext context) {
    edit = Provider.of<EditInforProvider>(context);
    user = Provider.of<UserProvider>(context).user;
    _setuser = Provider.of<UserProvider>(context);
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          child: CoverImageWidget(
              urlImage: ApiUrl.imageUrl + user!.coverImage!,
              coverHeight: widget.coverHeight,
              onTap: () {
                imageDialog(context, pickImage);
                setState(() {
                  typeImage = true;
                });
              }),
          margin: EdgeInsets.only(bottom: widget.avartaHeight / 2),
        ),
        Positioned(
          top: widget.coverHeight - widget.avartaHeight / 2,
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  border: Border.all(width: 5, color: Colors.white)),
              child: AvartaImageWidget(
                urlImage: ApiUrl.imageUrl + user!.avartaImage!,
                avartaHeight: widget.avartaHeight,
                onTap: () {
                  imageDialog(context, pickImage);
                  setState(() {
                    typeImage = false;
                  });
                },
              )),
        ),
      ],
    );
  }

  Future<void> imageDialog(
      BuildContext context, Future pickImage(ImageSource source)) async {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Center(child: Text("Choose Source")),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
              content: Container(
                height: 145,
                child: Column(children: [
                  ListTileWidget(
                      text: "From Camera",
                      icon: Icons.camera_alt,
                      onClicked: () async {
                        Navigator.of(context).pop();
                        await pickImage(ImageSource.camera);
                      }),
                  ListTileWidget(
                      text: "From Gallery",
                      icon: Icons.photo,
                      onClicked: () async {
                        Navigator.of(context).pop();
                        await pickImage(ImageSource.gallery);

                        // _file != null
                        //     ? Navigator.of(context).push(MaterialPageRoute(
                        //         builder: (context) => _imageCard()))
                        //     : Navigator.of(context).pop();
                        ;
                      })
                ]),
              ),
            ));
  }

  Future pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return null;
    setState(() {
      _file = image;
    });
    await _cropImage();
    await edit!.notify();
  }

  Future<void> _cropImage() async {
    CroppedFile? croppedFile;
    if (_file != null) {
      if (typeImage) {
        croppedFile = await ImageCropper().cropImage(
            sourcePath: _file!.path,
            compressFormat: ImageCompressFormat.jpg,
            compressQuality: 100,
            aspectRatio: CropAspectRatio(ratioX: 9, ratioY: 5));
        if (croppedFile != null) {
          setState(() {
            _croppedFile = croppedFile;
          });
          await uploadImage();
        }
      } else {
        croppedFile = await ImageCropper().cropImage(
            sourcePath: _file!.path,
            cropStyle: CropStyle.circle,
            compressFormat: ImageCompressFormat.jpg,
            compressQuality: 100,
            aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
        if (croppedFile != null) {
          setState(() {
            _croppedFile = croppedFile;
          });
          await uploadImage();
        }
      }
    }
  }

  Future<StreamedResponse> uploadImage() async {
    File image = File(_croppedFile!.path);

    String name = image.path.split("/").last;
    String? field;
    String? url;
    if (typeImage) {
      url = ApiUrl.updateCover;
      field = 'upload_cover';
    } else {
      url = ApiUrl.updateAvatar;
      field = 'upload_avatar';
    }
    var request = MultipartRequest('PATCH', Uri.parse(url));
    request.files.add(await MultipartFile(
        field, image.readAsBytes().asStream(), image.lengthSync(),
        filename: name, contentType: MediaType('image', 'jpg')));
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Authorization': 'Bearer ' + token!
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      User _user = await edit!.getUser(token!, user!.iduser!);
      _setuser!.setUser(_user);

      _clear();
      print("upload ok");
    } else {
      print("connect fail");
    }
    return response;
  }

  void _clear() {
    setState(() {
      _file = null;
      _croppedFile = null;
    });
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? _token = await pref.getString('token');
    setState(() {
      token = _token;
    });
    // print(token);
    return "Ok";
  }
}
