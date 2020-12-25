import 'dart:io';

import 'package:app_tv/app/components/date/date.component.dart';
import 'package:app_tv/app/home/home-page/comment/comment.cubit.dart';
import 'package:app_tv/model/comment/comment.dart';
import 'package:app_tv/model/post/post.dart';
import 'package:app_tv/model/user_infor/user_infor.dart';
import 'package:app_tv/repositories/post/post.repository.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/api.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http_parser/src/media_type.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class CommentView extends StatefulWidget {
  final int idPost;

  const CommentView({Key key, this.idPost}) : super(key: key);

  @override
  _CommentViewState createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  String content;
  CommentCubit _cubit = CommentCubit(PostRepository());
  UserInfor _userInfor = Application.sharePreference.getUserInfor();

  GlobalKey<FormBuilderState> _key = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cubit.loadData(widget.idPost);
  }

  void _showAlert(BuildContext context, int index) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Text(
                    "Xóa",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  onPressed: () {
                    _cubit.deleteComment(index, widget.idPost);
                    Navigator.pop(context);
                  },
                ),
//                CupertinoActionSheetAction(
//                  child: Text(
//                    "Chỉnh sửa",
//                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
//                  ),
//                  onPressed: () {},
//                )
              ],
              cancelButton: CupertinoActionSheetAction(
                child: Text(
                  "Cancel",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.teal,
          title: Text("Bài viết"),
        ),
        body: BlocBuilder<CommentCubit, CommentState>(
            cubit: _cubit,
            buildWhen: (prev, now) => now is PostLoading || now is ItemsPostLoaded,
            builder: (context, state) {
              if (state is ItemsPostLoaded) {
                return _body();
              } else if (state is CommentError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: CupertinoActivityIndicator(radius: 15));
              }
            }));
  }

  Widget _body() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            children: [
              _post(_cubit.post),
              BlocBuilder<CommentCubit, CommentState>(
                  cubit: _cubit,
                  buildWhen: (prev, now) => now is CommentLoading || now is ItemsCommentLoaded,
                  builder: (context, state) {
                    if (state is ItemsCommentLoaded || state is ItemsPostLoaded) {
                      return Column(
                        children: [
                          Divider(
                            height: 1,
                            thickness: 3,
                          ),
                          Container(
                            child: Text(
                              '${_cubit.comment.result.length ?? 0} bình luận',
                              style: TextStyle(fontSize: 18),
                            ),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(15),
                          ),
                          Divider(
                            height: 1,
                            thickness: 3,
                          ),
                          ...List.generate(_cubit.comment.result.length, (index) {
                            return _comment(_cubit.comment.result[index]);
                          }),
                        ],
                      );
                    } else if (state is CommentError) {
                      return Center(child: Text(state.message));
                    } else {
                      return Center(child: CupertinoActivityIndicator(radius: 15));
                    }
                  }),
              SizedBox(height: SizeConfig.blockSizeVertical * 20),
            ],
          ),
        ),
        Positioned(
          child: _inputComment(),
          bottom: 0,
        )
      ],
    );
  }

  Widget _post(Post _post) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10.0),
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
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
                        '${_post.userCreate.avatar ?? 'https://www.minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg'}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${_post.userCreate.name ?? ''}',
                        style: TextStyle(fontSize: 18),
                      ),
                      Text(
                        '${dateFormat(_post.create_at ?? '')}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                '${_post.content ?? ''}',
                style: TextStyle(fontSize: 20),
              ),
            ),
            _post.urlAssets != null
                ? Container(
                    padding: EdgeInsets.all(8.0),
                    width: double.infinity,
                    child: Image.network(
                      '${_post.urlAssets ?? ''}',
                      fit: BoxFit.cover,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget _comment(Comments _comment) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: FlatButton(
          padding: EdgeInsets.zero,
          onLongPress: () {
            if (_userInfor.id == _comment.user.id) {
              _showAlert(context, _comment.id);
            }
          },
          onPressed: () {},
          child: Card(
            margin: EdgeInsets.zero,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(18.0),
            // ),
            elevation: 3.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(15.0),
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        margin: EdgeInsets.all(5.0),
                        child: ClipOval(
                          child: Image.network(
                            '${_comment.user.avatar ?? 'https://www.minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg'}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_comment.user.name ?? ''}',
                            style: TextStyle(fontSize: 18),
                          ),
                          Text(
                            '${dateFormat(_comment.createAt ?? '')}',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                _comment.content != null
                    ? Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          '${_comment.content}',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : SizedBox(),
                _comment.asset != null
                    ? Container(
                        padding: EdgeInsets.all(15.0),
                        child: Image.network(
                          '${_comment.asset}',
                          height: SizeConfig.blockSizeVertical * 20,
                          width: SizeConfig.blockSizeHorizontal * 40,
                          fit: BoxFit.fill,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        // decoration: BoxDecoration(borderRadius: BorderRadius.circular(18.0), border: Border.all(color: Colors.grey, width: 1.5)),
    );
  }

  Widget _inputComment() {
    return Container(
        width: SizeConfig.safeBlockHorizontal * 95,
        margin: EdgeInsets.all(10.0),
        child: Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
          elevation: 5.5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2.5), icon: Icon(Icons.camera_alt), iconSize: 30, onPressed: loadAssets),
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: [
                        FormBuilder(
                          key: _key,
                          child: FormBuilderTextField(
                            maxLines: null,
                            autofocus: true,
                            attribute: 'comment',
                            textAlign: TextAlign.start,
                            style: TextStyle(fontSize: 21),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Viết bình luận ...",
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
                                    AssetThumb(asset: images[0], width: 120, height: 120),
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
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(18.0),
                    )),
              ),
              IconButton(
                  padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 2.5),
                  icon: Icon(Icons.cancel_schedule_send),
                  iconSize: 30,
                  onPressed: () {
                    _key.currentState.reset();
                    createComment();
                  }),
            ],
          ),
        ),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), border: Border.all(color: Colors.grey, width: 1.5)));
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

  Future<bool> createComment() async {
    FormData formData = FormData.fromMap(<String, dynamic>{
      "content": content,
      "photo": multipartFile,
      "posterId": widget.idPost,
    });
    var response = await Application.api.dio.post("${API.baseUrl}/poster/comment", data: formData);
    _cubit.loadComment(widget.idPost);
    return response.data['status'] == 200 ? true : false;
  }
}
