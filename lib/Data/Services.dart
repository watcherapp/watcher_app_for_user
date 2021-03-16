import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:watcher_app_for_user/Constants/StringConstants.dart';
import 'package:watcher_app_for_user/Data/ClassList/ResponseClass.dart';

Dio dio = new Dio();

class Services {
  static Future<List> postForList({@required apiName, body}) async {
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
        List dataList = [];
        var responseData = response.data;
        if (responseData["IsSuccess"] == true &&
            responseData["Data"].length > 0) {
          dataList = responseData["Data"];
        }
        return dataList;
      } else {
        debugPrint("error" + response.data.toString());
        throw Exception("error->" + response.data.toString());
      }
    } catch (e) {
      debugPrint("Catch Error-> ${e.toString()}");
      throw Exception("Catch Error->${e.toString()}");
    }
  }

  static Future<ResponseDataClass> postForSave(
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
}
