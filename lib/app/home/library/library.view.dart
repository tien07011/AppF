import 'package:app_tv/app/components/date/date.component.dart';
import 'package:app_tv/app/home/home.module.dart';
import 'package:app_tv/app/home/library/library.cubit.dart';
import 'package:app_tv/model/user_infor/user_infor.dart';
import 'package:app_tv/repositories/library/library.repositories.dart';
import 'package:app_tv/routers/application.dart';
import 'package:app_tv/services/library/library.service.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Library extends StatefulWidget {
  @override
  _LibraryState createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  LibraryCubit cubit = LibraryCubit(LibraryRepository());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Container(
          //   height: SizeConfig.blockSizeVertical * 100,
          //   child: Image.asset(
          //     'assets/login.jpg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          Column(
            children: [
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: Card(
                      elevation: 5,
                      child: Container(
                        width: SizeConfig.blockSizeHorizontal * 20,
                        height: SizeConfig.blockSizeVertical * 19,
                        padding: EdgeInsets.only(left: 10.0, top: 15.0),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Color(0xFFF1F1F1)),
                        child: thongKe(),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: Container(
                      width: SizeConfig.blockSizeHorizontal * 50,
                      height: SizeConfig.blockSizeVertical * 20,
                      child: Column(
                        children: [
                          Expanded(
                            child: Card(
                              elevation: 5.0,
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Modular.link.pushNamed(HomeModule.inputView);
                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    color: Color(0xFFF1F1F1),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                      Icon(Icons.input, color: Colors.teal, size: 30),
                                      Expanded(
                                        child: Text("Nhập liệu",
                                            style:
                                                TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Expanded(
                            child: Card(
                              elevation: 5.0,
                              child: FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  Modular.link.pushNamed(HomeModule.member);
                                },
                                child: Container(
                                  width: SizeConfig.blockSizeHorizontal * 50,
                                  alignment: Alignment.center,
                                  decoration:
                                      BoxDecoration(borderRadius: BorderRadius.circular(5.0), color: Color(0xFFF1F1F1)),
                                  child: Column(
                                    children: [
                                      SizedBox(height: SizeConfig.blockSizeVertical * 1),
                                      Icon(Icons.person_outline, color: Colors.teal, size: 30),
                                      Expanded(
                                        child: Text("Thành viên",
                                            style:
                                                TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(child: Container(height: 2.0,color: Colors.teal,)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text("Lịch Sử",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)),
                  ),
                  Expanded(child: Container(height: 2.0,color: Colors.teal,)),
                ],
              ),
              SizedBox(height: 20.0),
              BlocBuilder<LibraryCubit, LibraryState>(
                cubit: cubit,
                buildWhen: (pre, now) => now is ItemsLibraryLoaded,
                builder: (context, state) {
                  if (state is ItemsLibraryLoaded) {
                    return Expanded(child: Container(child: _getHistory()));
                  } else if (state is LibraryError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Container(
                        height: SizeConfig.blockSizeVertical * 50,
                        alignment: Alignment.center,
                        child: CupertinoActivityIndicator(radius: 20));
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget thongKe() {
    return BlocBuilder<LibraryCubit, LibraryState>(
      cubit: cubit,
      buildWhen: (previous, now) => now is ThongKeLoaded,
      builder: (context, state) {
        if (state is ThongKeLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(child: Icon(Icons.insert_chart_rounded, color: Colors.teal, size: 55)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Tháng này ", style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Text("   Mượn : ${cubit.borrow}",
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("   Trả : ${cubit.paid}",
                            style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Text("     Tổng : ${cubit.paid + cubit.borrow}",
                        style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
              )
            ],
          );
        } else {
          return Container(
            height: SizeConfig.blockSizeVertical * 18,
            child: CupertinoActivityIndicator(),
          );
        }
      },
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
    cubit.pull();
    _refreshController.loadComplete();
  }

  Widget _getHistory() {
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
            children: [
              ...List.generate(cubit.listHistory.result.length, (index) {
                return Column(
                  children: [
                    SizedBox(height: 10),
                    FlatButton(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        width: double.infinity,
                        color: Color(0xFFF1F1F1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "${cubit.listHistory.result.elementAt(index).student?.name} - ${cubit.listHistory.result.elementAt(index).student?.idStudent}",
                                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.menu_book_outlined, color: Colors.teal, size: 25),
                                SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: Text(
                                      "${cubit.listHistory.result.elementAt(index).bookdetail.book.name} - ${cubit.listHistory.result.elementAt(index).bookdetail.idBookDetails}",
                                      style: TextStyle(fontSize: 15)),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: (cubit.listHistory.result.elementAt(index).payDate != null)
                                        ? Colors.teal
                                        : (dateFormat(cubit.listHistory.result.elementAt(index).borrowDate)==
                                        dateFormat(cubit.listHistory.result.elementAt(index).update_at))
                                        ?  Colors.teal
                                        :  Colors.teal,
                                  ),
                                  child: Text(
                                      (cubit.listHistory.result.elementAt(index).payDate != null)
                                          ? "Ghi trả"
                                          : (dateFormat(cubit.listHistory.result.elementAt(index).borrowDate) ==
                                          dateFormat(cubit.listHistory.result.elementAt(index).update_at))
                                          ? "Ghi mượn"
                                          : "Ngày cập nhật",
                                      style: TextStyle(fontSize: 15, color: Colors.white)),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.grey,
                                  ),
                                  child: Text(
                                      (cubit.listHistory.result.elementAt(index).payDate != null)
                                          ? "${dateFormat(cubit.listHistory.result?.elementAt(index)?.update_at ?? "")} "
                                          : (cubit.listHistory.result.elementAt(index).update_at ==
                                          cubit.listHistory.result.elementAt(index).borrowDate)
                                          ? "${dateFormat(cubit.listHistory.result.elementAt(index).borrowDate)}"
                                          : "${dateFormat(cubit.listHistory.result.elementAt(index).update_at)}",
                                      style: TextStyle(fontSize: 15, color: Colors.white)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {},
                    ),
                    // Divider(height: 1.0, color: Colors.grey, thickness: 2.0)
                  ],
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
