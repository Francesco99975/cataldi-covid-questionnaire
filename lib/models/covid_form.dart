class CovidForm {
  static const Fever = 'fever';
  static const Breath = 'breath';
  static const Cough = 'cough';
  static const Throat = 'throat';
  static const Nose = 'nose';
  static const Taste = 'taste';
  static const Nausea = 'nausea';
  static const Tiredness = 'tiredness';

  String firstName = "";
  String middleName = "";
  String lastName = "";

  Map<String, bool> symptoms = {
    Fever: false,
    Breath: false,
    Cough: false,
    Throat: false,
    Nose: false,
    Taste: false,
    Nausea: false,
    Tiredness: false
  };

  bool travelled = false;
  bool contact = false;

  Future<void> sendMail() async {}

  bool passed() {
    if (travelled || contact) return false;

    if (symptoms.values.any((val) => val)) return false;

    return true;
  }
}
