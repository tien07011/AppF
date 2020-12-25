import 'package:app_tv/app/components/custom-appbar/static-appbar.component.dart';
import 'package:app_tv/app/components/date/date.component.dart';
import 'package:app_tv/app/home/customer/information/infor.cubit.dart';
import 'package:app_tv/model/post/post.dart';
import 'package:app_tv/model/user_infor/user_infor.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class InforView extends StatefulWidget {
  @override
  _InforViewState createState() => _InforViewState();
}

class _InforViewState extends State<InforView> {

  UserInfor _userInfo = Application.sharePreference.getUserInfor();
  InforCubit cubit = InforCubit();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF1F1F1),
        appBar: staticAppbar(title: "Trang Cá Nhân"),
        body: _getBody(),
      ),
    );
  }
  Widget _getBody() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: CircleAvatar(
              radius: SizeConfig.blockSizeHorizontal * 35,
              backgroundImage: NetworkImage('${_userInfo.avatar}'),
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(3.0),
              ),
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              color: Colors.white,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 92,
                padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
                    Text("${_userInfo?.name ?? ""}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _info(
                    "${_userInfo.role?.name}",
                    Icon(
                      Icons.person_outline,
                      size: 25,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1),
                  _info(
                      "${_userInfo.GenCode ?? ""}",
                      Icon(
                        Icons.support_agent_sharp,
                        size: 25,
                        color: Colors.redAccent,
                      )),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _info(
                    "${_userInfo?.department?.name ?? ""}",
                    Icon(
                      Icons.home,
                      size: 25,
                      color: Colors.teal,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1),
                  _info(
                    (_userInfo?.gender == "1") ? "Nam" : "Nữ",
                    Icon(
                      Icons.fiber_manual_record_rounded,
                      size: 25,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _info(
                    dateFormat("${_userInfo?.born ?? ""}"),
                    Icon(
                      Icons.today_outlined,
                      size: 25,
                      color: Colors.pink,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical * 1),
                  _info(
                    "${_userInfo.phoneNumber ?? ""}",
                    Icon(
                      Icons.phone,
                      size: 25,
                      color: Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.white, width: 1),
                borderRadius: BorderRadius.circular(5.0),
              ),
              elevation: 5.0,
              margin: EdgeInsets.symmetric(horizontal: 13),
              color: Colors.white,
              child: Container(
                width: SizeConfig.blockSizeHorizontal * 92,
                padding: EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
                    Icon(
                      Icons.email,
                      size: 25,
                      color: Colors.green,
                    ),                    SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
                    Text("${_userInfo?.email ?? ""}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 1),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Text("Bài viết của bạn ",style: TextStyle(color: Colors.teal,fontSize: 20,fontWeight: FontWeight.bold)),
          ),
          BlocBuilder<InforCubit, InforState>(
              cubit: cubit,
              buildWhen: (prev, now) => now is InforLoading || now is InforLoaded ,
              builder: (context, state) {
                if (state is InforLoaded) {
                  return Column(
                    children: [
                      ...List.generate(cubit.listPost.length, (index) {
                        return _post(cubit.listPost[index]);
                      })
                    ],
                  );
                } else if (state is InforError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: CupertinoActivityIndicator(radius: 15));
                }
              })


        ],
      ),
    );
  }

  Widget _info(String text, Icon icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(0.0),
        ),
        elevation: 3.0,
        margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 1),
        color: Colors.white,
        child: Container(
          width: SizeConfig.blockSizeHorizontal * 45,
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            children: [
              SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
              icon,
              SizedBox(height: SizeConfig.blockSizeHorizontal * 3),
              Text("$text", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
  Widget _post(Post _post) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.0),
      // decoration: BoxDecoration(
      //   border: Border.all(width: 1.0,color: Colors.grey),
      //   borderRadius: BorderRadius.circular(25)
      // ),
      child: Card(
        elevation: 5.0,
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
                          '${_post.userCreate?.avatar ?? 'https://www.minervastrategies'
                              '.com/wp-content/uploads/2016/03/default-avatar'
                              '.jpg'}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_post.userCreate?.name ?? ''}',
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
                height: SizeConfig.blockSizeVertical * 40,
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
      ),
    );
  }
}