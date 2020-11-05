import 'package:flutter/material.dart';
import 'package:mobile_programing/utilities.dart';
import 'package:mobile_programing/welcome_page.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<Curve> curveList = [
    Curves.bounceIn,
    Curves.bounceInOut,
    Curves.bounceOut,
    Curves.decelerate,
    Curves.ease,
    Curves.easeIn,
    Curves.easeInBack,
    Curves.easeInCirc,
    Curves.easeInCubic,
    Curves.easeInExpo,
    Curves.easeInOut,
    Curves.easeInOutBack,
    Curves.easeInOutCirc,
    Curves.easeInOutCubic,
    Curves.easeInOutExpo,
    Curves.easeInOutQuad,
    Curves.easeInOutQuart,
    Curves.easeInOutQuint,
    Curves.easeInOutSine,
    Curves.easeInQuad,
    Curves.easeInQuart,
    Curves.easeInQuint,
    Curves.easeInSine,
    Curves.easeInToLinear,
    Curves.easeOut,
    Curves.easeOutBack,
    Curves.easeOutCubic,
    Curves.easeOutExpo,
    Curves.easeOutQuad,
    Curves.easeOutQuart,
    Curves.easeOutQuint,
    Curves.easeOutSine,
    Curves.elasticIn,
    Curves.elasticInOut,
    Curves.elasticOut,
    Curves.fastLinearToSlowEaseIn,
    Curves.fastOutSlowIn,
    Curves.linear,
    Curves.linearToEaseOut,
    Curves.slowMiddle,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(""),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, anotherAnimation) {
                  return OffsetDelay();
                },
                transitionDuration: Duration(milliseconds: 250),
                transitionsBuilder:
                    (context, animation, anotherAnimation, child) {
                  animation =
                      CurvedAnimation(curve: curveList[3], parent: animation);
                  return SlideTransition(
                    position:
                        Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                            .animate(animation),
                    child: child,
                  );
                }));
          },
          onPanUpdate: (details) {
            if (details.delta.dx < 0) {
              Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, anotherAnimation) {
                    return OffsetDelay();
                  },
                  transitionDuration: Duration(milliseconds: 250),
                  transitionsBuilder:
                      (context, animation, anotherAnimation, child) {
                    animation =
                        CurvedAnimation(curve: curveList[3], parent: animation);
                    return SlideTransition(
                      position:
                          Tween(begin: Offset(1.0, 0.0), end: Offset(0.0, 0.0))
                              .animate(animation),
                      child: child,
                    );
                  }));
            }
          },
          child: Container(
            child: Column(
              children: [
                Spacer(),
                RichText(
                  text: TextSpan(
                    text: 'Welcome to',
                    style: TextStyle(
                        color: ColorsBase.blackColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w300),
                    /*defining default style is optional */
                    children: <TextSpan>[
                      TextSpan(
                          text: ' Clear',
                          style: TextStyle(
                              color: ColorsBase.blackColor,
                              fontSize: 40,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Tap or swipe',
                    style: TextStyle(
                        color: ColorsBase.blackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                    /*defining default style is optional */
                    children: <TextSpan>[
                      TextSpan(
                          text: ' to begin',
                          style: TextStyle(
                              color: ColorsBase.blackColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w300)),
                    ],
                  ),
                ),
                Spacer()
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
