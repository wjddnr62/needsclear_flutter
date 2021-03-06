import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:needsclear/Util/parameter.dart';

class Provider {
  Client client = Client();

  final baseUrl = "http://auth.cashlink.kr/auth_api/";

//  final baseUrl = "http://192.168.100.237/auth_api/";
  final needsUrl = "http://needsclear.kr/needs_api/";

  final usersUrl = "api/users";
  final saveLogUrl = "api/savelog";
  final laundryUrl = "api/laundry";
  final chauffeurUrl = "api/chauffeur";
  final phoneUrl = "api/phone";
  final internetUrl = "api/internet";
  final eventUrl = "api/event";
  final noticeUrl = "api/notice";
  final faqUrl = "api/faq";
  final inquiryUrl = "api/inquiry";

  final getToken = "oauth/token";

  String userCheckUrl = "http://auth.cashlink.kr/resource_api/api/users/me";

//  String userCheckUrl = "http://192.168.100.237/resource_api/api/users/me";

  Future<String> selectPremium() async {
    final response = await client.get("${needsUrl}api/admin/select-premium");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> selectInquiry(id) async {
    final response =
        await client.get("$needsUrl$inquiryUrl/app-select-inquiry?id=$id");
    print("$needsUrl$inquiryUrl/app-select-inquiry?id=$id");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> insertInquiry(id, title, question) async {
    final response = await client.put(
        "$needsUrl$inquiryUrl/insert-inquiry?id=$id&title=$title&question=$question");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getFaq() async {
    final response = await client.get("$needsUrl$faqUrl/select-faq");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getNotice() async {
    final response = await client.get("$needsUrl$noticeUrl/select-notice");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getRecoUser(idx) async {
    final response =
        await client.get("$needsUrl$usersUrl/get-reco-user?idx=$idx");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> recoUpdate(idx, id, recoCode) async {
    final response = await client.put(
        "$needsUrl$usersUrl/reco-update?idx=$idx&id=$id&recoCode=$recoCode");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> selectRecoRegister(name, phone) async {
    final response = await client
        .get("$needsUrl$usersUrl/select-reco-register?name=$name&phone=$phone");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> selectSavelog(id) async {
    final response =
        await client.get("$needsUrl$saveLogUrl/savelog-select?id=$id");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getEvent() async {
    final response = await client.get("$needsUrl$eventUrl/select-event");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> exchange(idx, dl) async {
    final response = await client
        .put("$needsUrl$usersUrl/exchange-ncp?idx=$idx&dl=${dl.toInt()}");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> authToken() async {
    final response = await client.post("$baseUrl$getToken", body: {
      "client_id": "needs_clear",
      "client_secret": "Laonpp00..L",
      "grant_type": "authorization_code",
      "code": parameter.oauthCode,
//      "redirect_uri": "http://localhost:3000"
      "redirect_uri": "http://admin.needsclear.kr/login/index.html"
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
    print(needsUrl + usersUrl + "/user-select");
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
      {collectionType, washType, address, washPayment, id, phone, name, code}) async {
    final response = await client.put(needsUrl +
        laundryUrl +
        "/apply-wash?collectionType=$collectionType&washType=$washType&address=$address&washPayment=$washPayment&id=$id&phone=$phone&name=$name&code=$code");

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
    final response = await client
        .get(needsUrl + chauffeurUrl + "/app-select-chauffeur?id=$id");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> insertChauffeur(id, start, end, name, phone) async {
    final response = await client.put(needsUrl +
        chauffeurUrl +
        "/chauffeur-insert?id=$id&start=$start&end=$end&name=$name&phone=$phone");

    return utf8.decode(response.bodyBytes);
  }

  //휴대폰 현황 조회
  Future<String> getPhone(id) async {
    final response =
        await client.get(needsUrl + phoneUrl + "/app-get-phone?id=$id");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> insertPhone(id, name, phone, nowNewsAgency, changeNewsAgency,
      serviceType, deviceName) async {

    final response = await client.put(needsUrl +
        phoneUrl +
        "/app-insert-phone?id=$id&nowNewsAgency=$nowNewsAgency&changeNewsAgency=$changeNewsAgency&name=$name&phone=$phone&serviceType=$serviceType&deviceName=$deviceName");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getDevice() async {
    final response = await client.get(needsUrl + phoneUrl + "/get-device");
    return utf8.decode(response.bodyBytes);
  }

  //인터넷 현황 조회
  Future<String> getInternet(id) async {
    final response = await client
        .get(needsUrl + internetUrl + "/app-select-internet?id=$id");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> insertInternet(
      id, name, phone, applyNewsAgency, applyService) async {
    final response = await client.put(needsUrl +
        internetUrl +
        "/app-insert-internet?id=$id&applyNewsAgency=$applyNewsAgency&applyService=$applyService&name=$name&phone=$phone");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getAgency() async {
    final response = await client
        .get(needsUrl + internetUrl + "/select-newsagency");

    return utf8.decode(response.bodyBytes);
  }

  Future<String> getService() async {
    final response = await client
        .get(needsUrl + internetUrl + "/select-service");

    return utf8.decode(response.bodyBytes);
  }

  //추천인 등록
  Future<String> insertReco(
      recoIdx, recoCode, name, phone) async {
    final response = await client.put(needsUrl +
        usersUrl +
        "/set-reco-register?recoIdx=$recoIdx&recoCode=$recoCode&name=$name&phone=$phone");

    return utf8.decode(response.bodyBytes);
  }
}

final provider = Provider();