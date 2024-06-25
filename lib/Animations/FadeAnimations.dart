import 'package:simple_animations/simple_animations.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class FadeAnimations extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimations(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
   
    final tween = MultiTween<AnimProps>()
      ..add(AnimProps.opacity, Tween(begin: 0.0, end: 1.0), Duration(milliseconds: 500))
      ..add(AnimProps.translateY, Tween(begin: -130.0, end: 0.0), Duration(milliseconds: 500), Curves.easeOut); 

   
    return PlayAnimation<MultiTweenValues<AnimProps>>(
      delay: Duration(milliseconds: (500 * delay).round()), 
      duration: tween.duration, 
      tween: tween, 
      child: child, 
      builder: (context, child, animation) {
        // Constrói a animação
        return Opacity(
          opacity: animation.get(AnimProps.opacity), 
          child: Transform.translate(
            offset: Offset(0, animation.get(AnimProps.translateY)), 
            child: child,
          ),
        );
      },
    );
  }
}


enum AnimProps { opacity, translateY }
