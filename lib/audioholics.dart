import 'package:audioholics/models/secure_storage.dart';
import 'package:audioholics/providers/articles.dart';
import 'package:audioholics/providers/auth.dart';
import 'package:audioholics/screens/home_feed_screen.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'screens/sign_in_screen.dart';

class Audioholics extends StatelessWidget with SecureStorageMixin {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Articles>(
              create: (ctx) => Articles(),
              update: (context, auth, articles) => articles.update(auth.token,
                  auth.userId, articles == null ? [] : articles.articles))
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                title: 'audioholics',
                theme: ThemeData(
                  primarySwatch: Colors.deepPurple,
                  accentColor: ColorPalette.PrimaryColor,
                  fontFamily: 'Montserrat',
                ),
                home: auth.isAuth
                    ? HomeFeedScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) => SignInScreen(),
                      ),
                routes: routes)));
  }
}
