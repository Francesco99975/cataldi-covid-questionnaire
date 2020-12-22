import 'package:cataldi_covid_questionnaire/screens/covid_form_screen.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Text(
                    "Cataldi Covid Questionnaire",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              Consumer<Status>(
                builder: (_, status, __) => status.completed
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: FittedBox(
                          child: InkWell(
                            onLongPress: () async =>
                                await status.setStatus(false),
                            child: Text(
                              "Questionnaire Already Submitted Today. \nCome back tomorrow.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(color: Colors.red, fontSize: 22),
                            ),
                          ),
                        ),
                      )
                    : FlatButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, CovidFormScreen.ROUTE_NAME);
                        },
                        child: Text(
                          "START",
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
