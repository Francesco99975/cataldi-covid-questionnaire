import 'package:cataldi_covid_questionnaire/models/covid_form.dart';
import 'package:cataldi_covid_questionnaire/providers/personal_info.dart';
import 'package:cataldi_covid_questionnaire/providers/status.dart';
import 'package:cataldi_covid_questionnaire/screens/failed_screen.dart';
import 'package:cataldi_covid_questionnaire/screens/passed_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CovidFormScreen extends StatefulWidget {
  static const ROUTE_NAME = "/covid-form";
  @override
  _CovidFormScreenState createState() => _CovidFormScreenState();
}

class _CovidFormScreenState extends State<CovidFormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final _covidForm = CovidForm();

  Future<void> _save() async {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      final now = DateTime.now();
      await Provider.of<PersonalInfo>(context, listen: false).setInfo(
          fn: _covidForm.firstName,
          ln: _covidForm.lastName,
          mn: _covidForm.middleName);
      await Provider.of<Status>(context, listen: false).setStatus(true);

      await Provider.of<Status>(context, listen: false)
          .setExpiryDate(now.add(Duration(seconds: 10)));

      // await Provider.of<Status>(context, listen: false).setExpiryDate(now.add(
      //     Duration(
      //         hours: 24 - now.hour,
      //         minutes: -now.minute,
      //         seconds: -now.second)));

      if (_covidForm.passed()) {
        Navigator.pushReplacementNamed(context, PassedScreen.ROUTE_NAME);
      } else {
        Navigator.pushReplacementNamed(context, FailedScreen.ROUTE_NAME);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final info = Provider.of<PersonalInfo>(context);
    _covidForm.firstName = info.firstName;
    _covidForm.middleName = info.middleName;
    _covidForm.lastName = info.lastName;
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          child: Text("Screening Questions"),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Builder(
          builder: (context) => Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Personal Informations",
                      style: TextStyle(fontSize: 35),
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'First name'),
                      initialValue: _covidForm.firstName,
                      validator: (value) => value.isEmpty
                          ? 'Please enter your first name.'
                          : null,
                      onSaved: (val) =>
                          setState(() => _covidForm.firstName = val),
                    ),
                    TextFormField(
                      initialValue: _covidForm.middleName,
                      decoration: InputDecoration(labelText: 'Middle name'),
                      // validator: (value) => value.isEmpty
                      //     ? 'Please enter your middle name.'
                      //     : null,
                      onSaved: (val) =>
                          setState(() => _covidForm.middleName = val),
                    ),
                    TextFormField(
                      initialValue: _covidForm.lastName,
                      decoration: InputDecoration(labelText: 'Last name'),
                      validator: (value) =>
                          value.isEmpty ? 'Please enter your last name.' : null,
                      onSaved: (val) =>
                          setState(() => _covidForm.lastName = val),
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Symptoms",
                      style: TextStyle(fontSize: 35),
                    ),
                    CheckboxListTile(
                        title: const Text("Fever or Chills"),
                        value: _covidForm.symptoms[CovidForm.Fever],
                        onChanged: (value) {
                          setState(() {
                            _covidForm.symptoms[CovidForm.Fever] = value;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text(
                            "Difficulty breathing or shortness of breath"),
                        value: _covidForm.symptoms[CovidForm.Breath],
                        onChanged: (value) {
                          setState(() {
                            _covidForm.symptoms[CovidForm.Breath] = value;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text("Cough"),
                        value: _covidForm.symptoms[CovidForm.Cough],
                        onChanged: (value) {
                          setState(() {
                            _covidForm.symptoms[CovidForm.Cough] = value;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text("Sore Throat, trouble swallowing"),
                        value: _covidForm.symptoms[CovidForm.Throat],
                        onChanged: (value) {
                          setState(() {
                            _covidForm.symptoms[CovidForm.Throat] = value;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text(
                            "Runny nose / stuffy nose or nasal congestion"),
                        value: _covidForm.symptoms[CovidForm.Nose],
                        onChanged: (value) {
                          setState(() {
                            _covidForm.symptoms[CovidForm.Nose] = value;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text("Decrease or loss of smell or taste"),
                        value: _covidForm.symptoms[CovidForm.Taste],
                        onChanged: (value) {
                          setState(() {
                            _covidForm.symptoms[CovidForm.Taste] = value;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text(
                            "Nausea, vomiting, diarrhea, abdominal pain"),
                        value: _covidForm.symptoms[CovidForm.Nausea],
                        onChanged: (value) {
                          setState(() {
                            _covidForm.symptoms[CovidForm.Nausea] = value;
                          });
                        }),
                    CheckboxListTile(
                        title: const Text(
                            "Not feeling well, extreme tiredness, sore muscles"),
                        value: _covidForm.symptoms[CovidForm.Tiredness],
                        onChanged: (value) {
                          setState(() {
                            _covidForm.symptoms[CovidForm.Tiredness] = value;
                          });
                        }),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Travel",
                      style: TextStyle(fontSize: 35),
                    ),
                    CheckboxListTile(
                        title: const Text(
                            "Have you travelled outside Canada in the past 14 days ?"),
                        value: _covidForm.travelled,
                        onChanged: (value) {
                          setState(() {
                            _covidForm.travelled = value;
                          });
                        }),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      "Contact",
                      style: TextStyle(fontSize: 35),
                    ),
                    CheckboxListTile(
                        title: const Text(
                            "Have you had close contact with a confirmed or probable case of COVID-19 ?"),
                        value: _covidForm.contact,
                        onChanged: (value) {
                          setState(() {
                            _covidForm.contact = value;
                          });
                        }),
                    const SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      onPressed: _save,
                      child: const Text("Submit"),
                    )
                  ],
                ),
              )),
        ),
      )),
    );
  }
}
