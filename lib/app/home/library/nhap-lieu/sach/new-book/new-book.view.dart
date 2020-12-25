import 'package:app_tv/app/components/custom-appbar/static-appbar.component.dart';
import 'package:app_tv/app/home/library/nhap-lieu/sach/list-book.cubit.dart';
import 'package:app_tv/utils/screen_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_modular/flutter_modular.dart';

class NewBookView extends StatefulWidget {
  final ListBookCubit cubit;

  const NewBookView({this.cubit}) : super();

  @override
  _NewBookViewState createState() => _NewBookViewState();
}

class _NewBookViewState extends State<NewBookView> {
  String name = '';
  int price = 0;
  String id = "";
  int amount = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: staticAppbar(title: "Thêm Sách"),
        body: _getBody(),
      ),
    );
  }

  Widget _getBody() {
    return Stack(
      children: [
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: Opacity(
        //     opacity: 0.5,
        //     child: Image.network(
        //       "https://scontent.fhan2-3.fna.fbcdn.net/v/t31.0-8/11062339_936357076423736_8686865242051210984_o.jpg?_nc_cat=108&ccb=2&_nc_sid=09cbfe&_nc_ohc=KfvB_wquuYoAX_Yu869&_nc_ht=scontent.fhan2-3.fna&oh=906780f218fbf138114378e2ed1b9994&oe=5FBA62D8",
        //       fit: BoxFit.cover,
        //     ),
        //   ),
        // ),
        Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                FormBuilderTextField(
                  attribute: 'sach',
                  decoration: InputDecoration(labelText: "Mã Sách : "),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  onChanged: (value) {
                    id = value.toString();
                  },
                ),
                FormBuilderTextField(
                  attribute: 'sach',
                  decoration: InputDecoration(labelText: "Tên Sách : "),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  onChanged: (value) {
                    name = value.toString();
                  },
                ),
                FormBuilderTextField(
                  attribute: 'sach',
                  decoration: InputDecoration(labelText: "Giá Sách : "),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  onChanged: (value) {
                    price = int.parse(value.toString());
                  },
                ),
                FormBuilderTextField(
                  attribute: 'sach',
                  decoration: InputDecoration(labelText: "Số lượng : "),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  onChanged: (value) {
                    amount = int.parse(value.toString());
                  },
                ),
                SizedBox(height: SizeConfig.blockSizeVertical * 10),
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
                              if (await widget.cubit.newBook(name, price, id, amount)) {
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
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
