import 'package:audioholics/audioholics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/articles.dart';
import 'providers/auth.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: Auth()),
    ChangeNotifierProxyProvider<Auth, Articles>(create: null, update: null)
  ], child: Consumer<Auth>(builder: (ctx, auth, _) => Audioholics())));
}
