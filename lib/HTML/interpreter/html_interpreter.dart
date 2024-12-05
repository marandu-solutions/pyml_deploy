import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';

import '../Tests/tests.dart';

class HtmlEditor extends StatefulWidget {
  @override
  _HtmlEditorState createState() => _HtmlEditorState();
}

class _HtmlEditorState extends State<HtmlEditor> {
  TextEditingController _htmlController = TextEditingController();
  String _htmlContent = "";

  @override
  void initState() {
    super.initState();
    _htmlController.addListener(() {
      setState(() {
        _htmlContent = _htmlController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HTML Editor"),
        actions: [
          IconButton(
            icon: Icon(Icons.play_arrow),
            onPressed: () {
              // Navegar para a próxima tela
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TestingScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _htmlController,
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "Digite seu HTML aqui",
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontFamily: 'monospace'),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: HighlightView(
                _htmlContent,
                language: 'html',
                theme: monokaiSublimeTheme,
                padding: EdgeInsets.all(12),
                textStyle: TextStyle(fontFamily: 'monospace', fontSize: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

