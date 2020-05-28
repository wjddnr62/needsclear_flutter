class Parameter {
  static final Parameter parameter = Parameter._internal();

  factory Parameter() {
    return parameter;
  }

  Parameter._internal();

  String _oauthCode;

  // ignore: unnecessary_getters_setters
  set oauthCode(String value) {
    _oauthCode = value;
  }

  // ignore: unnecessary_getters_setters
  String get oauthCode => _oauthCode;
}

final parameter = Parameter();
