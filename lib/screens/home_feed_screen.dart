import 'dart:async';

import 'package:animations/animations.dart';
import 'package:audioholics/providers/articles.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:audioholics/widgets/app_drawer.dart';
import 'package:audioholics/widgets/article_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../audioholics.dart';
import 'add_article/add_article_meta_screen.dart';

class HomeFeedScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeFeedScreenState createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> with RouteAware {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  GlobalKey _fabKey = GlobalKey();

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  dispose() {
    super.dispose();
    routeObserver.unsubscribe(this);
  }

  Future<void> _refreshArticles(BuildContext context) async {
    await Provider.of<Articles>(context, listen: false).fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:
            new Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
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
                  padding: const EdgeInsets.all(20.0),
                  child: InkWell(
                    child: IconButton(
                      color: ColorPalette.PrimaryColor,
                      onPressed: () => _scaffoldKey.currentState.openDrawer(),
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ]),
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
          FutureBuilder(
              future: _refreshArticles(context),
              builder: (BuildContext context, AsyncSnapshot snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? Center(child: CircularProgressIndicator())
                      : RefreshIndicator(
                          child: Consumer<Articles>(
                            builder: (ctx, articlesData, _) => articlesData
                                        .articlesCount >
                                    0
                                ? Swiper(
                                    itemCount: articlesData.articlesCount,
                                    itemWidth: 300.0,
                                    itemHeight: 400.0,
                                    layout: SwiperLayout.STACK,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ArticleCard(
                                          articlesData.articles[index]);
                                    },
                                  )
                                : Center(child: CircularProgressIndicator()),
                          ),
                          onRefresh: () => _refreshArticles(context))),
          Padding(
            padding: const EdgeInsets.fromLTRB(325, 100, 0, 0),
            child: _onFabTap(context),
          )
        ]),
      ),
    );
  }

  _onFabTap(BuildContext context) {
    return OpenContainer(
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      closedBuilder: (BuildContext context, VoidCallback action) =>
          FloatingActionButton(
              key: _fabKey,
              elevation: 0.0,
              backgroundColor: ColorPalette.PrimaryColor,
              child: Icon(
                Icons.add,
                color: Colors.white,
              )),
      openBuilder: (BuildContext context, VoidCallback action) =>
          AddArticleMetaScreen(),
      tappable: true,
    );
  }
}
