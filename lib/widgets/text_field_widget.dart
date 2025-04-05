import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final bool? obscureText;
  final Widget prefixIcon;
  final String text;
  final TextEditingController? controller;

  const TextFieldWidget({super.key, this.obscureText, required this.prefixIcon, required this.text, this.controller});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}
class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      decoration: BoxDecoration(
        color: Color(0xfff7f7f7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText ?? false,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.text,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
          prefixIcon: widget.prefixIcon,
          prefixIconColor: Colors.grey,
        ),
      ),
    );
  }
}



















