import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Final Keyword In Dart
    // The final keyword is used to hardcode the values of the variable and it
    // cannot be altered in future, neither any kind of operations performed on \
    // these variables can alter its value (state).
    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
          // child: Text('Hello World'),
          child: Text(wordPair.asPascalCase),
        ),
      ),
    );
  }
}
