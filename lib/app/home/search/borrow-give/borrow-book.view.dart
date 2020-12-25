import 'package:app_tv/app/components/custom-appbar/static-appbar.component.dart';
import 'package:app_tv/app/home/search/search.cubit.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

class BorrowBookView extends StatefulWidget {
  final SearchCubit cubit;

  const BorrowBookView({this.cubit}) : super();
  _BorrowBookView createState() => _BorrowBookView();
}

class _BorrowBookView extends State<BorrowBookView> {

  String idBook;
  int time;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: staticAppbar(title: "Ghi Mượn"),
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: [
          _textFiled('Mã sách'),
        BlocBuilder<SearchCubit,SearchState>(
          cubit: widget.cubit,
          buildWhen: (prev,now) => now is ItemsBookDetailLoaded || now is ItemsSearchLoaded || now is SearchLoading,
          builder: (context,state) {
            return (state is ItemsSearchLoaded) ? FormBuilderTextField(
              attribute: 'sach',
              decoration: InputDecoration(labelText: "Tên Sách"),
              initialValue: (widget.cubit.bookDetail == null) ? null : widget.cubit.bookDetail['book']['name'].toString(),
              validators: [
                FormBuilderValidators.required(),
              ],
              readOnly: true,
            ) : SizedBox();
          },
        ),
          _textFiled('MSV'),
          // _textFiled('Tên sách'),
          // _textFiled('Giá sách'),
          FormBuilderDropdown(
            attribute: "vt",
            decoration: InputDecoration(labelText: "Thời gian mượn sách"),
            validators: [FormBuilderValidators.required()],
            items: ['3 Tháng','6 Tháng','1 Năm'].map((item) => DropdownMenuItem(value: item, child: Text("${item}"))).toList(),
            onChanged: (value){
              if (value.toString() == "3 Tháng") {
                time = 3;
              }
              if (value.toString() == "6 Tháng") {
                time = 6;
              } else {
                time = 12;
              }
            },
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 10),
          Row(
            children: [
              SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
              Expanded(
                  child: FlatButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      onPressed: () {
                        Modular.navigator.pop();
                      },
                      child: Text(
                        "Hủy",
                        style: TextStyle(color: Colors.white),
                      ))),
              Spacer(),
              FlatButton(
                  color: Color(0xff068189),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  onPressed: () {
                    widget.cubit.newBook(idBook,widget.cubit.bookOrder.studentInfo.idStudent,time);
                    Modular.navigator.pop();
                  },
                  child: Text(
                    "Ghi mượn",
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(width: SizeConfig.blockSizeHorizontal * 15),
            ],
          )
        ],
      ),
    );
  }

  Widget _textFiled(String _tile) {
    return FormBuilderTextField(
      attribute: 'sach',
      decoration: InputDecoration(labelText: "${_tile} : "),
      initialValue: (_tile == "MSV") ? widget.cubit.bookOrder.studentInfo.idStudent : null,
      validators: [
        FormBuilderValidators.required(),
      ],
      onFieldSubmitted: (newValue) {
        print(newValue.toString());
        if (_tile == "Mã sách") {
          widget.cubit.getBookDetail(idBook);
        }
      },
      onChanged: (value) {
        if (_tile == "Mã sách") {
          idBook = value.toString();
        }
      },
    );
  }
}
