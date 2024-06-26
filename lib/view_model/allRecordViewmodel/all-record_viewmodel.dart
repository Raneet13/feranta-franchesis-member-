import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/past_record/all_record_model.dart';
import '../../repository/past_record_repository/record_repo.dart';
import '../../static/flutter_toast_message/toast_messge.dart';

class RecordViewmodel extends ChangeNotifier {
  late TabController tabController;
  TextEditingController textfieldText = TextEditingController();
  Allrecord? allrecord;
  bool isLoading = false;
  int initialIndex = 0;
  DateTime selectedDate = DateTime.now();
  List<UserList>? datewseRecord;
  bool filter = false;
  bool showFilterOption = false;
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

  mytripTabno(int value) {
    initialIndex = value;
    notifyListeners();
  }

  updateFilterOption(bool option) {
    showFilterOption = !option;
    notifyListeners();
  }

  Future selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: selectedDate,
    );
    if (picked != null) {
      await dateWiserecord(picked);

      // selectedDate = picked;
    }

    notifyListeners();
  }

  Future dateWiserecord(DateTime date) async {
    isLoadingTrue();

    datewseRecord = allrecord!.response!.userList!
        .where((element) =>
            DateFormat("dd-MM-yyyy")
                .format(DateTime.parse(element.createdDate!)) ==
            DateFormat("dd-MM-yyyy").format(date))
        .toList();
    showFilterOption = false;
    isLoadingFalse();
    notifyListeners();
  }

  // Future carnoWiserecord(String number) async {
  //   isLoadingTrue();

  //   datewseRecord = allrecord!.response!.userList!
  //       .where((element) =>
  //           DateFormat("dd-MM-yyyy")
  //               .format(DateTime.parse(element.createdDate!)) ==
  //           DateFormat("dd-MM-yyyy").format(date))
  //       .toList();

  //   isLoadingFalse();
  //   notifyListeners();
  // }
  Future licensenoWiserecord(String lcnNumber) async {
    isLoadingTrue();
    if (lcnNumber == "") {
      filter = false;
    } else {
      datewseRecord = allrecord!.response!.userList!
          .where((element) =>
              element.licenseNo!.contains(lcnNumber) ||
              element.contactNo!.contains(lcnNumber))
          .toList();
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
