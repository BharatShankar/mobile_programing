import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:mobile_programing/home_page.dart';
import 'package:mobile_programing/utilities.dart';

import 'introduction_pages.dart';

class OffsetDelay extends StatefulWidget {
  @override
  _OffsetDelayState createState() => _OffsetDelayState();
}

class _OffsetDelayState extends State<OffsetDelay>
    with SingleTickerProviderStateMixin {
  Animation animation;

  Animation lateAnimation;

  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(parent: animationController, curve: Curves.fastOutSlowIn),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reset();
          animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              parent: animationController, curve: Curves.fastOutSlowIn));
        }
      });

    animationController.forward();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget buildContainer() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.0),
      height: 20.0,
      width: 120.0,
      color: Colors.blueAccent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(child: IntroPages()),
    );
  }
}

class Pages extends StatelessWidget {
  final text;
  final String decorationType;

  Pages({this.text, this.decorationType});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(
                text: 'Clear sort items by',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
                children: <TextSpan>[
                  TextSpan(
                      text: ' priority.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ]),
    );
  }
}

class IntroPages extends StatefulWidget {
  IntroPages({Key key}) : super(key: key);

  @override
  _IntroPagesState createState() => _IntroPagesState();
}

class _IntroPagesState extends State<IntroPages> {
  final pageController = PageController(initialPage: 0);
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            onPageChanged: (pageNumber) {
              pageIndex = 2;

              setState(() {
                pageIndex = pageNumber;
              });
            },
            controller: pageController,
            children: <Widget>[
              FirstIntroPage(
                imgName: Images.pic_1,
                indexPage: 0,
              ),
              FirstIntroPage(
                imgName: Images.pic_2,
                indexPage: 1,
              ),
              FirstIntroPage(
                imgName: Images.pic_3,
                indexPage: 2,
              ),
              Container(
                child: Center(
                  child: Column(
                    children: [
                      Image.asset(Images.red_cloud),
                      RichText(
                        text: TextSpan(
                          text: 'Use',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.w300),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' iCloud',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          "Storing your lists in iCloud allows you to keep your data i sync across your iPhone",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w300),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Not now"),
                          ),
                          RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                            },
                            child: Text(
                              "Use iCloud",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                color: Color(0xffece6df),
              ),
            ],
          ),
          pageIndex == 3
              ? Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.05,
                  child: Container(
                    child: dotForPaging(pageIndex),
                    width: 300,
                    height: 100,
                  ),
                )
              : Positioned(
                  top: MediaQuery.of(context).size.height * 0.3,
                  child: Container(
                    height: 100,
                    width: 300,
                    child: dotForPaging(pageIndex),
                  ),
                )
        ],
      ),
    );
  }

  Widget dotForPaging(int selectedIndex) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          8,
          (index) {
            return selectedIndex == index
                ? Container(
                    height: 6,
                    width: 6,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.black),
                  )
                : Container(
                    height: 5,
                    width: 5,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey),
                  );
          },
        ));
  }
}
