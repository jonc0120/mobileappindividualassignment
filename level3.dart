import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:simplegame/leaderboard.dart';
import 'package:simplegame/level4.dart';
import 'package:simplegame/select_levels.dart';

class Level3 extends StatefulWidget {
  const Level3({Key? key});

  @override
  _Level3state createState() => _Level3state();
}

class _Level3state extends State<Level3> {
  int? currentButtonindex;
  int numButtons = 16;
  int score = 0;
  late Timer timer;
  bool isPlaying = false;
  int currentIndex = 0;
  int timeLeft = 5;

  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  void addNewPlayer(String name, int score, Leaderboard leaderboard) {
    leaderboard.addPlayer(name, score);
  }

  void submitUsername(score, BuildContext dialogContext) {
    String name = usernameController.text;
    var leaderboard = Leaderboard();
    addNewPlayer(name, score, leaderboard);
    Navigator.of(dialogContext).pop(true);
    setState(() {});
  }

  List<int> buttonIndices = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

  int getRandomButtonIndex() {
    if (currentIndex < numButtons) {
      buttonIndices.shuffle();
      currentIndex = 0;
    }
    return buttonIndices[currentIndex++];
  }

  void scoreIncrement() {
    setState(() {
      score++;
    });
  }

  @override
  void initState() {
    super.initState();
    currentButtonindex = getRandomButtonIndex();
  }

  void nextButton() {
    if ((isPlaying == true) && (timeLeft > 0)) {
      setState(() {
        currentButtonindex = getRandomButtonIndex();
      });
    }
  }

  void onButtonPress(int buttonIndex) {
    if ((isPlaying == true) && (timeLeft > 0)) {
      if (buttonIndex == currentButtonindex) {
        setState(() {
          scoreIncrement();
          nextButton();
        });
      }
    }
  }

  void endGame() {
    setState(() {
      isPlaying = false;
    });
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: const Text('Enter your username'),
        content: TextField(
          controller: usernameController,
          decoration: const InputDecoration(hintText: 'Username'),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(dialogContext, rootNavigator: true).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => submitUsername(score, dialogContext),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  void startGame() {
    setState(() {
      timeLeft = 5;
      score = 0;
      isPlaying = true;
      nextButton();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeLeft--;
        if (timeLeft == 0) {
          timer.cancel();
          endGame();
        }
      });
    });
  }

  Widget buildButton(int buttonIndex) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => onButtonPress(buttonIndex),
          style: ElevatedButton.styleFrom(
              primary: buttonIndex == currentButtonindex
                  ? Colors.blue
                  : Colors.grey),
          child: null,
        ),
      ),
    );
  }

  static const title = 'Level 3';

  @override
  Widget build(BuildContext context) {
    List<Widget> buttons = List.generate(
      numButtons,
      (index) => buildButton(index),
    );

    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.deepPurpleAccent,
            appBar: AppBar(title: const Text(title)),
            body: Column(
              children: [
                const SizedBox(height: 16.0),
                Text(
                  'Time left: $timeLeft',
                  style: const TextStyle(
                    fontSize: 23,
                  ),
                ),
                const SizedBox(height: 16.0),
                Text(
                  'Score: $score',
                  style: const TextStyle(
                    fontSize: 23.0,
                  ),
                ),
                LayoutGrid(
                  columnSizes: SliverGridDelegateWithFixedCrossAxisCount == 4
                      ? [1.fr, 1.fr, 1.fr, 1.fr]
                      : [1.fr, 1.fr, 1.fr, 1.fr],
                  rowSizes: SliverGridDelegateWithFixedCrossAxisCount == 4
                      ? const [auto, auto, auto, auto]
                      : const [auto, auto, auto, auto],
                  rowGap: 25,
                  columnGap: 25,
                  children: buttons,
                  
                ),
                ElevatedButton(
                    onPressed: () => startGame(),
                    child: const Text(
                      'START',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Leaderboard()),
                      );
                    },
                    child: const Text(
                      'LeaderBoards',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Level4()),
                      );
                    },
                    child: const Text(
                      'Next Level',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => select_Level()),
                      );
                    },
                    child: const Text(
                      'Level Menu',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            )));
  }

  // void popup() {
  //   @override
  //   Widget prompt(BuildContext context) {
  //     return AlertDialog(
  //       title: const Text('Enter your username'),
  //       content: TextField(
  //         controller: usernameController,
  //         decoration: const InputDecoration(hintText: 'Username'),
  //       ),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.pop(context),
  //           child: const Text('Cancel'),
  //         ),
  //         ElevatedButton(
  //           onPressed: () => submitUsername(score),
  //           child: const Text('Submit'),
  //         ),
  //       ],
  //     );
  //   }
  // }
}
