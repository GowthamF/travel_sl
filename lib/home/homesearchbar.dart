import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          height: 50,
          child: TextFormField(
            style: TextStyle(fontSize: 15),
            autovalidate: true,
            decoration: InputDecoration(
              focusColor: Colors.blue[500],
              fillColor: Colors.blue[800],
              prefixIcon: Icon(Icons.search),
              hintStyle: TextStyle(fontSize: 15),
              hintText: 'Search',
              border: OutlineInputBorder(),
              contentPadding:
                  EdgeInsets.only(top: 0, bottom: 10, left: 10, right: 10),
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight - 6);
}
