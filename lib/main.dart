import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/status.dart';
import './screens/start_screeen.dart';
import './screens/loading_screen.dart';

void main() {
  runApp(CataldiCovidQuestionnaire());
}

class CataldiCovidQuestionnaire extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Status())],
      child: MaterialApp(
          title: 'Cataldi Covid Questionnaire',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: Home()),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<Status>(context, listen: false).loadStatus(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
              ? LoadingScreen()
              : StartScreen(),
    );
  }
}
