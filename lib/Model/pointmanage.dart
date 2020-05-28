class PointManage {
  int idx;
  int type;
  int serviceType;
  int rewordType;
  int myselfPercent;
  int directlyPercent;
  int indirectPercent;
  int myselfPoint;
  int directlyPoint;
  int indirectPoint;

  PointManage(
      {this.idx,
      this.type,
      this.serviceType,
      this.rewordType,
      this.myselfPercent,
      this.directlyPercent,
      this.indirectPercent,
      this.myselfPoint,
      this.directlyPoint,
      this.indirectPoint});

  factory PointManage.fromJson(Map<dynamic, dynamic> data) {
    return PointManage(
        idx: data['idx'],
        type: data['type'],
        serviceType: data['serviceType'],
        rewordType: data['rewordType'],
        myselfPercent: data['myselfPercent'],
        directlyPercent: data['directlyPercent'],
        indirectPercent: data['indirectPercent'],
        myselfPoint: data['myselfPoint'],
        directlyPoint: data['directlyPoint'],
        indirectPoint: data['indirectPoint']);
  }
}
