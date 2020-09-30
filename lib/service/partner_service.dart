import 'dart:convert';

import 'package:qr_code_ieee/global_config.dart';
import 'package:qr_code_ieee/model/api_response.dart';
import 'package:qr_code_ieee/model/partner.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_ieee/model/scan_body.dart';
import 'package:qr_code_ieee/model/secret.dart';
import 'package:qr_code_ieee/model/user.dart';
class PartnerService {
  final String url = GlobalConfig.API_URL+"/api/partner";
  Future<ApiResponse<Partner>> loginPartner(Secret secret) {

    return http.post(
      this.url+"/code",
      headers: GlobalConfig.headers,
      body: json.encode(secret.toJson())
    ).then((res) {
      var jsonData = json.decode(res.body);
      Partner partner = Partner.fromJson(jsonData);
      if(res.statusCode == 201) {
        if(partner.active) {
          return ApiResponse<Partner>(data: partner);
        }
        return ApiResponse<Partner>(error: true , errorMessage: 'Partner not active!');
      }else{
        return ApiResponse<Partner>(error: true , errorMessage: 'invalid secret code');
      }
    }).catchError((err) {
      print('error : $err');
      return ApiResponse<Partner>(errorMessage: 'An error occurred!',error: true);
    });
  }

  Future<ApiResponse<User>> scanQRCode(ScanBody scan) {

    return http.post(
        this.url+"/code",
        headers: GlobalConfig.headers,
        body: json.encode(scan.toJson())
    ).then((res) {
      var jsonData = json.decode(res.body);
      User user = User.fromJson(jsonData);
      print("user: ${user.membershipActive}");
      if(res.statusCode == 201 || res.statusCode == 200) {
        if(user.membershipActive) {
          return ApiResponse<User>(data: user);
        }
        return ApiResponse<User>(error: true , errorMessage: 'Member not active!');
      }else{
        return ApiResponse<User>(error: true , errorMessage: 'Member not found!');
      }
    }).catchError((err) {
      print('error : $err');
      return ApiResponse<User>(errorMessage: 'An error occurred!',error: true);
    });
  }

}