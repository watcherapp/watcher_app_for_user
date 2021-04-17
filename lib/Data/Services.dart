import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Data/ClassList/ResponseClass.dart';

Dio dio = new Dio();

class Services {
  static Future<ResponseDataClass> responseHandler(
      {@required apiName, body}) async {
    String url = API_URL + "$apiName";
    var header = Options(
      headers: {
        "authorization": "$Access_Token" // set content-length
      },
    );
    var response;
    try {
      if (body == null) {
        response = await dio.post(url, options: header);
      } else {
        response = await dio.post(url, data: body, options: header);
      }
      if (response.statusCode == 200) {
        ResponseDataClass responseData = new ResponseDataClass(
            Message: "No Data", IsSuccess: false, Data: "");
        var data = response.data;
        responseData.Message = data["Message"];
        responseData.IsSuccess = data["IsSuccess"];
        responseData.Data = data["Data"];

        return responseData;
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Catch error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  static Future<ResponseDataClass> responseHandlerForBase64(
      {@required apiName, body}) async {
    String url = API_URL + "$apiName";
    var header = Options(
        headers: {
          "authorization": "$Access_Token" ,
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        contentType: Headers.formUrlEncodedContentType
    );
    String jsonString = json.encode(body); // encode map to json
    // String paramName = 'param'; // give the post param a name
    // String formBody = paramName + '=' + Uri.encodeQueryComponent(jsonString);
    var response;
    //Instance level
    dio.options.contentType= Headers.formUrlEncodedContentType;
    try {
      if (jsonString == null) {
        response = await dio.post(url);
      } else {
        response = await dio.post(url, data: body,options:header);
      }
      print(body);
      print(apiName);
      if (response.statusCode == 200) {
        ResponseDataClass responseData = new ResponseDataClass(
            Message: "No Data", IsSuccess: false, Data: "");
        var data = response.data;
        print(response.data["Data"]);
        responseData.Message = data["Message"];
        responseData.IsSuccess = data["IsSuccess"];
        responseData.Data = data["Data"];

        return ResponseDataClass.fromJson(data);
      } else {
        print("error ->" + response.data.toString());
        throw Exception(response.data.toString());
      }
    } catch (e) {
      print("Catch error -> ${e.toString()}");
      throw Exception(e.toString());
    }
  }
}
