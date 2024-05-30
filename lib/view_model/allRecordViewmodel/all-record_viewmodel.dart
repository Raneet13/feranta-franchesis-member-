import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/past_record/all_record_model.dart';
import '../../repository/past_record_repository/record_repo.dart';
import '../../static/flutter_toast_message/toast_messge.dart';

class RecordViewmodel extends ChangeNotifier {
  Allrecord? allrecord;
  bool isLoading = false;

  Future viewAllrecord() async {
    isLoadingTrue();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = await prefs.getString('userId');
    var allData = await RecordApiRepository().recordRepo(member_id: userId);
    // myprofileDetaisModel = MyprofileDetaisModel.fromJson(allData);
    if (allData["error"] == null) {
      allrecord = Allrecord.fromJson(allData);
    } else {
      ShowToast(msg: "Failed to load Data");
    }
    isLoadingFalse();
    notifyListeners();
  }

  //   isLoadingFalse();
  //   notifyListeners();
  // }

  isLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  isLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }
}
