import 'dart:io';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome Flutter',
      theme: ThemeData(primaryColor: Colors.orange),
      home: RandomWords(),
    );
  }
}

class RandomWordsState extends State<RandomWords>
{
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();
  final TextStyle _biggerFont = TextStyle(fontSize:18.0);
  
  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }


  Widget _buildRow(WordPair pair){
    final bool alreadysaved = _saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase,style:_biggerFont),
      trailing: Icon(
        alreadysaved ? Icons.favorite: Icons.favorite_border,
        color: alreadysaved ? Colors.red : null,
        
      ),
      onTap: (){
        setState(() {
          if (alreadysaved){
            _saved.remove(pair);
          }
          else
          {
            _saved.add(pair);
          }
        });
      },
    );
  }
  
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list),onPressed: _pushSaved,)
        ],      
      ),
      body: _buildSuggestions(),
    );
  }
  // #enddocregion RWS-build
  // #docregion RWS-var
  
void _pushSaved(){
  Navigator.of(context).push(
    MaterialPageRoute<void>(builder: (BuildContext context){
      final Iterable<ListTile> titles = _saved.map(
        (WordPair pair){
          return ListTile(
            title: Text(pair.asPascalCase,style:_biggerFont),
          );
        }
      );

      final List<Widget> divided = ListTile.divideTiles(
        context: context,
        tiles: titles
      ).toList();
      return Scaffold
      (
        appBar: AppBar
        (title: Text('Saved Suggestions')),body: ListView(children: divided,) ,);
    })
  );
  
}
}
  // #enddocregion RWS-build
  // #docregion RWS-var



class RandomWords extends StatefulWidget {
  RandomWordsState createState() => RandomWordsState();
}

