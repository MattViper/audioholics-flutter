import 'package:audioholics/models/secure_storage.dart';
import 'package:audioholics/providers/auth.dart';
import 'package:audioholics/providers/profiles.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:audioholics/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SecureStorageMixin {
  Future<void> _fetchProfile(BuildContext context) async {
    final email = Provider.of<Auth>(context).email;
    await Provider.of<Profiles>(context, listen: false).findByEmail(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            future: _fetchProfile(context),
            builder: (BuildContext context, AsyncSnapshot snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? Center(child: CircularProgressIndicator())
                    : Consumer<Profiles>(
                        builder: (ctx, profileData, _) => Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          child: SingleChildScrollView(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    profileData.profile.artistName,
                                    style: TextStyle(
                                        color: ColorPalette.PrimaryColor,
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Text(
                                    profileData.profile.email,
                                    style: TextStyle(
                                        color: ColorPalette.PrimaryColor,
                                        fontSize: 32.0,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ])),
                        ),
                      ),
          ),
        ));
  }
}
