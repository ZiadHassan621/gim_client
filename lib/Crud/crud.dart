// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

class Crud {
  getData(String url, String accesstoken) async {
    try {
      var response = await http.get(Uri.parse(url),
          headers: {'Authorization': 'Bearer $accesstoken'});
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return {
          'ResponseBody': jsonDecode(response.body),
          'StatusCode': response.statusCode
        };
      } else {
        return {
          'ResponseBody': response.body,
          'StatusCode': response.statusCode
        };
      }
    } catch (e) {
      print("Message : $e");
    }
  }

  postData(String url, Map data) async {
    print("we at crud");
    print("aloooooooo");
    try {
      var response = await http.post(Uri.parse(url), body: data);

      // print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = jsonDecode(response.body);

        return {
          "ResponseBody": responsebody,
          "StatusCode": response.statusCode
        };
      } else if (response.statusCode == 403) {
        return {
          "ResponseBody": response.body,
          "StatusCode": response.statusCode
        };
      } else {
        var responsebody = jsonDecode(response.body);
        return {
          "ResponseBody": responsebody,
          "StatusCode": response.statusCode
        };
      }
    } catch (e) {
      print("ERROR : $e");
    }
  }

  deleteData(String url, String refreshtoken, String accesstoken) async {
    try {
      var response = await http.delete(Uri.parse(url),
          body: {"refreshToken": refreshtoken},
          headers: {'Authorization': 'Bearer $accesstoken'});
      var responsebody = jsonDecode(response.body);
      print(response.statusCode);
      if (response.statusCode == 204) {
        return {
          "ResponseBody": responsebody,
          "StatusCode": response.statusCode
        };
      } else if (response.statusCode == 500) {
        return {
          "ResponseBody": responsebody['error'],
          "StatusCode": response.statusCode
        };
      } else if (response.statusCode == 400) {
        return {
          "ResponseBody": responsebody['error'],
          "StatusCode": response.statusCode
        };
      }
    } catch (e) {
      print("ERROR : $e");
    }
  }

  postDatatocreategym(String url, Map data, String accesstoken) async {
    print("we at post Data To create gym");
    print("aloooooooo");
    try {
      var response = await http.post(Uri.parse(url),
          body: data, headers: {'Authorization': 'Bearer $accesstoken'});

      // print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var responsebody = jsonDecode(response.body);

        return {
          "ResponseBody": responsebody,
          "StatusCode": response.statusCode
        };
      } else if (response.statusCode == 403) {
        return {
          "ResponseBody": response.body,
          "StatusCode": response.statusCode
        };
      } else {
        var responsebody = jsonDecode(response.body);
        return {
          "ResponseBody": responsebody,
          "StatusCode": response.statusCode
        };
      }
    } catch (e) {
      print("ERROR : $e");
    }
  }

  deleteGymbyId(String url, String accesstoken) async {
    try {
      var response = await http.delete(Uri.parse(url),
          headers: {'Authorization': 'Bearer $accesstoken'});
      // print(response.statusCode);
      if (response.statusCode == 200) {
        return {
          "ResponseBody": jsonDecode(response.body),
          "StatusCode": response.statusCode
        };
      } else if (response.statusCode == 403) {
        return {
          "ResponseBody": response.body,
          "StatusCode": response.statusCode
        };
      } else {
        return {
          "ResponseBody": jsonDecode(response.body),
          "StatusCode": response.statusCode
        };
      }
    } catch (e) {
      print("ERROR : $e");
    }
  }
}
