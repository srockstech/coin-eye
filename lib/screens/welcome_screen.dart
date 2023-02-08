import 'package:coin_eye/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'signin_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, initialIndex: 1, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    TextStyle headingTextStyle = TextStyle(
        color: kFontColor,
        fontWeight: FontWeight.bold,
        fontSize: screenHeight * 0.035);
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: screenHeight * 0.07,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(
                    screenHeight * 0.04, screenHeight * 0.02)),
          ),
          leadingWidth: 0,
          leading: SizedBox(
            height: 0,
          ),
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'coin',
                style: TextStyle(
                  height: 1,
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: screenHeight * 0.05,
                  letterSpacing: -1.5,
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 0),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              Text(
                'eye',
                style: TextStyle(
                  height: 1,
                  color: Color(0xFF2BFFF1),
                  shadows: <Shadow>[
                    Shadow(
                      color: Colors.black54,
                      offset: Offset(0, 0),
                      blurRadius: 5,
                    ),
                  ],
                  fontWeight: FontWeight.w900,
                  fontSize: screenHeight * 0.05,
                  letterSpacing: -1.5,
                ),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.09),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      width: screenHeight * 0.025,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                          ),
                          BoxShadow(
                            color: Colors.white,
                            offset: Offset(0, 0),
                            blurRadius: 4,
                            spreadRadius: -3,
                          ),
                        ],
                        borderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 0.1)),
                        border: Border.all(
                          color: kBorderColor,
                        ),
                      ),
                      height: screenHeight * 0.055,
                      width: screenHeight * 0.2,
                      child: TabBar(
                        controller: _tabController,
                        splashFactory: NoSplash.splashFactory,
                        splashBorderRadius: BorderRadius.all(
                            Radius.circular(screenHeight * 0.1)),
                        indicator: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(
                              Radius.circular(screenHeight * 0.1)),
                        ),
                        overlayColor: MaterialStateProperty.all(Colors.black),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Tab(
                            text: 'SignIn',
                          ),
                          Tab(
                            text: 'SignUp',
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      SignInScreen(
                        onTap: () {
                          _tabController.animateTo(1);
                        },
                      ),
                      SignUpScreen(
                        onTap: () {
                          _tabController.animateTo(0);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
