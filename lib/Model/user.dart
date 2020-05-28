class User {
  int idx;
  String id;
  String name;
  String phone;
  String birthDay;
  int type;
  int point;
  String pushRecoCode;
  String recoCode;
  int recoPerson;
  int recoPrice;
  int gender;
  String signDate;
  double dl;
  int autoSale;

  User(
      {this.idx,
      this.id,
      this.name,
      this.phone,
      this.birthDay,
      this.type,
      this.point,
      this.pushRecoCode,
      this.recoCode,
      this.recoPerson,
      this.recoPrice,
      this.gender,
      this.signDate,
      this.dl,
      this.autoSale});

  factory User.fromJson(Map<dynamic, dynamic> data) {
    print("fromJson : $data");

    return User(
        idx: data['idx'],
        id: data['id'],
        name: data['name'],
        phone: data['phone'],
        birthDay: data['birthDay'],
        type: data['type'],
        point: data['point'],
        pushRecoCode: data['pushRecoCode'],
        recoCode: data['recoCode'],
        recoPerson: data['recoPerson'],
        recoPrice: data['recoPrice'],
        gender: data['gender'],
        signDate: data['signDate'],
        dl: data['dl'],
        autoSale: data['autoSale']);
  }
}
