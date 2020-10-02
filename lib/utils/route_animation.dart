import 'package:flutter/material.dart';

class Routes {
  static Route createRoute(route) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionDuration: Duration(seconds: 0, milliseconds: 750),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(10.0, 5.0);
        var end = Offset.zero;
        var curve = Curves.fastOutSlowIn;

        // var tween =
        //     Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        var tween = Tween<double>(begin: -200, end: 1);

        return FadeTransition(
          opacity: animation,
          // position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  static Route createSlideRoute(route) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => route,
      transitionDuration: Duration(seconds: 0, milliseconds: 750),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 2.0);
        var end = Offset.zero;
        var curve = Curves.fastOutSlowIn;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        // var tween = Tween<double>(begin: -200, end: 1);

        return SlideTransition(
          // opacity: animation,
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
