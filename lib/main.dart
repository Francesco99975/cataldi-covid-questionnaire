import 'package:cataldi_covid_questionnaire/providers/email.dart';
import 'package:cataldi_covid_questionnaire/providers/personal_info.dart';
import 'package:cataldi_covid_questionnaire/screens/covid_form_screen.dart';
import 'package:cataldi_covid_questionnaire/screens/failed_screen.dart';
import 'package:cataldi_covid_questionnaire/screens/passed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './providers/status.dart';
import './screens/start_screeen.dart';
import './screens/loading_screen.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(CataldiCovidQuestionnaire());
}

class CataldiCovidQuestionnaire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Status()),
        ChangeNotifierProvider(create: (_) => PersonalInfo()),
        ChangeNotifierProvider(create: (_) => Email())
      ],
      child: MaterialApp(
        title: 'Cataldi Covid Questionnaire',
        theme: ThemeData(
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.dark,
            textTheme: TextTheme(
                headline1: TextStyle(
                    color: Colors.amber,
                    fontSize: 26,
                    fontWeight: FontWeight.bold),
                bodyText1: TextStyle(
                    color: Colors.amber, fontSize: 22, letterSpacing: 3.0),
                bodyText2: TextStyle(
                    color: Colors.teal, fontSize: 22, letterSpacing: 7.0))),
        home: Home(),
        routes: {
          CovidFormScreen.ROUTE_NAME: (_) => CovidFormScreen(),
          PassedScreen.ROUTE_NAME: (_) => PassedScreen(),
          FailedScreen.ROUTE_NAME: (_) => FailedScreen()
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        Provider.of<Status>(context, listen: false).loadStatus(),
        Provider.of<PersonalInfo>(context, listen: false).loadInfo()
      ]),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? LoadingScreen()
              : StartScreen(),
    );
  }
}
