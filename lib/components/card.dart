import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomCard extends StatelessWidget {
  bool lead;
  String leading;
  String title;
  String subtitle;
  String trailing;
  Color color;
  final Function()? onPressed;
  final Function()? onTape;
  CustomCard({
    required this.lead,
    required this.leading,
    required this.subtitle,
    required this.trailing,
    required this.onPressed,
    required this.onTape,
    required this.title,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 10.0,
            ),
          ],
        ),
        child: ListTile(
          leading: Container(
            margin: EdgeInsets.all(0),
            width: 80,
            height: 90,
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 80,
              child: lead
                  ? InkWell(
                      child: Image.asset('assets/collector.jpg'),
                      onTap: onTape,
                    )
                  : Text(
                      leading,
                      style: Theme.of(context).textTheme.headline2,
                    ),
            ),
          ),
          title: Text(
            title,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline2,
          ),
          subtitle: Text(
            subtitle,
            maxLines: 1,
            style: Theme.of(context).textTheme.headline2,
          ),
          trailing: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Text(
              trailing,
              maxLines: 1,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          onTap: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }
}
