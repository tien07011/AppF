import 'package:app_tv/app/components/custom-appbar/static-appbar.component.dart';
import 'package:app_tv/app/home/library/nhap-lieu/sach/book-info/book-info.cubit.dart';
import 'package:app_tv/model/library/list_book.dart';
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

class BookInfoView extends StatefulWidget {
  final Book book;

  const BookInfoView({this.book}) : super();

  @override
  _BookInfoViewState createState() => _BookInfoViewState();
}

class _BookInfoViewState extends State<BookInfoView> {
  BookInfoCubit _cubit = BookInfoCubit(LibraryRepository());
  String name;
  int price;
  String id;
  int amount;
  UserInfor _userInfo = Application.sharePreference.getUserInfor();




  @override
  void initState() {
    super.initState();
    name = widget.book.name;
    price = widget.book.price;
    id = widget.book.idBook;
    amount = widget.book.amount;

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: staticAppbar(action: [IconButton(
          icon: Icon(Icons.edit,color: Colors.white),
          onPressed: () {
            if (_userInfo.role.isCreateOrEditUser) {
              _cubit.changeEdit();
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
          },
        )],title: "Sửa Sách"),
        body: BlocBuilder<BookInfoCubit,BookInfoState>(
          cubit: _cubit,
          builder: (context,state) {
            return _getBody(state);
          },
        )
      ),
    );
  }

  Widget _getBody(BookInfoState state) {
    return Container(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            FormBuilderTextField(
              attribute: 'sach',
              readOnly: !_cubit.edit,
              decoration: InputDecoration(labelText: "Mã Sách : "),
              initialValue: "${widget.book.idBook}",
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                id = value.toString();
              },
            ),
            FormBuilderTextField(
              attribute: 'sach',
              readOnly: !_cubit.edit,
              decoration: InputDecoration(labelText: "Tên Sách : "),
              initialValue: "${widget.book.name}",
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                name = value.toString();
              },
            ),
            FormBuilderTextField(
              attribute: 'sach',
              readOnly: !_cubit.edit,
              decoration: InputDecoration(labelText: "Giá Sách : "),
              initialValue: "${widget.book.price}",
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                price = int.parse(value.toString());
              },
            ),
            FormBuilderTextField(
              attribute: 'sach',
              readOnly: !_cubit.edit,
              decoration: InputDecoration(labelText: "Số lượng : "),
              initialValue: "${widget.book.amount}",
              validators: [
                FormBuilderValidators.required(),
              ],
              onChanged: (value) {
                amount = int.parse(value.toString());
              },
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 10),
            (_cubit.edit) ?
            Row(
              children: [
                SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
                Expanded(
                    child: FlatButton(
                        color: Colors.red,
                        onPressed: () {
                          Modular.navigator.pop();
                        },
                        child: Text(
                          "Hủy",
                          style: TextStyle(color: Colors.white),
                        ))),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
                Expanded(
                    child: FlatButton(
                        color: Color(0xff068189),
                        onPressed: () async {
                          showDialog(context: context,builder: (context) {
                            return CupertinoActivityIndicator(
                              radius: 30,
                              animating: true,
                            );
                          },);
                          if (await _cubit.editBook(name, price, id, amount)) {
                            Modular.navigator.pop();
                            Modular.navigator.pop();
                          }
                        },
                        child: Text(
                          "Lưu",
                          style: TextStyle(color: Colors.white),
                        ))),
                SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
              ],
            ): SizedBox()
          ],
        ),
      ),
    );
  }
}
