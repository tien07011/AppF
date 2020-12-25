
import 'package:app_tv/app/components/custom-appbar/static-appbar.component.dart';
import 'package:app_tv/app/components/date/date.component.dart';
import 'package:app_tv/app/home/search/search.cubit.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';


class GiveBookView extends StatefulWidget {
  final SearchCubit cubit;

  const GiveBookView({this.cubit}) : super();
  _GiveBookView createState() => _GiveBookView();
}

class _GiveBookView extends State<GiveBookView> {
  String date;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: staticAppbar(title: "Thông Tin Mượn / Trả"),
        body: BlocBuilder<SearchCubit,SearchState> (
          cubit: widget.cubit,
          buildWhen: (prev,now) => now is SearchLoading || now is ItemsBookOrderInfo,
          builder: (context,state) {
            if (state is ItemsSearchLoaded || state is ItemsBookOrderInfo) {
              return _getBody();
            } else if (state is SearchError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: CupertinoActivityIndicator(radius: 15));
            }
          }),
      ),
    );
  }

  Widget _getBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        children: [
          _textFiled('Mã sách'),
          _textFiled('Mã'),
          _textFiled('Tên sách'),
          _textFiled('Giá sách'),
          _textFiled('Ngày mượn'),
          _textFiled('TV Ghi mượn'),
          FormBuilderDateTimePicker(
            attribute: 'expiry_date',
            inputType: InputType.date,
            initialDate: DateTime.now(),
            initialValue: (widget.cubit.bookOrderInfo.payDate == null) ? null : DateTime.parse(widget.cubit.bookOrderInfo.payDate),
            decoration: InputDecoration(labelText: "Ngày trả", suffixIcon: Icon(Icons.calendar_today)),
            format: DateFormat("dd-MM-yyyy"),
            readOnly: (widget.cubit.bookOrderInfo.payDate == null) ? false : true,
            onChanged: (value) {
              date = value.toString();
            },
          ),
          _textFiled('Tv Ghi trả'),
          SizedBox(height: SizeConfig.blockSizeVertical * 10),
          (widget.cubit.bookOrderInfo.payDate != null) ? SizedBox() :
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
                        "Trở về",
                        style: TextStyle(color: Colors.white),
                      ))),
              Spacer(),
              Expanded(
                  child: FlatButton(
                      color: Color(0xff068189),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      onPressed: () {
                        widget.cubit.createBookPay(widget.cubit.bookOrderInfo.id, date);
                        Modular.navigator.pop();
                      },
                      child: Text(
                        "Ghi trả",
                        style: TextStyle(color: Colors.white),
                      ))),
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
      initialValue: (_tile == "Mã sách") ? "${widget.cubit.bookOrderInfo.bookdetail.idBookDetails}" :
        (_tile == "Mã") ? "${widget.cubit.bookOrderInfo.bookdetail.book.idBook}" :
        (_tile == "Tên sách") ? "${widget.cubit.bookOrderInfo?.bookdetail?.book?.name}" :
        (_tile == "Giá sách") ? "${widget.cubit.bookOrderInfo.bookdetail.book.price}" :
        (_tile == "Ngày mượn") ? "${dateFormat(widget.cubit.bookOrderInfo.borrowDate)}" :
        (_tile == "TV Ghi mượn") ? "${widget.cubit.bookOrderInfo?.userCheckIn?.name??""} - ${widget.cubit.bookOrderInfo?.userCheckIn?.GenCode}" :
        (_tile == "Ngày trả") ? "${(widget.cubit.bookOrderInfo.payDate == null) ? "" : (widget.cubit.bookOrderInfo.payDate)}" :
        (_tile == "Tv Ghi trả") ? "${(widget.cubit.bookOrderInfo.payDate == null) ? "" : "${widget.cubit.bookOrderInfo?.userCheckOut?.name}${" - ${widget.cubit.bookOrderInfo?.userCheckOut?.GenCode}"}"} "
            : null,
      validators: [
        FormBuilderValidators.required(),
      ],
      readOnly: true,
    );
  }
}
