import 'dart:convert';

import 'package:qr_code_ieee/global_config.dart';
import 'package:qr_code_ieee/model/api_response.dart';
import 'package:qr_code_ieee/model/user.dart';
import 'package:http/http.dart' as http;
class UserService {

  Future<ApiResponse<User>> getUserById(String id) {
    return http.get(GlobalConfig.API_URL+"/ieee/$id" , headers: GlobalConfig.headers).
      then((res) {
        print("res : ${res.body}");
        if(res.statusCode == 200) {
          final jsonData = json.decode(res.body);
          print("jsonData : $jsonData");
          final User user = User.fromJson(jsonData);
          print("user : $user");
          if(user.membershipActive) {
            return ApiResponse<User>(data: user);
          }else{
            return ApiResponse<User>(errorMessage: "Member not active!" , error: true);
          }
        }else{
          return ApiResponse<User>(error:true , errorMessage: "Member not found");
        }
      }).catchError((err) {
        print("errrroro ${err.toString()}");
        return ApiResponse<User>(error:true , errorMessage: "An error occured!");
      });
  }

}