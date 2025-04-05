import 'package:flutter/material.dart';

class RedButtonWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  const RedButtonWidget({super.key, required this.onPressed, required this.text});

  @override
  State<RedButtonWidget> createState() => _RedButtonWidgetState();
}

class _RedButtonWidgetState extends State<RedButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xffcd0222),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
          )
        ),
        child: Text(widget.text, style: TextStyle(fontSize: 15),),
      ),
    );
  }
}
