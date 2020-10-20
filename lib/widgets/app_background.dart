import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Color backgroundColor,
      firstCircleColor,
      secondCircleColor,
      thirdCircleColor;

  const AppBackground(
      {Key key,
      this.backgroundColor,
      this.firstCircleColor,
      this.secondCircleColor,
      this.thirdCircleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final width = constraints.maxWidth;
        return Stack(
          children: <Widget>[
            Container(
              color: backgroundColor,
            ),
            Positioned(
              left: -(height - width) / 2,
              bottom: height * 0.20,
              child: Container(
                height: height,
                width: height,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: firstCircleColor,
                ),
              ),
            ),
            Positioned(
              left: width * 0.15,
              top: -width * 0.5,
              child: Container(
                height: width * 1.6,
                width: width * 1.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: secondCircleColor,
                ),
              ),
            ),
            Positioned(
              right: -width * 0.2,
              top: -50,
              child: Container(
                height: width * 0.6,
                width: width * 0.6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: thirdCircleColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
