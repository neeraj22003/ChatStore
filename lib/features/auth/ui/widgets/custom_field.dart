import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomField extends StatelessWidget {
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final String hintext;
  final Function(String)? onfieldsubmitted;
  final Function(String?)? onSaved;
  final Widget? suffixicon;
  final bool obscureText;
  final int? maxlength;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  const CustomField({
    super.key,
    this.inputFormatters,
    this.keyboardType,
    this.onSaved,
    this.suffixicon,
    this.maxlength,
    this.obscureText = false,
    required this.validator,
    this.controller,
    required this.textInputAction,
    required this.hintext,
    this.onfieldsubmitted,
  });
  OutlineInputBorder normalborder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 1.2),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    );
  }

  OutlineInputBorder errorborder() {
    return OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1.2),
      borderRadius: const BorderRadius.all(Radius.circular(15)),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      border: InputBorder.none,
      hintText: hintext,
      suffixIcon: suffixicon,
      focusedErrorBorder: errorborder(),
      errorBorder: errorborder(),
      enabledBorder: normalborder(),
      focusedBorder: normalborder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        obscureText: obscureText,
        onFieldSubmitted: onfieldsubmitted,
        validator: validator,
        controller: controller,
        textInputAction: textInputAction,
        decoration: inputDecoration(),
        onSaved: onSaved,
        maxLength: maxlength,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
      ),
    );
  }
}
