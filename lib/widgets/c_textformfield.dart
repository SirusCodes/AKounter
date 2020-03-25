import 'package:flutter/material.dart';

class CTextFormField extends StatelessWidget {
  CTextFormField({
    this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onSaved,
  });
  final String label, hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function validator;
  final Function onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: TextStyle(color: Theme.of(context).accentColor),
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Theme.of(context).accentColor),
        labelText: label,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        border: border(context),
        focusedBorder: border(context),
      ),
    );
  }

  OutlineInputBorder border(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
        width: 1.0,
      ),
    );
  }
}
