import 'dart:convert';

import 'package:aladdinmagic/Util/parameter.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class Provider {
  Client client = Client();
  final baseUrl = "http://49.247.3.220/auth_api/";
  final needsUrl = "http://needsclear.kr/needs_api";

  final usersUrl = "api/users";
  final saveLogUrl = "api/savelog";
  final laundryUrl = "api/laundry";
  final chauffeurUrl = "api/chauffeur";
  final phoneUrl = "api/phone";
  final internetUrl = "api/internet";

  final getToken = "oauth/token";
  String userCheckUrl = "http://49.247.3.220/resource_api/api/users/me";

  Future<String> authToken() async {
    final response = await client.post("$baseUrl$getToken", body: {
      "client_id": "needs_clear",
      "client_secret": "Laonpp00..L",
      "grant_type": "authorization_code",
      "code": parameter.oauthCode,
      "redirect_uri": "http://localhost:3000"
    });

    return utf8.decode(response.bodyBytes);
  }

  Future<String> authCheck(accessToken) async {
    final response = await client
        .get(userCheckUrl, headers: {"authorization": "Bearer $accessToken"});

    return utf8.decode(response.bodyBytes);
  }

  Future<String> selectUser(id) async {
    final response = await client
        .post(needsUrl + usersUrl + "/user-select", body: {"id": id});

    return utf8.decode(response.bodyBytes);
  }

  Future<String> insertUser(
      String id, String name, String phone, String birthDay, int gender) async {
    final response = await client.get(needsUrl +
        usersUrl +
        "/user-insert?id=$id&name=$name&phone=$phone&birthDay=$birthDay&type=0&point=10000&recoCode=$phone&recoPerson=0&recoPrice=0&gender=$gender&signDate=${DateFormat("yyyy-MM-dd").format(DateTime.now())}&dl=0");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> saveLogInsert(
      {date,
      id,
      name,
      phone,
      point,
      saveMonth,
      savePlace,
      saveType,
      type}) async {
    final response = await client.get(needsUrl +
        saveLogUrl +
        "/savelog-insert?date=$date&id=$id&name=$name&phone=$phone&point=$point&saveMonth=${saveMonth != null ? saveMonth : ""}&savePlace=$savePlace&saveType=$saveType&type=$type");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> checkRecoCode(recoCode) async {
    final response = await client.post(needsUrl + usersUrl + "/check-reco-code",
        body: {"recoCode": recoCode});

    return utf8.decode(response.bodyBytes);
  }

  Future<String> checkRoyalCode(royalCode) async {
    final response = await client.post(
        needsUrl + usersUrl + "/check-royal-code",
        body: {"royalCode": royalCode});

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getDress() async {
    final response = await client.get(needsUrl + laundryUrl + "/get-dress");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> insertWash(
      {collectionType, address, washPayment, id, phone, name, code}) async {
    final response = await client.put(needsUrl +
        laundryUrl +
        "/apply-wash?collectionType=$collectionType&address=$address&washPayment=$washPayment&id=$id&phone=$phone&name=$name&code=$code");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> insertLaundry({id, code, name, payment, type, count}) async {
    final response = await client.put(needsUrl +
        laundryUrl +
        "/apply-laundry?id=$id&code=$code&name=$name&payment=$payment&type=$type&count=$count");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> pointInsert({id, point}) async {
    final response = await client.put(needsUrl +
        "api/users/user-update-point?idx=$id&point=${point.toInt()}");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> pointManageSelect() async {
    final response = await client.get(needsUrl + "api/point/get-point-manage");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getWash(id) async {
    final response =
        await client.get(needsUrl + laundryUrl + "/app-get-wash?id=$id");

    return utf8.decode(response.bodyBytes);
  }

  //대리 운전 조회
  Future<String> getChauffeur(id) async {
    final response =
    await client.get(needsUrl + chauffeurUrl + "/app-select-chauffeur?id=$id");

    return utf8.decode(response.bodyBytes);
  }
  //휴대폰 현황 조회
  Future<String> getPhone(id) async {
    final response =
    await client.get(needsUrl + phoneUrl + "/app-get-phone?id=$id");

    return utf8.decode(response.bodyBytes);
  }
  //인터넷 현황 조회
  Future<String> getInternet(id) async {
    final response =
    await client.get(needsUrl + internetUrl + "/app-select-internet?id=$id");

    return utf8.decode(response.bodyBytes);
  }

}
