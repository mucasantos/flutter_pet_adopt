import 'package:flutter/material.dart';



class Rolagem extends StatefulWidget {
  @override
  _RolagemState createState() => _RolagemState();
}

class _RolagemState extends State<Rolagem> {
  bool _isDrawerVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sidebar Navigation Example'),
      ),
      body: Row(
        children: <Widget>[
          Visibility(
            visible: _isDrawerVisible,
            child: Container(
              width: 60, // largura da barra lateral
              color: Colors.blue,
              child: ListView(
                children: <Widget>[
                  VerticalTextButton(text: 'Section 1', onTap: () {}),
                  VerticalTextButton(text: 'Section 2', onTap: () {}),
                  VerticalTextButton(text: 'Section 3', onTap: () {}),
                  VerticalTextButton(text: 'Section 4', onTap: () {}),
                  VerticalTextButton(text: 'Section 5', onTap: () {}),
                  VerticalTextButton(text: 'Section 6', onTap: () {}),
                  VerticalTextButton(text: 'Section 7', onTap: () {}),
                  VerticalTextButton(text: 'Section 8', onTap: () {}),
                  VerticalTextButton(text: 'Section 9', onTap: () {}),
                  VerticalTextButton(text: 'Section 10', onTap: () {}),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isDrawerVisible = !_isDrawerVisible;
                    });
                  },
                  child: Text(_isDrawerVisible ? 'Esconder' : 'Mostrar'),
                ),
                Text('Content Area'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  VerticalTextButton({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        child: RotatedBox(
          quarterTurns: 3,
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
