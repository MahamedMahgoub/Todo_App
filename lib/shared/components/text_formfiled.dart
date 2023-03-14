import 'package:flutter/material.dart';

class DefulatTextFelid extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?) validator;
  final TextInputType? keyboardType;
  final Function(String)? onSubmit;
  final Icon? pefix;
  final Widget? sufix;
  final bool? isPassword;
  final Function()? onTap;

  DefulatTextFelid({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.validator,
    this.keyboardType,
    this.onSubmit,
    this.pefix,
    this.sufix,
    this.isPassword = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
          validator: (T) => validator(T),
          controller: controller,
          onFieldSubmitted: onSubmit,
          keyboardType: keyboardType,
          obscureText: isPassword!,
          onTap: onTap,
          decoration: InputDecoration(
            labelText: labelText,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(0.0)),
            prefixIcon: pefix,
            suffix: sufix,
          )),
    );
  }
}
