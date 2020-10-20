import 'package:bhoot/pages/application_list_page.dart';
import 'package:bhoot/services/firebase_methods.dart';
import 'package:bhoot/style/styles.dart';
import 'package:flutter/material.dart';

class BuildHomeList extends StatelessWidget {
  final FirebaseMethods firebaseMethods;

  const BuildHomeList({Key key, this.firebaseMethods}) : super(key: key);

  _getApplicationfromIndex(int index) {
    if (index == 0) {
      return "DNA";
    } else if (index == 1) {
      return "RNA";
    } else if (index == 2) {
      return "Protein";
    } else if (index == 3) {
      return "Live Cell";
    } else if (index == 4) {
      return "Chromosomal";
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Center(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.6,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ApplicationListPage(
                      firebaseMethods: firebaseMethods,
                      application: _getApplicationfromIndex(index)
                          .toString()
                          .toLowerCase(),
                    ),
                  ),
                );
              },
              child: Card(
                child: Container(
                  child: Stack(
                    children: [
                      _backgroundAnimation("assets/gifs/dna.gif"),
                      _firstCircle(context),
                      _secondCircle(context),
                      _title(index),
                    ],
                  ),
                ),
                elevation: 20,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          width: 50,
        );
      },
    );
  }

  Widget _backgroundAnimation(String path) {
    return Container(
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(30)),
        image: DecorationImage(image: AssetImage(path), fit: BoxFit.cover),
      ),
    );
  }

  Widget _firstCircle(BuildContext context) {
    return Positioned(
      bottom: -MediaQuery.of(context).size.width * 0.6 * 0.4,
      left: -MediaQuery.of(context).size.width * 0.6 * 0.3,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.7,
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          color: firstCircleColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _secondCircle(BuildContext context) {
    return Positioned(
      bottom: -MediaQuery.of(context).size.width * 0.6 * 0.4,
      left: -MediaQuery.of(context).size.width * 0.6 * 0.3,
      child: Container(
        height: MediaQuery.of(context).size.width * 0.63,
        width: MediaQuery.of(context).size.width * 0.63,
        decoration: BoxDecoration(
          color: thirdCircleColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  Widget _title(int index) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, bottom: 20),
        child: Text(
          _getApplicationfromIndex(index),
          style: TextStyle(
              color: Colors.blueGrey,
              fontWeight: FontWeight.w900,
              fontSize: 25),
        ),
      ),
    );
  }
}
