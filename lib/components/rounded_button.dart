import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  Color my_color;
  String my_text;
  final Function()? on_pressed;

  RoundedButton({
    required this.on_pressed,
    required this.my_text,
    required this.my_color,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: my_color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: on_pressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            my_text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
