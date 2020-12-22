import 'package:cataldi_covid_questionnaire/models/covid_form.dart';
import 'package:flutter/foundation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Email with ChangeNotifier {
  String username = "";
  String password = "";
  SmtpServer server;

  Email() {
    try {
      this.username = DotEnv().env['MAILGUN_USERNAME'];
      this.password = DotEnv().env['MAILGUN_PASSWORD'];
      this.server = mailgun(username, password);
    } catch (e) {
      print("Email Server could not be initialized");
      print(e);
    }
  }

  Future<void> sendMail(CovidForm form) async {
    final middleNameLi =
        form.hasMiddle() ? "<li>Middle Name: ${form.middleName}</li>" : '';
    final message = Message()
      ..from = Address(username, 'Cataldi Covid Questionnaire App')
      ..recipients.add('francescomich@ymail.com')
      ..subject =
          'COVID-19 Report from: ${form.firstName}${form.hasMiddle() ? ' ' + form.middleName : ''} ${form.lastName}'
      ..html = """
        <div style='margin: 2rem;'>
          <h1 style='padding: 2rem 0; color: ${form.passed() ? 'green' : 'red'};'>${form.passed() ? 'PASSED' : 'FAILED'}</h1>
          <h1>Personal Informations</h1>
            <ul>
              <li>First Name: ${form.firstName}</li>
              $middleNameLi
              <li>Last Name: ${form.lastName}</li>
            </ul>
          <h1>Symptoms</h1>
            <ul>
              <li>Fever or Chills: <span style='color: ${form.symptoms[CovidForm.Fever] ? 'red' : 'green'}; font-weight: bold;'>${form.symptoms[CovidForm.Fever] ? 'YES' : 'NO'}</span></li>
              <li>Difficulty breathing or shortness of breath: <span style='color: ${form.symptoms[CovidForm.Breath] ? 'red' : 'green'}; font-weight: bold;'>${form.symptoms[CovidForm.Breath] ? 'YES' : 'NO'}</span></li>
              <li>Cough: <span style='color: ${form.symptoms[CovidForm.Cough] ? 'red' : 'green'}; font-weight: bold;'>${form.symptoms[CovidForm.Cough] ? 'YES' : 'NO'}</span></li>
              <li>Sore Throat, trouble swallowing: <span style='color: ${form.symptoms[CovidForm.Throat] ? 'red' : 'green'}; font-weight: bold;'>${form.symptoms[CovidForm.Throat] ? 'YES' : 'NO'}</span></li>
              <li>Runny nose / stuffy nose or nasal congestion: <span style='color: ${form.symptoms[CovidForm.Nose] ? 'red' : 'green'}; font-weight: bold;'>${form.symptoms[CovidForm.Nose] ? 'YES' : 'NO'}</span></li>
              <li>Decrease or loss of smell or taste: <span style='color: ${form.symptoms[CovidForm.Taste] ? 'red' : 'green'}; font-weight: bold;'>${form.symptoms[CovidForm.Taste] ? 'YES' : 'NO'}</span></li>
              <li>Nausea, vomiting, diarrhea, abdominal pain: <span style='color: ${form.symptoms[CovidForm.Nausea] ? 'red' : 'green'}; font-weight: bold;'>${form.symptoms[CovidForm.Nausea] ? 'YES' : 'NO'}</span></li>
              <li>Not feeling well, extreme tiredness, sore muscles: <span style='color: ${form.symptoms[CovidForm.Tiredness] ? 'red' : 'green'}; font-weight: bold;'>${form.symptoms[CovidForm.Tiredness] ? 'YES' : 'NO'}</span></li>
            </ul>
          <h1>Travel</h1>
            <ul>
              <li>Have you travelled outside Canada in the past 14 days ?: <span style='color: ${form.travelled ? 'red' : 'green'}; font-weight: bold;'>${form.travelled ? 'YES' : 'NO'}</span></li>
            </ul>
          <h1>Contact</h1>
            <ul>
              <li>Have you had close contact with a confirmed or probable case of COVID-19 ?: <span style='color: ${form.contact ? 'red' : 'green'}; font-weight: bold;'>${form.contact ? 'YES' : 'NO'}</span></li>
            </ul>
          </div>
      """;

    try {
      final sendReport = await send(message, this.server);
      print('Message sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
