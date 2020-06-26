import 'package:audioholics/screens/add_article/add_article_body_screen.dart';
import 'package:audioholics/screens/add_article/add_article_meta_screen.dart';
import 'package:audioholics/screens/home_feed_screen.dart';
import 'package:audioholics/screens/sign_in_screen.dart';
import 'package:audioholics/screens/sign_up/sign_up_artist_name_screen.dart';
import 'package:audioholics/screens/sign_up/sign_up_email_screen.dart';
import 'package:audioholics/screens/sign_up/sign_up_password_screen.dart';

final routes = {
  SignInScreen.routeName: (ctx) => SignInScreen(),
  SignUpArtistNameScreen.routeName: (ctx) => SignUpArtistNameScreen(),
  SignUpEmailScreen.routeName: (ctx) => SignUpEmailScreen(),
  SignUpPasswordScreen.routeName: (ctx) => SignUpPasswordScreen(),
  HomeFeedScreen.routeName: (ctx) => HomeFeedScreen(),
  AddArticleMetaScreen.routeName: (ctx) => AddArticleMetaScreen(),
  AddArticleBodyScreen.routeName: (ctx) => AddArticleBodyScreen(),
};
