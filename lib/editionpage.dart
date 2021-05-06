import 'package:dsi_app/main.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class PageEdit extends StatefulWidget {

  
  
  @override
  _PadeEditState createState() => _PadeEditState();
}

class _PadeEditState extends State<PageEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina de edição'),
      ),
      body: Container(
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.text,

            ),
            /*IconButton(
              icon: Icon(Icons.home),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => DSIApp())),
            ),*/
          ],
        ),
      ),
    );
  }
}