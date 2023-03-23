import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:simplegame/leaderboard.dart';
import 'package:simplegame/level2.dart';
import 'package:simplegame/select_levels.dart';

//create widget
class Level1 extends StatefulWidget {
  const Level1({Key? key});

  @override
  _Level1state createState() => _Level1state();
}

class _Level1state extends State<Level1> {
  //declare variables
  int? currentButtonindex;
  int numButtons = 4;
  int score = 0;
  late Timer timer;
  bool isPlaying = false;
  int currentIndex = 0;
  int timeLeft = 5;

  //initiate text input
  final TextEditingController usernameController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  //function to append player into leaderboard to be used by submitUserName()
  void addNewPlayer(String name, int score, Leaderboard leaderboard) {
    leaderboard.addPlayer(name, score);
  }

  //function to take in username and forward name to to addNewPlayer
  void submitUsername(BuildContext dialogContext) {
    String name = usernameController.text;
    var leaderboard = Leaderboard();
    addNewPlayer(name, score, leaderboard);
    //dismisses the dialog
    Navigator.of(dialogContext).pop(true);
    setState(() {});
  }

  //declare the list of buttons
  List<int> buttonIndices = [0, 1, 2, 3];

  //button randomizer
  int getRandomButtonIndex() {
    if (currentIndex < numButtons) {
      buttonIndices.shuffle();
      currentIndex = 0;
    }
    return buttonIndices[currentIndex++];
  }

  //function to increase score
  void scoreIncrement() {
    setState(() {
      score++;
    });
  }

  //initiate button randomizer
  @override
  void initState() {
    super.initState();
    currentButtonindex = getRandomButtonIndex();
  }

  //function highlight random button
  void nextButton() {
    if ((isPlaying == true) && (timeLeft > 0)) {
      setState(() {
        currentButtonindex = getRandomButtonIndex();
      });
    }
  }

  //function to increase score and proceed to highlight next button after button press
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

  //change isPlaying state and prompt a dialog to enter username after game ends
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
            onPressed: () => submitUsername(dialogContext),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  //function to start the game
  void startGame() {
    setState(() {
      timeLeft = 5;
      score = 0;
      isPlaying = true;
      nextButton();
      //countdown timer for 5 seconds
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeLeft--;
        if (timeLeft == 0) {
          timer.cancel();
          endGame();
        }
      });
    });
  }

  //widget to customize buttons
  Widget buildButton(int buttonIndex) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () => onButtonPress(buttonIndex),
          style: ElevatedButton.styleFrom(
              primary: buttonIndex == currentButtonindex
                  ? Colors.deepOrangeAccent
                  : Colors.grey),
          child: null,
        ),
      ),
    );
  }

  static const title = 'Level 1';
  //UI for the page
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
                //layout for buttons
                LayoutGrid(
                  columnSizes: SliverGridDelegateWithFixedCrossAxisCount == 2
                      ? [1.fr, 1.fr]
                      : [1.fr, 1.fr],
                  rowSizes: SliverGridDelegateWithFixedCrossAxisCount == 2
                      ? const [auto, auto]
                      : const [auto, auto],
                  rowGap: 50,
                  columnGap: 50,
                  children: buttons,
                ),
                //navigational buttons at the bottom of the screen
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
                        MaterialPageRoute(builder: (context) => Level2()),
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
}
