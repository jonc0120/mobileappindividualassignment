import 'package:flutter/material.dart';

//declare player structure
class Player {
  String name;
  int score;

  Player(this.name,  this.score);
}

class Leaderboard extends StatelessWidget {

  //declare player lists
  List<Player> players = [];

  //function to add player name and score into player list
  void addPlayer(String name, int score) {
    players.add(Player(name, score));
  }

  //leaderboard UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text((index + 1).toString()),
            title: Text(players[index].name),
            trailing: Text(players[index].score.toString()),
          );
        },
      ),
    );
  }
}