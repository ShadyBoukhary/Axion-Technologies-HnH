import 'package:flutter/material.dart';
import 'package:hnh/app/utils/constants.dart';
class InputField extends StatelessWidget {

  final TextEditingController _controller;
  final String _hintText;
  final FocusNode _focusNode;
  TextInputType _type;
  bool isPassword;

  InputField(this._controller, this._hintText, this._focusNode, {bool isPassword = false, TextInputType type = TextInputType.text}) {
    this.isPassword = isPassword;
    _type = type;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
        child: TextFormField(
          keyboardType: _type,
          controller: _controller,
          focusNode: _focusNode,
          obscureText: isPassword,     
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide:
                    BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4))),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide:
                    BorderSide(color: Color.fromRGBO(255, 255, 255, 0.4))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide:
                    BorderSide(color: Color.fromRGBO(230, 38, 39, 0.8))),
            fillColor: Color.fromRGBO(255, 255, 255, 0.4),
            filled: true,
            hintText: _hintText,
            hintStyle: UIConstants.fieldHintStyle,
          ),
        ),
      );
  }
}
