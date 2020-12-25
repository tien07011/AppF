import 'dart:io';
import 'package:app_tv/app/home/home-page/post/post.cubit.dart';
import 'package:app_tv/model/user_infor/user_infor.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/api.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class PostView extends StatefulWidget {
  final PostCubit cubit;

  const PostView({this.cubit}) : super();
  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  String content;
  UserInfor _userInfor = Application.sharePreference.getUserInfor();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: Text("Bài viết"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _createStatus(),
          ],
        ),
      ),
    );
  }

  Widget _createStatus() {
    return Container(
        width: double.infinity,
        // height: SizeConfig.blockSizeVertical * 50,
        margin: EdgeInsets.all(10.0),
        child: FlatButton(
          padding: EdgeInsets.zero,
          onLongPress: (){
          },
          child: Card(
            color: Colors.grey[300],
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            elevation: 5.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(15.0),
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.all(5.0),
                        child: ClipOval(
                          child: Image.network(
                            '${_userInfor.avatar ??=
                            'https://www.minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg'}',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_userInfor.name}',
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: FormBuilderTextField(
                    maxLines: null,
                    attribute: 'status',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 21),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Bạn đang nghĩ gì !!!",
                      hintStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    keyboardType: TextInputType.text,
                    validators: [FormBuilderValidators.required()],
                    onChanged: (dynamic val) {
                      content = val.toString();
                    },
                  ),
                ),
                images.isNotEmpty
                    ? Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(8.0),
//                        height: SizeConfig.blockSizeVertical * 30,
//                        width: double.infinity,
                  child: Stack(
                    children: [
                      AssetThumb(
                          asset: images[0],
                          width: 120,
                          height: 120),
                      Positioned(
                          top: -5,
                          right: -5,
                          child: IconButton(
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              setState(() {
                                images.clear();
                              });
                            },
                          ))
                    ],
                  ),
                )
                    : SizedBox(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(Icons.camera_alt), iconSize: 30, onPressed: loadAssets),
                      IconButton(
                          icon: Icon(Icons.cancel_schedule_send),
                          iconSize: 30,
                          onPressed: () async {
                            await uploadStatus() ? Modular.navigator.pop() : {
                              Fluttertoast.showToast(
                                msg: "Thất bại",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              )
                            };
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18.0),
        ));
  }

  File file;
  String fileName;
  MultipartFile multipartFile;

  List<Asset> images = <Asset>[];
  List<MultipartFile> multipartImageList = <MultipartFile>[];

  Future<void> loadAssets() async {
    images.clear();
    List<Asset> resultList = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 1,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#E3161D",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }
    setState(() {
      if (!mounted) return;
      images = resultList;
      multipartImageList.clear();
      for (var i in images) {
        setFile(i);
      }
    });
  }

  Future<void> setFile(Asset asset) async {
    ByteData byteData = await asset.getByteData();
    List<int> imageData = byteData.buffer.asUint8List();
    multipartFile = MultipartFile.fromBytes(
      imageData,
      filename: 'status.png',
      contentType: MediaType("image", "png"),
    );
    multipartImageList.add(multipartFile);
  }

  Future<bool> uploadStatus() async {
    FormData formData = FormData.fromMap(<String, dynamic>{
      "content": content,
      "photo": multipartFile,
    });
    var response = await Application.api.dio.post("${API.baseUrl}/poster/create", data: formData);
    widget.cubit.loadData();
    return response.data['status'] == 200 ? true : false;
  }
}
