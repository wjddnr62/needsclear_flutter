class Dress {
  String dressName;
  int dressType;
  int dressPayment;

  Dress({this.dressName, this.dressType, this.dressPayment});

  factory Dress.fromJson(Map<dynamic, dynamic> data) {
    return Dress(
        dressName: data['name'],
        dressType: data['type'],
        dressPayment: data['payment']);
  }
}

class DressSet {
  String dressName;
  int dressCount;
  int dressPay;
  int dressType;

  DressSet({this.dressName, this.dressCount, this.dressPay, this.dressType});
}
