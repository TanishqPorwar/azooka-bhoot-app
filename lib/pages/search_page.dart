import 'package:bhoot/services/firebase_methods.dart';
import 'package:bhoot/style/styles.dart';
import 'package:bhoot/widgets/app_background.dart';
import 'package:bhoot/widgets/build_list.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  final FirebaseMethods firebaseMethods;

  const SearchPage({Key key, this.firebaseMethods}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  String _searchText = "";
  TextEditingController _searchController;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AnimationController _controller;

  Animation<double> _fadeAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(0.5, 0), end: Offset(0, 0))
        .animate(_controller);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            AppBackground(
              backgroundColor: primaryColor,
              firstCircleColor: firstOrangeCircleColor,
              secondCircleColor: secondOrangeCircleColor,
              thirdCircleColor: thirdOrangeCircleColor,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 155.0),
              child: StreamBuilder(
                stream: widget.firebaseMethods.getDataByQuery(_searchText),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("Error"));
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ));
                      break;
                    default:
                      return BuildList(
                        snapshot: snapshot,
                      );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: _buildSearchTextFormField(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8, left: 8),
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
            )
          ],
        ),
      ),
    );
  }

  _buildSearchTextFormField() {
    return Container(
      height: 65.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: thirdCircleColor,
      ),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        style: TextStyle(fontSize: 30),
        decoration: InputDecoration(
            hintText: "Search",
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
            suffixIcon: IconButton(
              padding: EdgeInsets.only(top: 15),
              icon: Icon(Icons.search),
              onPressed: () {
                FormState formState = _formKey.currentState;
                if (formState.validate()) {
                  formState.save();
                }
              },
              iconSize: 30.0,
            )),
        onChanged: (newValue) {
          setState(() {
            _searchText = newValue;
          });
        },
        validator: (value) {
          if (value.isEmpty) return "Enter a vaild query";
        },
        onSaved: (newValue) {
          FormState formState = _formKey.currentState;
          if (formState.validate()) {
            formState.save();
          }
        },
      ),
    );
  }
}
