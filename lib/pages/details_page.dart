import 'package:auto_size_text/auto_size_text.dart';
import 'package:bhoot/models/fluorophores.dart';
import 'package:bhoot/style/styles.dart';
import 'package:bhoot/widgets/app_background.dart';
import 'package:bhoot/widgets/label_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class DetailsPage extends StatefulWidget {
  final Fluorophores fluorophores;

  const DetailsPage({Key key, this.fluorophores}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> fadeAnimation;
  Animation<double> scaleAnimation;
  Animation<Offset> slideAnimation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
    slideAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.decelerate));
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
              backgroundColor: primaryColor,
              firstCircleColor: firstOrangeCircleColor,
              secondCircleColor: secondOrangeCircleColor,
              thirdCircleColor: thirdOrangeCircleColor,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 18, left: 8),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                FutureBuilder(
                  future: playAnimation(),
                  builder: (context, snapshot) {
                    return FadeTransition(
                      opacity: fadeAnimation,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 100),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            LabelValueWidget(
                              value: widget.fluorophores.em?.toString() ?? "-",
                              label: "emission",
                              labelStyle: whiteLabelTextStyle,
                              valueStyle: whiteValueTextStyle,
                            ),
                            LabelValueWidget(
                              value: widget.fluorophores.ex?.toString() ?? "-",
                              label: "excitation",
                              labelStyle: whiteLabelTextStyle,
                              valueStyle: whiteValueTextStyle,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Flexible(
                  child: FadeTransition(
                    opacity: fadeAnimation,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(80)),
                        child: Container(
                          color: Colors.white.withOpacity(0.8),
                          height: double.infinity,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 50.0, left: 40, right: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.fluorophores.name ?? "",
                                  style: headingStyle,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Flexible(
                                  child: StaggeredGridView.count(
                                    crossAxisCount: 4,
                                    staggeredTiles: [
                                      StaggeredTile.count(2, 2),
                                      StaggeredTile.count(2, 4),
                                      StaggeredTile.count(2, 2),
                                      StaggeredTile.count(4, 2)
                                    ],
                                    children: [
                                      _numberCard("Stoke's Shift",
                                          "${widget.fluorophores.stoke_shift ?? "-"}"),
                                      _applicationCard(),
                                      _numberCard("Quantum Yield",
                                          "${widget.fluorophores.quantum_yield ?? "-"}"),
                                      _safetyCard(),
                                    ],
                                    mainAxisSpacing: 4.0,
                                    crossAxisSpacing: 4.0,
                                    padding: const EdgeInsets.all(4.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _numberCard(String title, String val) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            AutoSizeText(
              title,
              maxFontSize: 22,
              minFontSize: 14,
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Center(
              child: AutoSizeText(
                val,
                minFontSize: 50,
                maxFontSize: 70,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: primaryColor,
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }

  Widget _applicationCard() {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Application",
              style: subHeadingStyle,
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              child: Center(
                child: Image.asset(
                    "assets/images/${widget.fluorophores.application.split(' ')[0]}.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _safetyCard() {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            // Text(
            //   "Safety",
            //   style: subHeadingStyle,
            // ),
            AutoSizeText(
              "Safety",
              minFontSize: 18,
              maxFontSize: 22,
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Center(
              child: AutoSizeText(
                "${widget.fluorophores.safety ?? "-"}",
                minFontSize: 30,
                maxFontSize: 40,
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: primaryColor,
                ),
              ),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}
