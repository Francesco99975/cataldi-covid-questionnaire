import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.grey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                child: Text("Cataldi Covid Questionnaire"),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text("START"),
                color: Colors.amber,
                textColor: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }
}
