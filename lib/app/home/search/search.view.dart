import 'package:app_tv/app/home/home.module.dart';
import 'package:app_tv/app/home/search/search.cubit.dart';
import 'package:app_tv/repositories/search/search.repository.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with AutomaticKeepAliveClientMixin {
  SearchCubit cubit = SearchCubit(SearchRepository());

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Container(
        //   height: SizeConfig.blockSizeVertical * 100,
        //   child: Image.asset(
        //     'assets/login.jpg',
        //     fit: BoxFit.cover,
        //   ),
        // ),
        SingleChildScrollView(
          child: Column(
            children: [
              _textField(),
              _searchButton(),
              Divider(
                height: 5.0,
                color: Colors.grey,
                thickness: 2.0,
              ),
              BlocBuilder<SearchCubit, SearchState>(
                  cubit: cubit,
                  buildWhen: (prev, now) => now is SearchLoading || now is ItemsSearchLoaded || now is SearchError,
                  builder: (context, state) {
                    if (state is ItemsSearchLoaded) {
                      return _info(state);
                    } else if (state is SearchError) {
                      return Center(
                          child: Padding(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 20),
                              child: Text(
                                state.message,
                                style: TextStyle(fontSize: 25, color: Colors.grey),
                              )));
                    } else if (state is SearchLoading) {
                      return Center(child: CupertinoActivityIndicator(radius: 15));
                    } else {
                      return SizedBox();
                    }
                  }),
            ],
          ),
        ),
      ],
    );
  }

  int id = 0;

  Widget _textField() {
    return Container(
      margin: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical * 6,
        bottom: SizeConfig.blockSizeVertical * 2,
      ),
      width: SizeConfig.blockSizeHorizontal * 70,
      height: SizeConfig.blockSizeVertical * 6,
      child: FormBuilderTextField(
        // textInputAction: TextInputAction.done,
        maxLines: 1,
        attribute: 'msv',
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10),
          hintText: "Nhập mã sinh viên",
          hintStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide(color: Colors.teal),
          ),
        ),
          keyboardType: TextInputType.numberWithOptions(signed: true),
          validators: [FormBuilderValidators.required()],
        onChanged: (dynamic val) {
          id = int.parse(val.toString());
        },
      ),
    );
  }

  Widget _searchButton() {
    bool isLoaded = true;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical),
      child: ButtonTheme(
        minWidth: SizeConfig.safeBlockHorizontal * 35,
        height: 45.0,
        child: AbsorbPointer(
          absorbing: !isLoaded,
          child: FlatButton(
            color: Colors.teal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            onPressed: () async {
              cubit.loadData(id);
            },
            child: isLoaded
                ? Text(
                    "Tra cứu",
                    style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.normal),
                  )
                : Theme(
                    data: ThemeData(
                      cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark),
                    ),
                    child: CupertinoActivityIndicator(),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _info(SearchState state) {
    return (cubit.bookOrder == null)
        ? SizedBox()
        : Card(
            elevation: 1.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.only(top: 8.0, right: 15.0, left: 15.0),
            color: Color(0xffF0EFEF),
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical),
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _profile(),
                  _text('Thông tin'),
                  Row(
                    children: [
                      _studentInfoRow('',
                          '${DateTime.parse("${cubit.bookOrder.studentInfo.born}").day} - ${DateTime.parse("${cubit.bookOrder.studentInfo.born}").month} - ${DateTime.parse("${cubit.bookOrder.studentInfo.born}").year}'),
                      Spacer(),
                      _studentInfoRow('Giới tính', 'Nam')
                    ],
                  ),
                  _studentInfo('${cubit.bookOrder.studentInfo.grade}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _text('Tình trạng mượn sách'),
                      IconButton(
                          icon: Icon(Icons.add_circle),
                          color: Colors.teal,
                          onPressed: () {
                            Modular.link.pushNamed(HomeModule.borrowBook, arguments: cubit).then((value) => cubit.bookDetail = null);
                          })
                    ],
                  ),
                  ...List.generate(cubit.bookOrder.bookBorrowed.length, (index) {
                    return _bookInfor(false, index);
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: _text('Lịch sử mượn sách'),
                  ),
                  ...List.generate(cubit.bookOrder.bookPaid.length, (index) {
                    return _bookInfor(true, index);
                  }),
                ],
              ),
            ),
          );
  }

  Widget _profile() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: ClipOval(
              child: Image.network(
                'https://www.minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Text(
            '${cubit.bookOrder.studentInfo.name}',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            '${cubit.bookOrder.studentInfo.idStudent}',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _text(String _s) {
    return Text(
      _s,
      style: TextStyle(color: Colors.grey[700], fontSize: 18),
    );
  }

  Widget _studentInfoRow(String _title, String _infor) {
    return Container(
      width: SizeConfig.blockSizeHorizontal * 42,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        '$_title  $_infor',
        style: TextStyle(fontSize: 20),
      ),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
    );
  }

  Widget _studentInfo(String _infor) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        'Lớp : ${_infor}',
        style: TextStyle(fontSize: 20),
      ),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15.0)),
    );
  }

  Widget _bookInfor(bool _val, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: FlatButton(
        color: Colors.grey[400],
        onPressed: () {
          if (_val == false) {
            cubit.getBookOrderInfo(cubit.bookOrder.bookBorrowed[index].id);
            Modular.link.pushNamed(HomeModule.giveBook, arguments: cubit);
          } else {
            cubit.getBookOrderInfo(cubit.bookOrder.bookPaid[index].id);
            Modular.link.pushNamed(HomeModule.giveBook, arguments: cubit);
          }
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                width: 30,
                height: 30,
                margin: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  '${index + 1}',
                  style: TextStyle(fontSize: 20),
                ),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(35.0)),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        _val ? '${cubit.bookOrder.bookPaid[index].bookdetail.book.name}' : '${cubit.bookOrder.bookBorrowed[index].bookdetail.book.name}',
                        style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                        overflow: TextOverflow.ellipsis,
                      ),
                      width: SizeConfig.blockSizeHorizontal * 40,
                    ),
                    Text(
                      _val ? '${cubit.bookOrder.bookPaid[index].bookdetail.idBookDetails}' : '${cubit.bookOrder.bookBorrowed[index].bookdetail.idBookDetails}',
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _val
                        ? Text(
                            'M : ${DateTime.parse("${cubit.bookOrder.bookPaid[index].borrowDate}").day} - ${DateTime.parse("${cubit.bookOrder.bookPaid[index].borrowDate}").month} - ${DateTime.parse("${cubit.bookOrder.bookPaid[index].borrowDate}").year} ',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          )
                        : Text(
                            'M : ${DateTime.parse("${cubit.bookOrder.bookBorrowed[index].borrowDate}").day} - ${DateTime.parse("${cubit.bookOrder.bookBorrowed[index].borrowDate}").month} - ${DateTime.parse("${cubit.bookOrder.bookBorrowed[index].borrowDate}").year} ',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                    _val
                        ? Text(
                            'T : ${DateTime.parse("${cubit.bookOrder.bookPaid[index].borrowDate}").day} - ${DateTime.parse("${cubit.bookOrder.bookPaid[index].borrowDate}").month} - ${DateTime.parse("${cubit.bookOrder.bookPaid[index].borrowDate}").year}',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          )
                        : Text(
                            'H : ${DateTime.parse("${cubit.bookOrder.bookBorrowed[index].deadline}").day} - ${DateTime.parse("${cubit.bookOrder.bookBorrowed[index].deadline}").month} - ${DateTime.parse("${cubit.bookOrder.bookBorrowed[index].deadline}").year} ',
                            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
