import 'package:bhoot/services/firebase_methods.dart';
import 'package:bhoot/style/styles.dart';
import 'package:bhoot/widgets/app_background.dart';
import 'package:bhoot/widgets/build_list.dart';
import 'package:flutter/material.dart';

class ApplicationListPage extends StatefulWidget {
  final FirebaseMethods firebaseMethods;
  final String application;

  const ApplicationListPage({Key key, this.firebaseMethods, this.application})
      : super(key: key);
  @override
  _ApplicationListPageState createState() => _ApplicationListPageState();
}

class _ApplicationListPageState extends State<ApplicationListPage> {
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
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  ((widget.application == "dna" || widget.application == "rna")
                          ? widget.application.toUpperCase()
                          : widget.application[0].toUpperCase() +
                              widget.application.substring(1)) +
                      " Stains",
                  style: headingStyle,
                ),
                SizedBox(
                  height: 30,
                ),
                StreamBuilder(
                  stream: widget.firebaseMethods
                      .getDataByApplication(widget.application),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text("Error"));
                    }
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        );
                        break;
                      default:
                        return Flexible(
                          child: BuildList(
                            snapshot: snapshot,
                          ),
                        );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
