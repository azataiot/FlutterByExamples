import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//Stateless widgets are immutable,
// meaning that their properties can't change—all values are final.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Final Keyword In Dart
    // The final keyword is used to hardcode the values of the variable and it
    // cannot be altered in future, neither any kind of operations performed on \
    // these variables can alter its value (state).
    // final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: const Center(
          // child: Text('Hello World'),
          // child: Text(wordPair.asPascalCase),
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  const RandomWords({Key? key}) : super(key: key);

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

// Generic state class specialized to use with RandomWords
// it maintains the state for the RandomWords widget.
// This class saves the list of generated word pairs,
// which grows infinitely as the user scrolls
class _RandomWordsState extends State<RandomWords> {
  //Add a _suggestions list for saving suggested word pairings.
  final _suggestions = <WordPair>[];
  // Also, add a _biggerFont variable for making the font size larger.
  final _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    final wordPair = WordPair.random();
    return Text(wordPair.asCamelCase);
  }
}
