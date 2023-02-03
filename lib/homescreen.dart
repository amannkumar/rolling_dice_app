import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int leftDiceNumber = 1;
  int rightDiceNumber = 2;
  late AnimationController _controller;
  late CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    animateDice();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animateDice() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceOut);
    animation.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          leftDiceNumber = Random().nextInt(6) + 1;
          rightDiceNumber = Random().nextInt(6) + 1;
        });
        _controller.reverse();
      }
    });
  }

  void rollDice() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Dice Game'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onDoubleTap: rollDice,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image(
                      height: 200 - (animation.value) * 200,
                      image: AssetImage(
                          'assets/images/dice-png-$leftDiceNumber.png'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onDoubleTap: rollDice,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Image(
                      height: 200 - (animation.value) * 200,
                      image: AssetImage(
                          'assets/images/dice-png-$rightDiceNumber.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
          ElevatedButton(
              onPressed: rollDice,
              child: const Text(
                'Roll Dice',
                style: TextStyle(fontWeight: FontWeight.bold),
              ))
        ]),
      ),
    );
  }
}
