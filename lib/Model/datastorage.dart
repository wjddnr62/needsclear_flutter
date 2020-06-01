import 'package:needsclear/Model/pointmanage.dart';
import 'package:needsclear/Model/user.dart';

class DataStorage {
  static final DataStorage dataStorage = DataStorage._internal();

  factory DataStorage() {
    return dataStorage;
  }

  DataStorage._internal();

  User _user;

  // ignore: unnecessary_getters_setters
  User get user => _user;

  // ignore: unnecessary_getters_setters
  set user(User value) {
    _user = value;
  }

  List<PointManage> _pointManage;

  List<PointManage> get pointManage => _pointManage;

  set pointManage(List<PointManage> value) {
    _pointManage = value;
  }
}

final dataStorage = DataStorage();
