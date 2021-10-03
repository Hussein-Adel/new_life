import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminScreenWidget extends StatelessWidget {
  IconData iconData;
  String title;
  Color color;
  Function()? onPress;
  AdminScreenWidget(
      {required this.iconData,
      required this.title,
      required this.color,
      required this.onPress});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1, 4),
              blurRadius: 8.0,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: color,
              size: MediaQuery.of(context).size.width * 0.15,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
