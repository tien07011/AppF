import 'package:app_tv/app/home/home.module.dart';
import 'package:app_tv/app/home/library/nhap-lieu/sach/list-book.cubit.dart';
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

class ListBookView extends StatefulWidget {
  @override
  _ListBookViewState createState() => _ListBookViewState();
}

class _ListBookViewState extends State<ListBookView> with AutomaticKeepAliveClientMixin {
  ListBookCubit _cubit = ListBookCubit(LibraryRepository());
  UserInfor _userInfo = Application.sharePreference.getUserInfor();


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: _userInfo.role.isCreateOrEditBook ? FloatingActionButton(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.black,
        onPressed: () {
          if (_userInfo.role.isCreateOrEditBook) {
            Modular.link.pushNamed(HomeModule.newBook, arguments: _cubit);
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
      body: Stack(
        children: [
          // Container(
          //   width: SizeConfig.blockSizeHorizontal*100,
          //   height: SizeConfig.blockSizeVertical * 100,
          //   child: Image.asset(
          //     'assets/book.jpg',
          //     fit: BoxFit.cover,
          //   ),
          // ),
          BlocBuilder<ListBookCubit, ListBookState>(
              cubit: _cubit,
              buildWhen: (prev, now) => now is ItemsListBookLoaded || now is BookCountLoading || now is BookCountLoaded,
              builder: (context, state) {
                if (state is ItemsListBookLoaded || state is BookCountLoaded) {
                  return _getBody(state);
                } else if (state is ListBookError) {
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

  Widget _getBody(ListBookState state) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.blockSizeVertical * 1),
        Container(
          padding: EdgeInsets.only(left: 10.0, right: 5.0),
          width: SizeConfig.blockSizeHorizontal * 80,
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
              _cubit.reset();
              _cubit.loadData(search: value.toString());
            },
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Container(
                color: Colors.teal,
                width: 130,
                height: 3,
              ),
            ),
            Text("Tổng số : ${_cubit.bookCount ?? ""}", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold)),
            Expanded(
              child: Container(
                color: Colors.teal,
                width: 135,
                height: 3,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        if (_cubit.listBook.isEmpty)
          Text("Không Tìm Thấy", style: TextStyle(fontSize: 25))
        else
          Expanded(
            child: Container(
              child: Scrollbar(
                thickness: 3.0,
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
                        ...List.generate(_cubit.listBook.length, (index) {
                          return FlatButton(
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Modular.link.pushNamed(HomeModule.bookInfo, arguments: _cubit.listBook.elementAt(index)).then((value) {
                                _cubit.loadData();
                              });
                            },
                            onLongPress: () => _showAlert(context, index),
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              height: SizeConfig.blockSizeVertical * 16,
                              margin: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.teal, width: 1.5),
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.white
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.menu_book_rounded,
                                    color: Colors.teal,
                                    size: 30,
                                  ),
                                  SizedBox(width: 10.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            width: SizeConfig.blockSizeHorizontal * 65,
                                            child: Text(" ${_cubit.listBook[index].name} - ${_cubit.listBook[index].idBook}",
                                                style: TextStyle(color: Colors.black, fontSize: 15), maxLines: 4, overflow: TextOverflow.ellipsis),
                                          ),
                                        ),
                                        SizedBox(height: 10.0),
                                        Container(
                                          margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 50),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Colors.teal),
                                          width: SizeConfig.blockSizeHorizontal * 30,
                                          alignment: Alignment.center,
                                          child: Text("Giá : ${_cubit.listBook[index].price} VNĐ", style: TextStyle(color: Colors.white, fontSize: 13)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void _showAlert(BuildContext context, int index) {
    showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
              message: Text(
                "Do you want to Delete ?",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              actions: <Widget>[
                CupertinoActionSheetAction(
                  child: Text(
                    "Delete",
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
                    if (await _cubit.deleteBook(_cubit.listBook[index].idBook)) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                )
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
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
