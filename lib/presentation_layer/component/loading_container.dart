import 'package:flutter/material.dart';

class LoadingContainer extends StatefulWidget {
  const LoadingContainer(
      {super.key, required this.width, required this.height});

  final double width;
  final double height;

  @override
  State<LoadingContainer> createState() {
    return _LoadingContainerState();
  }
}

class _LoadingContainerState extends State<LoadingContainer> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late double animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    animation =  Tween(begin: 0.0,end: 1.0).evaluate(_animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
       
        opacity: _animationController,        
        child: Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10),),
      )
    );
  }
}
