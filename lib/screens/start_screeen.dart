import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/status.dart';

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
              Consumer<Status>(
                builder: (_, status, __) => status.completed
                    ? Column(
                        children: [
                          FittedBox(
                            child:
                                Text("Questionnaire Already Submitted Today"),
                          ),
                          RaisedButton(
                            onPressed: () async =>
                                await status.setStatus(false),
                            child: Text("RESET"),
                            color: Colors.amber,
                            textColor: Colors.blue,
                          ),
                        ],
                      )
                    : RaisedButton(
                        onPressed: () async {
                          await status.setStatus(true);
                          await status.setExpiryDate(
                              DateTime.now().add(Duration(seconds: 10)));
                        },
                        child: Text("START"),
                        color: Colors.amber,
                        textColor: Colors.blue,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
