import 'dart:async';

import 'package:bhoot/pages/search_page.dart';
import 'package:bhoot/services/firebase_methods.dart';
import 'package:bhoot/style/styles.dart';
import 'package:bhoot/widgets/app_background.dart';
import 'package:bhoot/widgets/build_home_list.dart';
import 'package:flutter/material.dart';
import 'package:rect_getter/rect_getter.dart';

class HomePage extends StatefulWidget {
  final FirebaseMethods firebaseMethods;

  const HomePage({Key key, this.firebaseMethods}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 100);
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;
  AnimationController _controller;

  Animation<double> _fadeAnimation;
  Animation<Offset> _slideAnimation;
  Animation<Offset> _slideAnimation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0), end: Offset(-0.075, 0))
        .animate(_controller);
    _slideAnimation2 = Tween<Offset>(begin: Offset(0, 0), end: Offset(0.075, 0))
        .animate(_controller);
    _controller.forward();
  }

  playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            AppBackground(
              backgroundColor: backgroundColor,
              firstCircleColor: firstCircleColor,
              secondCircleColor: secondCircleColor,
              thirdCircleColor: thirdCircleColor,
            ),
            SlideTransition(
              position: _slideAnimation2,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: _homeTitle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60),
              child: FutureBuilder(
                  future: playAnimation(),
                  builder: (context, snapshot) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: BuildHomeList(
                          firebaseMethods: widget.firebaseMethods,
                        ),
                      ),
                    );
                  }),
            ),
            _searchButton(),
            _ripple(),
          ],
        ),
      ),
    );
  }

  Widget _ripple() {
    if (rect == null) {
      return Container();
    }
    return AnimatedPositioned(
      duration: animationDuration,
      left: 1.3 * rect.left,
      right: MediaQuery.of(context).size.width - rect.right,
      bottom: MediaQuery.of(context).size.height - rect.bottom,
      top: rect.top,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: primaryColor,
        ),
      ),
    );
  }

  void _goToNextPage() {
    Navigator.of(context)
        .push(
          FadeRouteBuilder(
            page: SearchPage(
              firebaseMethods: widget.firebaseMethods,
            ),
          ),
        )
        .then((_) => setState(() => rect = null));
  }

  void _ontap() {
    setState(() => rect = RectGetter.getRectFromKey(rectGetterKey));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() =>
          rect = rect.inflate(1.5 * MediaQuery.of(context).size.longestSide));
      Future.delayed(animationDuration + delay, _goToNextPage);
    });
  }

  Widget _homeTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Bhoot", style: headingStyle),
          Text(
            "Glo-biology Tools",
            style: subHeadingStyle,
          )
        ],
      ),
    );
  }

  Widget _searchButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0, top: 20),
      child: Align(
        alignment: Alignment.topRight,
        child: RectGetter(
          key: rectGetterKey,
          child: GestureDetector(
            onTap: _ontap,
            child: Material(
              elevation: 10,
              shape: CircleBorder(),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.search,
                  size: 30,
                  color: primaryColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FadeRouteBuilder<T> extends PageRouteBuilder<T> {
  final Widget page;

  FadeRouteBuilder({@required this.page})
      : super(
          pageBuilder: (context, animation1, animation2) => page,
          transitionsBuilder: (context, animation1, animation2, child) {
            return FadeTransition(opacity: animation1, child: child);
          },
        );
}
