import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

//Stateless widgets are immutable,
// meaning that their properties can't change—all values are final.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  //context is a BuildContext instance which gets passed to the builder
  // of a widget in order to let it know where it is
  // inside the Widget Tree of your app.
  // One of the common uses is passing it
  // to the of method when using an Inherited Widget.
  @override
  Widget build(BuildContext context) {
    //Final Keyword In Dart
    // The final keyword is used to hardcode the values of the variable and it
    // cannot be altered in future, neither any kind of operations performed on \
    // these variables can alter its value (state).
    // final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        // Add the 5 lines from here...
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
      ),
      home: const RandomWords(),
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
  final _saved = <WordPair>{};

  // Also, add a _biggerFont variable for making the font size larger.
  final _biggerFont = const TextStyle(fontSize: 18);

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final tiles = _saved.map(
        (pair) {
          return ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
          );
        },
      );
      final divided = tiles.isNotEmpty
          ? ListTile.divideTiles(context: context, tiles: tiles).toList()
          : <Widget>[];

      return Scaffold(
        appBar: AppBar(
          title: const Text('Saved suggestions'),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Startup Name Generator'),
          actions: [
            IconButton(
              onPressed: _pushSaved,
              icon: const Icon(Icons.list),
              tooltip: "Saved Suggestions",
            )
          ],
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          //The itemBuilder callback is called once per suggested word pairing,
          // and places each suggestion into a ListTile row.
          // here the index is the row index
          itemBuilder: (context, i) {
            // the function adds a Divider widget to visually separate the entries.
            if (i.isOdd) return const Divider();
            // The syntax i ~/ 2 divides i by 2 and returns an integer result.
            // This calculates the actual number of word pairings in the ListView,minus the divider widgets.
            final index = i ~/ 2;
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }

            final alreadySaved = _saved.contains(_suggestions[index]);
            return ListTile(
              title: Text(
                _suggestions[index].asPascalCase,
                style: _biggerFont,
              ),
              trailing: Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
                semanticLabel: alreadySaved ? 'Remember from Saved' : 'Save',
              ),
              onTap: () {
                setState(() {
                  if (alreadySaved) {
                    _saved.remove(_suggestions[index]);
                  } else {
                    _saved.add(_suggestions[index]);
                  }
                });
              },
            );
          },
        ));
  }
}
