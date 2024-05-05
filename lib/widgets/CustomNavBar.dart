import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Color(0xFF292B37),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "/");
            },
            child: Icon(
              Icons.home,
              size: 35,
              color: Color(0xFF00A470),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, "categoryPage");
            },
            child: Icon(
              Icons.category,
              size: 35,
              color: Color(0xFF00A470),
            ),
          )
        ],
      ),
    );
  }
}
