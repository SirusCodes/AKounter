import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CTextFormField extends StatelessWidget {
  CTextFormField({
    this.label,
    this.hint,
    this.controller,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
  });
  final String label, hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function validator;
  final Function onSaved, onChanged;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      style: TextStyle(color: Theme.of(context).accentColor),
      textCapitalization: textCapitalization,
      controller: controller,
      validator: validator,
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Theme.of(context).splashColor,
        ),
        labelText: label,
        labelStyle: TextStyle(color: Theme.of(context).accentColor),
        border: border(context),
        focusedBorder: border(context),
      ),
      onChanged: onChanged,
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
