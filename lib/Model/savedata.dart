class SaveData {
  static final SaveData _saveData = SaveData._internal();

  factory SaveData() {
    return _saveData;
  }

  SaveData._internal();

  String _reCoId;

  String get reCoId => _reCoId;

  set reCoId(String value) {
    _reCoId = value;
  } // 추천 아이디

  int _point;
  int _recoPerson;
  int _recoPrice;


  int get recoPerson => _recoPerson;

  set recoPerson(int value) {
    _recoPerson = value;
  }

  int get point => _point;

  set point(int value) {
    _point = value;
  }

  String _phoneNumber;
  String _name;
  String _birthday;
  int _sex;
  String _type; // 0 = 일반 회원, 1 = 카카오, 2 = 구글, 3 = 페이스북

  // 일반 회원만 받는 정보
  String _id;
  String _pass;
  String _signRoot;
  String _recoCode;
  String _myRecoCode;


  String get myRecoCode => _myRecoCode;

  set myRecoCode(String value) {
    _myRecoCode = value;
  }

  String get phoneNumber => _phoneNumber;

  String get recoCode => _recoCode;

  set recoCode(String value) {
    _recoCode = value;
  }

  String get signRoot => _signRoot;

  set signRoot(String value) {
    _signRoot = value;
  }

  String get pass => _pass;

  set pass(String value) {
    _pass = value;
  }

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  int get sex => _sex;

  set sex(int value) {
    _sex = value;
  }

  String get birthday => _birthday;

  set birthday(String value) {
    _birthday = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  set phoneNumber(String value) {
    _phoneNumber = value;
  }

  int get recoPrice => _recoPrice;

  set recoPrice(int value) {
    _recoPrice = value;
  }


}