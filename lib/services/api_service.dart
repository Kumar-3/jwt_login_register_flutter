import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:jwt_login_register/config.dart';
import 'package:jwt_login_register/models/login_request_model.dart';
import 'package:jwt_login_register/models/login_response_model.dart';
import 'package:jwt_login_register/models/register_request_model.dart';
import 'package:jwt_login_register/models/register_response_model.dart';
import 'package:jwt_login_register/services/shared_service.dart';

class APIservice {
  static var client = http.Client();
  static Future<bool> login(login_request_model model) async {
    Map<String, String> requestHeader = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(Config.apiUrl + Config.loginApi);
    var response = await client.post(url,
        headers: requestHeader, body: jsonEncode(model.toJson()));
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(loginResponseJson(response.body));
      return true;
    } else {
      return false;
    }
  }

  static Future<RegisterResponseModel> register(
      register_request_model model) async {
    Map<String, String> requestHeader = {
      'Content-Type': 'application/json',
    };
    var url = Uri.parse(Config.apiUrl + Config.registerApi);
    var response = await client.post(url,
        headers: requestHeader, body: jsonEncode(model.toJson()));
    return registerResponseModel(response.body);
  }

  static Future<String> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeader = {
      'Content-Type': 'application/json',
      'Authorization': 'Basic ${loginDetails!.data!.token}'
    };
    var url = Uri.parse(Config.apiUrl + Config.userProfileApi);
    var response = await client.get(
      url,
      headers: requestHeader,
    );
    return (response.body);
    // if (response.statusCode == 200) {
    //   return response.body;
    // } else {
    //   return "";
    // }
  }
}
