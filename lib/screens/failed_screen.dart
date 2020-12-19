import 'package:flutter/material.dart';

class FailedScreen extends StatelessWidget {
  static const ROUTE_NAME = "/failed";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                  child: Text(
                "FAILED",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold),
              )),
              FittedBox(
                  child: Text("You may not enter your workplace",
                      style: TextStyle(color: Colors.white, fontSize: 16))),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "It is reccomended to immediately self-isolate and contact your healthcare provider or Telehealth Ontario (1 866-797-0000) to find out id you need a COVID-19 test",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    )),
              ),
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
