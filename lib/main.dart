import 'package:dsi_app/editionpage.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

Map<WordPair, bool> wordPairs;

void main() {
  initWordPairs();
  runApp(DSIApp());
}

void initWordPairs() {
  final generatedWordPairs = generateWordPairs().take(20);
  wordPairs =
      Map.fromIterable(generatedWordPairs, key: (e) => e, value: (e) => null);
}

///App baseado no tutorial do Flutter disponível em:
///https://codelabs.developers.google.com/codelabs/first-flutter-app-pt1
class DSIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Listagem - DSI/BSI/UFRPE',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  List<Widget> _pages = [
    RandomWordsListPage(null),
    RandomWordsListPage(true),
    RandomWordsListPage(false)
  ];

  void _changePage(int value) {
    setState(() {
      pageIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('App de Listagem - DSI/BSI/UFRPE'),
        actions: <Widget>[
          IconButton(
            
            icon: Icon(Icons.search),
            onPressed: (){

            }
          ),
        ],
      ),
      body: _pages[pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _changePage,
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up_outlined),
            label: 'Liked',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.thumb_down_outlined),
            label: 'Disliked',
          ),
        ],
      ),
    );
  }
}

class RandomWordsListPage extends StatefulWidget {
  final bool _filter;
  RandomWordsListPage(this._filter);

  @override
  _RandomWordsListPageState createState() => _RandomWordsListPageState();
}

///Esta classe é o estado da classe que lista os pares de palavra
///
class _RandomWordsListPageState extends State<RandomWordsListPage> {
  final _icons = {
    null: Icon(Icons.thumbs_up_down_outlined),
    true: Icon(Icons.thumb_up, color: Colors.blue),
    false: Icon(Icons.thumb_down, color: Colors.red),
  };
  void delete(WordPair wordPair){
    setState(() {
      wordPairs.remove(wordPair);
      
    });
  }
  Iterable<WordPair> get items {
    if (widget._filter == null) {
      return wordPairs.keys;
    } else {
      //a linah aabaixo retorna os pares filtras opelo filtro
      return wordPairs.entries
          .where((element) => element.value == widget._filter)
          .map((e) => e.key);
    }
  }

  _toggle(WordPair wordPair) {
    bool like = wordPairs[wordPair];
    if (widget._filter != null) {
      wordPairs[wordPair] = null;
    } else if (like == null) {
      wordPairs[wordPair] = true;
    } else if (like == true) {
      wordPairs[wordPair] = false;
    } else {
      wordPairs[wordPair] = null;
    }
    setState(() {});
  }

  String capitalize(String s) {
    return '${s[0].toUpperCase()}${s.substring(1)}';
  }

  String asString(WordPair wordPair) {
    return '${capitalize(wordPair.first)} ${capitalize(wordPair.second)}';
  }
  void updateWordPair(int index, WordPair newWord){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length * 2,
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          return _buildRow(index + 1, items.elementAt(index));
        });
  }

  Widget _buildRow(int index, WordPair wordPair) {
    return Row(
      children: [
        
        Expanded(
          child: GestureDetector(
            onTap: () async {
              setState(() {
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context )=>PageEdition())).then((newWordPair) => setState((){
                  _updateWordPair(index, newWordPair);
                  print(wordPairs.cast());
                }));
              });
            },
            child: Text('$index. ${asString(wordPair)}'), /*Text('$index. ${asString(wordPair)}'),*/
          ), 
        ),
        IconButton(icon: _icons[wordPairs[wordPair]], onPressed: () => _toggle(wordPair)),
        IconButton(icon: Icon(Icons.delete), onPressed: ()=> delete(wordPair))
      ],
    );
  }
  
  void _updateWordPair(int index, WordPair newWordPair) {
    /*essa função em específico, eu não consegui fazer sozinho, fiz com ajuda de um amigo*/
    List<WordPair> keys = wordPairs.keys.toList();
    List<bool> values = wordPairs.values.toList();
    keys[index - 1] = newWordPair;
    Map<WordPair, bool> newMap = Map.fromIterables(keys, values);
    wordPairs.clear();
    wordPairs = Map.from(newMap);
    print(wordPairs);
  }
  
}

class PageEdition extends StatefulWidget {
  final WordPair newWordPair;
  const PageEdition({Key key, this.newWordPair}) : super(key: key);

  @override
  _PageEditionState createState() => _PageEditionState();
}

class _PageEditionState extends State<PageEdition> {
  @override
  var par1;
  var par2;
  var pares;
  
  void createWordPair(BuildContext context,String textcontroller){
    pares = textcontroller.split(' ');
    par1 = pares[0];
    par2 = pares[1];
    print(par1);
    print(par2);
    WordPair newWordPair = WordPair(par1,par2);
    print(newWordPair);
    Navigator.pop(context, newWordPair);
  }
  
  Widget build(BuildContext context) {
    var newPairController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text("Tela de edição"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          
          children: [
            Expanded(
              
              flex: 3,
              child: TextFormField(
                
                decoration: InputDecoration(
                  labelText: "Digite duas palavras separadas por um espaço. Ex: word pair"
                ),
                
                controller: newPairController,
                keyboardType: TextInputType.text,
              ),
            ),
    
            Expanded(
              flex: 1,
              child: RaisedButton(  
                onPressed: (){
                  createWordPair(context,newPairController.text);
                  print(newPairController.text);
                  
               },
                child: Text("Aplicar"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
