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
              const SizedBox(height: 20.0),
              FittedBox(
                  child: Text("You may now go to your workplace",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 0))),
              const SizedBox(height: 50),
              RaisedButton(
                elevation: 5,
                splashColor: Colors.black12,
                padding: const EdgeInsets.all(12.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
                onPressed: () => Navigator.pushReplacementNamed(context, '/'),
                child: Text(
                  "FINISH",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
