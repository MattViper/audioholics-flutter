import 'package:audioholics/providers/auth.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({Key key}) : super(key: key);

  static const routeName = '/home';

  @override
  _HomeFeedScreenState createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
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
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:
            new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: InkWell(
              child: IconButton(
                color: ColorPalette.PrimaryColor,
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
                icon: Icon(Icons.menu),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              'Your Feed',
              style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 32.0,
                  fontWeight: FontWeight.w700,
                  color: ColorPalette.PrimaryColor),
            ),
          ),
          new Swiper(
            itemCount: 10,
            itemWidth: 300.0,
            itemHeight: 400.0,
            layout: SwiperLayout.STACK,
            itemBuilder: (BuildContext context, int index) {
              return new Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  color: ColorPalette.PrimaryColor,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Text(
                      'Hello there',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ));
            },
          ),
        ]),
      ),
    );
  }
}
