import 'dart:async';

import 'package:flutter/material.dart';

class ShowUpAnimation extends StatefulWidget {

  final Widget child;
  int? delay;

  ShowUpAnimation({required this.child, required this.delay});
  @override
  State<ShowUpAnimation> createState() => _ShowUpAnimationState();
}

class _ShowUpAnimationState extends State<ShowUpAnimation> with TickerProviderStateMixin {

  late AnimationController _animationController;
  late Animation<Offset> _animOffset;
  late Timer _timer;

  void initState() {
    super.initState();

    _animationController =  AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    final curve = CurvedAnimation(parent: _animationController, curve: Curves.decelerate);
    _animOffset = Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero).animate(curve);

    if(widget.delay == null){
      _animationController.forward();
    }else{
      // _timer = Timer(Duration(milliseconds: widget.delay!), (){
      //   _animationController.forward();
      // });
    }
  }
  @override
  void dispose(){
    super.dispose();
    _animationController.dispose();
    _timer.cancel();
  }
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}