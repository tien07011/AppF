import 'package:app_tv/app/components/custom-appbar/static-appbar.component.dart';
import 'package:app_tv/app/home/home.module.dart';
import 'package:app_tv/app/home/library/member/member-info/member-info.view.dart';
import 'package:app_tv/app/home/library/member/member.cubit.dart';
import 'package:app_tv/model/user_infor/user_infor.dart';
import 'package:app_tv/repositories/library/library.repositories.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MemberView extends StatefulWidget {
  @override
  _MemberViewState createState() => _MemberViewState();
}

class _MemberViewState extends State<MemberView> {
  MemberCubit cubit = MemberCubit(LibraryRepository());
  UserInfor _userInfo = Application.sharePreference.getUserInfor();


  RefreshController _refreshController = RefreshController(initialRefresh: false);

  // ignore: avoid_void_async
  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  // ignore: avoid_void_async
  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    cubit.pull();
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: staticAppbar(title: "Thành viên"),
        floatingActionButton:_userInfo.role.isCreateOrEditUser ? FloatingActionButton(
          backgroundColor: Color(0xff068189),
          foregroundColor: Colors.black,
          onPressed: () {
            if (_userInfo.role.isCreateOrEditUser) {
              Modular.link.pushNamed(HomeModule.newMember, arguments: cubit);
            } else {
              Fluttertoast.showToast(
                msg: "Bạn không thể làm điều này !!!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.redAccent,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
            // Respond to button press
          },
          child: Icon(Icons.add, color: Colors.white),
        ) : SizedBox(),
        body: BlocBuilder<MemberCubit, MemberState>(
            cubit: cubit,
            buildWhen: (prev, now) => now is ItemsMemberLoaded,
            builder: (context, state) {
              if (state is ItemsMemberLoaded) {
                return _getBody(state);
              } else if (state is MemberError) {
                return Center(child: Text(state.message));
              } else {
                return Center(child: CupertinoActivityIndicator(radius: 15));
              }
            }),
      ),
    );
  }

  Widget _getBody(MemberState state) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.blockSizeVertical * 1),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 5.0),
          width: SizeConfig.blockSizeHorizontal * 80,
          height: SizeConfig.blockSizeVertical * 5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.teal, width: 1.0),
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
          ),
          child: FormBuilderTextField(
            attribute: "search",
            decoration: InputDecoration(hintText: "Search", border: InputBorder.none),
            onFieldSubmitted: (value) {
              cubit.loadData(search: value.toString());
            },
          ),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 1),
        Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.teal,
                width: 130,
                height: 3,
              ),
            ),
            Text("Tổng số : ${cubit.member.length}",
                style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold)),
            Expanded(
              child: Container(
                color: Colors.teal,
                width: 135,
                height: 3,
              ),
            ),
          ],
        ),
        SizedBox(height: SizeConfig.blockSizeVertical * 3),
        (cubit.member.isEmpty) ? Text("Không Tìm Thấy",style: TextStyle(fontSize: 25)) : Expanded(
          child: Container(
            child: Scrollbar(
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
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      ...List.generate(cubit.member.length, (index) {
                        return Card(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          color: Colors.white.withOpacity(0.75),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: EdgeInsets.zero,
                            child: Container(
                              width: SizeConfig.blockSizeHorizontal * 95,
                              margin: EdgeInsets.only(left:5, top: 20, right: 20, bottom: 20),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: CircleAvatar(
                                      radius: SizeConfig.blockSizeHorizontal * 8,
                                      backgroundImage: NetworkImage(
                                          '${cubit.member.elementAt(index).avatar}'),
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: SizeConfig.blockSizeHorizontal*70,
                                        child: Text('${cubit.member.elementAt(index).name}',
                                            style: TextStyle(color: (cubit.member.elementAt(index).isBlock) ? Colors.grey :Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
                                      ),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                      Text(
                                          '${cubit.member.elementAt(index).department.name} - ${cubit.member.elementAt(index).GenCode}',
                                          style: TextStyle(color: Colors.black)),
                                      Text(
                                          '${cubit.member.elementAt(index).role.Code}',
                                          style: TextStyle(color: Colors.black)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            onLongPress: () {
                              if (_userInfo.role.isCreateOrEditUser) {
                                _showAlert(context, cubit.member.elementAt(index).id);
                              }
                            },
                            onPressed: () {
                              // Modular.link.pushNamed(HomeModule.memberInfo,arguments: cubit.member.elementAt(index));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MemberInfoView(member: cubit.member.elementAt(index), cubit: cubit)),
                              );
                            },
                          ),
                        );
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _showAlert(BuildContext context, int index) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text(
                "Block",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              isDestructiveAction: true,
              onPressed: () async {
                showDialog(context: context,builder: (context) {
                  return CupertinoActivityIndicator(
                    radius: 30,
                    animating: true,
                  );
                },);
                if (await cubit.blockUser(index)) {
                Navigator.pop(context);
                Navigator.pop(context);
                }
              },
            ),
            CupertinoActionSheetAction(
              child: Text(
                "Xoá",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              isDestructiveAction: true,
              onPressed: () async {
                showDialog(context: context,builder: (context) {
                  return CupertinoActivityIndicator(
                    radius: 30,
                    animating: true,
                  );
                },);
                if (await cubit.deleteUser(index)) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                }
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(
              "Trở lại",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}
