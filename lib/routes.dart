import 'package:audioholics/screens/home_feed_screen.dart';
import 'package:audioholics/screens/sign_in_screen.dart';
import 'package:audioholics/screens/sign_up_artist_name_screen.dart';

final routes = {
  SignInScreen.routeName: (ctx) => SignInScreen(),
  SignUpArtistNameScreen.routeName: (ctx) => SignUpArtistNameScreen(),
  HomeFeedScreen.routeName: (ctx) => HomeFeedScreen(),
};
