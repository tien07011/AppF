import 'package:app_tv/app/components/text-field/text-field.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TextFieldView extends StatefulWidget {
  final List<String Function(dynamic)> validators;
  final String title;
  final String attribute;
  final GlobalKey key;
  final Function(String) onSaved;

  TextFieldView({
    @required this.onSaved,
    @required this.attribute,
    this.title,
    this.key,
    this.validators,
  });

  @override
  State<StatefulWidget> createState() {
    return TextFieldState();
  }
}

class TextFieldState extends State<TextFieldView> {
  TextFieldCubit _cubit = TextFieldCubit();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (widget.attribute == 'password')
          ? BlocBuilder<TextFieldCubit, bool>(
              cubit: _cubit,
              builder: (context, hasShowPassword) {
                return FormBuilderTextField(
                  key: widget.key,
                  maxLines: 1,
                  attribute: widget.attribute,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: widget.title,
                    hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide(color: Color(0xff068189))),
//                    suffixIcon: IconButton(
//                      icon: hasShowPassword
//                          ? const Icon(Icons.visibility_off)
//                          : const Icon(Icons.visibility),
//                      onPressed: () {
//                        _cubit.toggleIconPassword();
//                      },
//                    ),
                  ),
                  obscureText: !hasShowPassword,
                  keyboardType: TextInputType.text,
                  validators: widget.validators,
                  onChanged: (dynamic val) {
                    widget.onSaved((val as String).trim());
                  },
                );
              },
            )
          : FormBuilderTextField(
              maxLines: 1,
              key: widget.key,
              attribute: widget.attribute,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: widget.title,
                hintStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(100.0),
                  borderSide: BorderSide(color: Color(0xff068189)),
                ),
              ),
              keyboardType: TextInputType.text,
              validators: widget.validators,
              onChanged: (dynamic val) {
                widget.onSaved((val as String).trim());
              },
            ),
    );
  }
}
