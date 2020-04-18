import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget implements PreferredSizeWidget {
  final FocusNode focusNode;

  HomeSearchBar({this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          child: TextFormField(
            focusNode: focusNode,
            style: TextStyle(fontSize: 15),
            autovalidate: true,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(fontSize: 15, color: Colors.white),
              hintText: 'Search',
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              contentPadding:
                  EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight - 6);
}
