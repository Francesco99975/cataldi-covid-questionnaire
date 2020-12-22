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
              const SizedBox(
                height: 20.0,
              ),
              FittedBox(
                  child: Text("You may not enter your workplace",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 0))),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    "It is reccomended to immediately self-isolate and contact your healthcare provider or Telehealth Ontario (1 866-797-0000) to find out id you need a COVID-19 test",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontSize: 16, letterSpacing: 0)),
              ),
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
