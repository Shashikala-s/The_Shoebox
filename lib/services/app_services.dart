import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shoe_app/Widget/AppScaffoldMessenger.dart';
import 'package:shoe_app/model/shoe_model.dart';
import 'package:shoe_app/services/api_config.dart';

class AppServices {
  Future<List<ShoesModel>> showData(BuildContext context) async {
    List<ShoesModel> shoeList = [];
    String url = ApiConfig.ProductAPI;

    var response = await http.get(
      Uri.parse(url),
    );

    try {
      final json = jsonDecode(response.body).cast<String, dynamic>();
      if (json['result'] == 'success') {
        shoeList = json['data']
            .map<ShoesModel>((json) => ShoesModel.fromJson(json))
            .toList();
      } else {
        AppScaffoldMessenger()
            .errorMsg(context, 'Problem occurred. Please try again later');
      }
    } on TimeoutException {
      AppScaffoldMessenger()
          .errorMsg(context, 'Problem occurred. Please try again later');

      print('Timeout');
    } on SocketException {
      AppScaffoldMessenger()
          .errorMsg(context, 'Problem occurred. Please try again later');

      print('SocketException');
    } on Error catch (e) {
      AppScaffoldMessenger()
          .errorMsg(context, 'Problem occurred. Please try again later');

      print('Error: $e');
    }
    return shoeList;
  }
}
