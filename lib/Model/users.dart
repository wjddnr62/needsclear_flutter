class Users {
  String id;
  String name;
  String pass;
  String phone;
  String birthDay;
  int point;
  String pushRecoCode;
  int recoPerson;
  int recoPrice;
  String royalCode;
  int sex;
  String signDate;
  String signRoot;
  int type;

  Users(
      {this.id,
      this.name,
      this.pass,
      this.phone,
      this.birthDay,
      this.point,
      this.pushRecoCode,
      this.recoPerson,
      this.recoPrice,
      this.royalCode,
      this.sex,
      this.signDate,
      this.signRoot,
      this.type});

  toJson() {
    return {
      "\"id\"": this.id,
      "\"name\"": this.name,
      "\"pass\"": this.pass,
      "\"phone\"": this.phone,
      "\"birthDay\"": this.birthDay,
//      "point": this.point,
//      "pushRecoCode": this.pushRecoCode,
//      "recoPerson": this.recoPerson,
//      "recoPrice": this.recoPrice,
//      "royalCode": this.royalCode,
      "\"sex\"": this.sex,
      "\"signDate\"": this.signDate,
      "\"signRoot\"": this.signRoot,
      "\"type\"": this.type
    };
  }
}
