import 'package:flutter/material.dart';
import 'level1.dart';
import 'level2.dart';
import 'level3.dart';
import 'level4.dart';
import 'level5.dart';

class select_Level extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return MaterialApp(
      title: 'Level Selection Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightBlueAccent,
        primaryColor: Colors.deepPurple,
        accentColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.deepOrangeAccent,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      home: level_selections(),
    );
  }
}

class level_selections extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text("Levels",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          )),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
    ),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(children: [
            ElevatedButton(
              child: const Text("Level 1"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Level1()),
                ); // Do something when the user selects a level.
              },),
              const SizedBox(height: 20),
              ElevatedButton(
              child: const Text("Level 2"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Level2()),
                ); // Do something when the user selects a level.
              },),
              const SizedBox(height: 20),
              ElevatedButton(
              child: const Text("Level 3"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Level3()),
                ); // Do something when the user selects a level.
              },),
              const SizedBox(height: 20),
              ElevatedButton(
              child: const Text("Level 4"),
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Level4()),
                ); // Do something when the user selects a level.
              },),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text("Level 5"),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Level5()),
                  ); // Do something when the user selects a level.
                },
              ),
              const SizedBox(height: 20),

          ],)
        ]),)
    );
  }
}
