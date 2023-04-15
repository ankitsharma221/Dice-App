import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDice = 1;
  int rightDice = 1;
  late AnimationController _controller;
  late CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    animate();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animate() {
    _controller =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn);

    animation.addListener(() {
      setState(() {});
      //print(_controller.value);
      animation.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            leftDice = Random().nextInt(6) + 1;
            rightDice = Random().nextInt(6) + 1;
            ;
          });
          //print('Completed');
          _controller.reverse();
        }
      });
    });
  }

  void roll() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dicee'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onDoubleTap: () {
                    roll();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image(
                      height: 350 - (animation.value) * 500,
                      image: AssetImage('assets/page-$leftDice.png'),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: GestureDetector(
                onDoubleTap: () {
                  roll();
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image(
                      height: 350 - (animation.value) * 500,
                      image: AssetImage('assets/page-$rightDice.png')),
                ),
              ))
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Center(child: ElevatedButton(onPressed: roll, child: Text('Roll')))
        ]),
      ),
    );
  }
}
