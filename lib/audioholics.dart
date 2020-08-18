import 'package:audioholics/models/secure_storage.dart';
import 'package:audioholics/providers/articles.dart';
import 'package:audioholics/providers/auth.dart';
import 'package:audioholics/providers/comments.dart';
import 'package:audioholics/providers/profiles.dart';
import 'package:audioholics/screens/home_feed_screen.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes.dart';
import 'screens/sign_in_screen.dart';

final routeObserver = RouteObserver<PageRoute>();
final duration = const Duration(milliseconds: 200);

class Audioholics extends StatelessWidget with SecureStorageMixin {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Auth()),
          ChangeNotifierProxyProvider<Auth, Articles>(
              create: (ctx) => Articles(),
              update: (context, auth, articles) => articles.update(auth.token,
                  auth.userId, articles == null ? [] : articles.articles)),
          ChangeNotifierProxyProvider<Auth, Comments>(
              create: (ctx) => Comments(),
              update: (context, auth, comments) => comments.update(auth.token,
                  auth.userId, comments == null ? [] : comments.comments)),
          ChangeNotifierProxyProvider<Auth, Profiles>(
              create: (ctx) => Profiles(),
              update: (context, auth, profiles) => profiles.update(auth.token,
                  auth.userId, profiles == null ? null : profiles.profile)),
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                title: 'audioholics',
                theme: ThemeData(
                  primarySwatch: Colors.deepPurple,
                  accentColor: ColorPalette.PrimaryColor,
                  fontFamily: 'Montserrat',
                ).copyWith(
                  pageTransitionsTheme: const PageTransitionsTheme(
                    builders: <TargetPlatform, PageTransitionsBuilder>{
                      TargetPlatform.android: ZoomPageTransitionsBuilder(),
                    },
                  ),
                ),
                home: auth.isAuth
                    ? HomeFeedScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) => SignInScreen(),
                      ),
                navigatorObservers: [routeObserver],
                routes: routes)));
  }
}
