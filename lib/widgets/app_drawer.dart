import 'package:audioholics/providers/auth.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Hello there!',
              style: TextStyle(
                  color: ColorPalette.PrimaryColor,
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700),
            ),
          ),
          ListTile(
            title: Text("Home"),
          ),
          ListTile(
            title: Text("Profile"),
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () => Provider.of<Auth>(context, listen: false).logout(),
          )
        ],
      ),
    );
  }
}
