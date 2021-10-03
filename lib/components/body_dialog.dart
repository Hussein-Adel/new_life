import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BodyDialog extends StatefulWidget {
  List<Widget> body;
  BodyDialog({
    required this.body,
  });
  @override
  _BodyDialogState createState() => _BodyDialogState();
}

class _BodyDialogState extends State<BodyDialog> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        insetPadding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        child: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(0),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.body),
          ),
        ),
      ),
    );
  }
}
