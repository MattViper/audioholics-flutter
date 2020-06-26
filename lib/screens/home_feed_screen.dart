import 'dart:async';

import 'package:audioholics/providers/articles.dart';
import 'package:audioholics/screens/add_article/add_article_meta_screen.dart';
import 'package:audioholics/shared/color_palette.dart';
import 'package:audioholics/widgets/app_drawer.dart';
import 'package:audioholics/widgets/article_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import '../audioholics.dart';

class HomeFeedScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeFeedScreenState createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> with RouteAware {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  GlobalKey _fabKey = GlobalKey();
  bool _fabVisible = true;

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

  @override
  didPopNext() {
    Timer(duration, () {
      setState(() => _fabVisible = true);
    });
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
            child: _buildFAB(context, key: _fabKey),
          )
        ]),
      ),
    );
  }

  Widget _buildFAB(context, {key}) => FloatingActionButton(
        elevation: 0,
        backgroundColor: ColorPalette.PrimaryColor,
        key: key,
        onPressed: () => _onFabTap(context),
        child: Icon(Icons.add),
      );

  _onFabTap(BuildContext context) {
    setState(() => _fabVisible = false);

    final RenderBox fabRenderBox = _fabKey.currentContext.findRenderObject();
    final fabSize = fabRenderBox.size;
    final fabOffset = fabRenderBox.localToGlobal(Offset.zero);

    Navigator.of(context).push(PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          AddArticleMetaScreen(),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) =>
          _buildTransition(child, animation, fabSize, fabOffset),
    ));
  }

  Widget _buildTransition(Widget page, Animation<double> animation,
      Size fabSize, Offset fabOffset) {
    if (animation.value == 1) return page;

    final borderTween = BorderRadiusTween(
      begin: BorderRadius.circular(fabSize.width / 2),
      end: BorderRadius.circular(0.0),
    );
    final sizeTween =
        SizeTween(begin: fabSize, end: MediaQuery.of(context).size);
    final offsetTween = Tween<Offset>(
      begin: fabOffset,
      end: Offset.zero,
    );

    final easeInAnimation =
        CurvedAnimation(parent: animation, curve: Curves.easeIn);
    final easeAnimation =
        CurvedAnimation(parent: animation, curve: Curves.easeOut);

    final radius = borderTween.evaluate(easeInAnimation);
    final offset = offsetTween.evaluate(animation);
    final size = sizeTween.evaluate(easeInAnimation);

    final transitionFab = Opacity(
      opacity: 1 - easeAnimation.value,
      child: _buildFAB(context),
    );

    Widget positionedClippedChild(Widget child) => Positioned(
          width: size.width,
          height: size.height,
          left: offset.dx,
          top: offset.dy,
          child: ClipRRect(
            borderRadius: radius,
            child: child,
          ),
        );

    return Stack(
      children: <Widget>[
        positionedClippedChild(page),
        positionedClippedChild(transitionFab),
      ],
    );
  }
}
