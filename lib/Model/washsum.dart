class WashSum {
  Wash wash;
  List<Laundries> laundries;

  WashSum({this.wash, this.laundries});
}

class Wash {
  int idx;
  int collectionType;
  int washType;
  String address;
  int washPayment;
  String id;
  String phone;
  String name;
  String code;
  String date;

  Wash(
      {this.idx,
      this.collectionType,
      this.washType,
      this.address,
      this.washPayment,
      this.id,
      this.phone,
      this.name,
      this.code,
      this.date});
}

class Laundries {
  String id;
  String code;
  String name;
  int payment;
  int type;
  int count;

  Laundries(
      {this.id, this.code, this.name, this.payment, this.type, this.count});
}
