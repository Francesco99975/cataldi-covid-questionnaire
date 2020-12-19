import 'package:flutter/material.dart';

class PassedScreen extends StatelessWidget {
  static const ROUTE_NAME = "/passed";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.green,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                  child: Text(
                "PASSED",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              )),
              FittedBox(
                  child: Text("You may now go to your workplace",
                      style: TextStyle(color: Colors.white, fontSize: 16))),
              const SizedBox(height: 50),
              RaisedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                child: const Text("FINISH"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
