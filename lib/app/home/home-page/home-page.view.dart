import 'package:app_tv/app/components/date/date.component.dart';
import 'package:app_tv/app/home/home-page/post/post.cubit.dart';
import 'package:app_tv/app/home/home.module.dart';
import 'package:app_tv/model/post/post.dart';
import 'package:app_tv/model/user_infor/user_infor.dart';
import 'package:app_tv/repositories/post/post.repository.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PostCubit _cubit = PostCubit(PostRepository());
  UserInfor _userInfor = Application.sharePreference.getUserInfor();

  void _showAlert(BuildContext context, int idPost) {
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
                    _cubit.deletePost(idPost.toString());
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
      floatingActionButton: _userInfor.role.isCreatePost
          ? FloatingActionButton(
              backgroundColor: Colors.teal,
              foregroundColor: Colors.black,
              onPressed: () {
                Modular.link.pushNamed(HomeModule.postStatus, arguments: _cubit);
                // Respond to button press
              },
              child: Icon(Icons.add, color: Colors.white),
            )
          : SizedBox(),
      body: Stack(
        children: [
          // Container(
          //   height: SizeConfig.blockSizeVertical * 100,
          //   child: Image.asset(
          //     'assets/login.jpg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          BlocBuilder<PostCubit, PostState>(
              cubit: _cubit,
              buildWhen: (prev, now) => now is ItemsPostLoaded,
              builder: (context, state) {
                if (state is ItemsPostLoaded) {
                  return _body();
                } else if (state is PostError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: CupertinoActivityIndicator(radius: 15));
                }
              }),
        ],
      ),
    );
  }

  RefreshController _refreshController = RefreshController(initialRefresh: false);

  // ignore: avoid_void_async
  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  // ignore: avoid_void_async
  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _cubit.pull();
    _refreshController.loadComplete();
  }

  Widget _body() {
    return Scrollbar(
      child: SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        header: WaterDropMaterialHeader(),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus status) {
            Widget body;
            if (status == LoadStatus.idle) {
              body = SizedBox();
            } else if (status == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (status == LoadStatus.failed) {
              body = Text("");
            } else if (status == LoadStatus.canLoading) {
              body = Text("");
            } else {
              body = Text("");
            }
            return Container(
              height: 55.0,
              child: Center(child: body),
            );
          },
        ),
        onRefresh: onRefresh,
        onLoading: onLoading,
        controller: _refreshController,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ...List.generate(_cubit.listPost.length, (index) {
              return _post(_cubit.listPost[index]);
            })
          ],
        )),
      ),
    );
  }

  Widget _post(Post _post) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: FlatButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            Modular.link.pushNamed(HomeModule.comment, arguments: _post.id);
          },
          onLongPress: () {
            if (_userInfor.id == _post.userCreate.id) {
              _showAlert(context, _post.id);
            }
          },
          child: Card(
            margin: EdgeInsets.zero,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(15.0),
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
                    ? ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: SizeConfig.blockSizeHorizontal*100,
                      height: SizeConfig.blockSizeVertical*50,
                      child: Image.network(
                        '${_post.urlAssets ?? ''}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                )
                    : SizedBox(),
              ],
            ),
          ),
        ),
        // decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(18.0), border: Border.all(color: Colors.grey, width: 1.5)),
    );
  }
}
