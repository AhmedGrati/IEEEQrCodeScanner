import 'dart:convert';

import 'package:qr_code_ieee/global_config.dart';
import 'package:qr_code_ieee/model/api_response.dart';
import 'package:qr_code_ieee/model/partner.dart';
import 'package:http/http.dart' as http;
import 'package:qr_code_ieee/model/scan_body.dart';
import 'package:qr_code_ieee/model/secret.dart';
import 'package:qr_code_ieee/model/QrScanResponse.dart';
class PartnerService {
  final String url = GlobalConfig.API_URL;
  Future<ApiResponse<Partner>> loginPartner(Secret secret) {
    print(secret.toJson());
    return http.post(
      this.url+"partner/auth",
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
      return ApiResponse<Partner>(errorMessage: 'An error occurred!',error: true);
    });
  }

  Future<ApiResponse<QrScanResponse>> scanQRCode(ScanBody scan) {

    return http.post(
        this.url+"/qr-code",
        headers: GlobalConfig.headers,
        body: json.encode(scan.toJson())
    ).then((res) {
      var jsonData = json.decode(res.body);
      QrScanResponse user = QrScanResponse.fromJson(jsonData);
      print("user: ${user.expiredAccout}");
      if(res.statusCode == 201 || res.statusCode == 200) {
        if(user.expiredAccout) {
          return ApiResponse<QrScanResponse>(data: user);
        }
        return ApiResponse<QrScanResponse>(error: true , errorMessage: 'Member not active!');
      }else{
        return ApiResponse<QrScanResponse>(error: true , errorMessage: 'Member not found!');
      }
    }).catchError((err) {
      print('error : $err');
      return ApiResponse<QrScanResponse>(errorMessage: 'An error occurred!',error: true);
    });
  }

}