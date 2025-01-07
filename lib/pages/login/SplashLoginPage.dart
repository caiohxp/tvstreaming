import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tvabertaflix/Animations/FadeAnimations.dart';
import 'package:tvabertaflix/pages/HomePages.dart';
import 'package:tvabertaflix/pages/login/ViewLoginPage.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _scale2Controller;
  late AnimationController _widthController;
  late AnimationController _positionController;

  late Animation<double> _scaleAnimation;
  late Animation<double> _scale2Animation;
  late Animation<double> _widthAnimation;
  late Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {}

            _widthController.forward();
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(microseconds: 600));

    _widthAnimation = Tween<double>(
      begin: 80.0,
      end: 300.0,
    ).animate(_widthController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _positionController.forward();
        }
      });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation = Tween<double>(
      begin: 0.0,
      end: 215.0,
    ).animate(_positionController)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            hideIcon = true;
          });
          _scale2Controller.forward();
        }
      });

    _scale2Controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {}

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: LoginPage()));
          });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -50,
              left: 0,
              child: FadeAnimations(
                  1,
                  Container(
                      width: width,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/one_login.png'),
                              fit: BoxFit.cover)))),
            ),
            Positioned(
              top: -100,
              left: 0,
              child: FadeAnimations(
                1.3,
                Container(
                    width: width,
                    height: 400,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('images/one_login.png'),
                            fit: BoxFit.cover))),
              ),
            ),
            Positioned(
                top: -150,
                left: 0,
                child: FadeAnimations(
                  1.6,
                  Container(
                      width: width,
                      height: 400,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/one_login.png'),
                              fit: BoxFit.cover))),
                )),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimations(
                      1,
                      Text(
                        "Bem vindo",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  FadeAnimations(
                      1.3,
                      Text(
                        "Seja bem vindo ao nosso aplicativo de filmes CineSquad.",
                        style: TextStyle(
                            color: Colors.white.withOpacity(.7),
                            height: 1.4,
                            fontSize: 20),
                      )),
                  SizedBox(
                    height: 180,
                  ),
                  FadeAnimations(
                    1.6,
                    AnimatedBuilder(
                      animation: _scaleController,
                      builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _widthController,
                            builder: (context, child) => Container(
                              width: _widthAnimation.value,
                              padding: EdgeInsets.all(10),
                              height: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue.withOpacity(.4)),
                              child: InkWell(
                                onTap: () {
                                  _scaleController.forward();
                                },
                                child: Stack(children: <Widget>[
                                  AnimatedBuilder(
                                      animation: _positionController,
                                      builder: (context, child) => Positioned(
                                            left: _positionAnimation.value,
                                            child: AnimatedBuilder(
                                                animation: _scale2Controller,
                                                builder: (context, child) =>
                                                    Transform.scale(
                                                      scale: _scale2Animation
                                                          .value,
                                                      child: Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .blue),
                                                        child: hideIcon == false
                                                            ? Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Colors
                                                                    .white)
                                                            : Container(),
                                                      ),
                                                    )),
                                          ))
                                ]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
