import 'package:flutter/material.dart';

class FirstIntroPage extends StatefulWidget {
  final String text;
  final String imgName;
  final int indexPage;
  FirstIntroPage({Key key, this.text, this.imgName, this.indexPage})
      : super(key: key);

  @override
  _FirstIntroPageState createState() => _FirstIntroPageState();
}

class _FirstIntroPageState extends State<FirstIntroPage>
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

    lateAnimation = Tween(begin: 0.0, end: -1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 1.0, curve: Curves.bounceIn),
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reset();
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

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Color(0xffece6df),
      child: Column(
        children: <Widget>[
          SizedBox(height: MediaQuery.of(context).size.height * 0.14),
          AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return Transform(
                transform: Matrix4.translationValues(
                    -animation.value * deviceWidth, 0.0, 0.0),
                child: matchedWidget(widget.indexPage),
              );
            },
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          AnimatedBuilder(
            animation: lateAnimation,
            builder: (BuildContext context, Widget child) {
              return Transform(
                transform: Matrix4.translationValues(
                    0.0, -animation.value * deviceWidth, 0.0),
                child: Container(
                  child: Image.asset(widget.imgName),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget matchedWidget(int index) {
    switch (index) {
      case 0:
        return firstTxt();
      case 1:
        return secondTxt();
      default:
        return firstTxt();
    }
  }

  Widget buildContainer() {
    return Container(
      margin: EdgeInsets.only(bottom: 2.0),
      height: 20.0,
      width: 120.0,
      color: Colors.blueAccent,
    );
  }

  Widget firstTxt() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Clear sort items by',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w300),
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
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Container(
          width: MediaQuery.of(context).size.height * 0.3,
          child: Text(
            "important items are highlighted at the top",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }

  Widget secondTxt() {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Tap and hold',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
            children: <TextSpan>[
              TextSpan(
                text: ' to pick an item up.',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Container(
          width: MediaQuery.of(context).size.height * 0.3,
          child: Text(
            "Drag it up or down to change its priority",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}
