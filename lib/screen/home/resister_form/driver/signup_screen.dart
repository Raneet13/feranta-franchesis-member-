// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:feranta_franchise/model/resister/master_model.dart'
    as chooselocation;
import 'package:feranta_franchise/repository/resister/resister_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:provider/provider.dart';
import '../../../../static/flutter_toast_message/toast_messge.dart';
import '../../../../static/validator/all_textfield_validator.dart';
import '../../../../view_model/auth/login-viewmodel.dart';
import '../../../../view_model/resister/all_resister_viewmodel.dart';
import '../upload_document.dart';

class SignUpDriverPage extends StatefulWidget {
  const SignUpDriverPage({super.key});

  @override
  State<SignUpDriverPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpDriverPage> {
  // TextEditingController vechicleNo = TextEditingController();
  // // // TextEditingController lname = TextEditingController();
  // TextEditingController email = TextEditingController();
  // TextEditingController phoone = TextEditingController();
  // TextEditingController altPhone = TextEditingController();
  // // TextEditingController image = TextEditingController();
  GlobalKey<FormState> formKey = new GlobalKey();
  // final items = ['CAB', 'AMBULANCE', 'LIFT'];
  // String selectedValue = 'CAB';
  // String? file1;
  // String? file2;
  // String? path;
  // File? profileImage;

  int index = 0;
  @override
  void initState() {
    // TODO: implement initState

    // provider.deliveryBoyLoginProfile;

    // address2 = TextEditingController(text: widget.address["adress2"]);
    // cityName = widget.address["cityname"];
    // areaName = widget.address["cityname"];
    // pincode = widget.address["pincode"];
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ResisterViewmodel>(context, listen: false).getAllMaster();
    });
  }

  Validate(input) {
    if (input.isEmpty) {
      return 'Please type something';
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Provider.of<ResisterViewmodel>(context, listen: false)
      ..isLoading = false
      ..clearResistationForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.amber[100],
          leading: InkWell(
            onTap: () {
              Provider.of<ResisterViewmodel>(context, listen: false)
                ..isLoading = false
                ..clearResistationForm();
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Driver Register Form",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
          child: Consumer<ResisterViewmodel>(builder: (context, loginD, _) {
            return ElevatedButton(
                onPressed: () async {
                  // var loginD =
                  //     Provider.of<ResisterViewmodel>(context, listen: false);
                  // .userRegister();
                  // if (loginD.isLoading) {
                  if (formKey.currentState!.validate()) {
                    if (loginD.img != null &&
                        loginD.frontimg != null &&
                        loginD.backimg != null &&
                        loginD.license_img != null &&
                        loginD.pinCode != "") {
                      await loginD.userRegister(context);
                      ShowToast(msg: "Wait for resistation process");
                    } else {
                      ShowToast(msg: "Enter All the Image Field");
                      ShowToast(msg: "first choose State,city, pincode");
                    }
                  }
                  // } else {
                  //   null;
                  // }
                },
                child: loginD.isLoading
                    ? CircularProgressIndicator()
                    : Text("Register"));
          }),
        ),
        body: Consumer<ResisterViewmodel>(builder: (context, val, _) {
          return val.masterModel == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: ListView(
                      shrinkWrap: true,
                      primary: true,
                      // physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("User Details")),
                              Container(
                                height: 100,
                                width: 100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Stack(
                                  children: [
                                    val.img != null
                                        ? Container(
                                            alignment: Alignment.bottomRight,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(23),
                                                color: Colors.amber[50],
                                                image: DecorationImage(
                                                    image: FileImage(val.img!),
                                                    fit: BoxFit.fill)),
                                            //   child: Icon(
                                            //     Icons.edit,
                                            //     size: 50,
                                            //     color: Colors.red,
                                            //   ),
                                          )
                                        : Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(23),
                                                color: Colors.amber[50]),
                                            child: Icon(
                                              Icons.account_circle_outlined,
                                              size: 50,
                                              color: Colors.grey.shade300,
                                            ),
                                          ),
                                    Positioned(
                                        bottom: 10,
                                        right: 0,
                                        child: InkWell(
                                          onTap: () => val.insertLogo(),
                                          child: Material(
                                            color: Colors.white,
                                            child: Icon(
                                              Icons.edit,
                                              size: 25,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Name"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.name,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) =>
                                          ValidateAll.inputValidate(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter email"),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Name",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Email"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.email,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) =>
                                          ValidateAll.validateEmail(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter email"),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Email",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Phone Nuber"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.contact,
                                      keyboardType: TextInputType.number,
                                      validator: (input) =>
                                          ValidateAll.validateMobile(input),
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "phone number",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Password"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.resister_password,
                                      keyboardType: TextInputType.text,
                                      // validator: (input) =>
                                      //     ValidateAll.inputValidate(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Password",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Alternet Phno."),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.altcontact,
                                      keyboardType: TextInputType.number,
                                      validator: (input) =>
                                          ValidateAll.validateMobile(input),
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(10),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Phone number",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              // select type of cab by choosing option
                              Container(
                                height: 48,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    // color: Colors.grey.shade300,
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(10)),
                                // color: Colors.grey.shade300,
                                // dropdown below..
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Select State"),
                                    DropdownButton<chooselocation.State>(
                                      // value:val.state==""? val
                                      //     .masterModel!.response!.state!.first:val.state,
                                      hint: Text(val.state),
                                      onChanged: (newValue) => val
                                          .updateSttate(newValue!.stateName!),
                                      items: val.masterModel!.response!.state!
                                          .map<
                                                  DropdownMenuItem<
                                                      chooselocation.State>>(
                                              (value) => DropdownMenuItem<
                                                      chooselocation.State>(
                                                    value: value,
                                                    child: Text(value.stateName!
                                                        .toString()),
                                                  ))
                                          .toList(),

                                      // add extra sugar..
                                      icon: Icon(Icons.arrow_drop_down),
                                      iconSize: 42,
                                      underline: SizedBox(),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 16,
                              ),
                              val.state == ""
                                  ? SizedBox()
                                  : Container(
                                      height: 48,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          // color: Colors.grey.shade300,
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      // color: Colors.grey.shade300,
                                      // dropdown below..
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Select City"),
                                          DropdownButton<chooselocation.City>(
                                            // value:val.City==""? val
                                            //     .masterModel!.response!.City!.first:val.City,
                                            hint: Text(val.city),
                                            onChanged: (newValue) =>
                                                val.updateCity(
                                                    newValue!.cityName!),
                                            items: val
                                                .masterModel!.response!.city!
                                                .map<
                                                    DropdownMenuItem<
                                                        chooselocation
                                                        .City>>((value) =>
                                                    DropdownMenuItem<
                                                        chooselocation.City>(
                                                      value: value,
                                                      child: Text(value
                                                          .cityName!
                                                          .toString()),
                                                    ))
                                                .toList(),

                                            // add extra sugar..
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 42,
                                            underline: SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),

                              SizedBox(
                                height: 16,
                              ),
                              val.city == ""
                                  ? SizedBox()
                                  : Container(
                                      height: 48,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                          // color: Colors.grey.shade300,
                                          border: Border.all(
                                              color: Colors.grey.shade300),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      // color: Colors.grey.shade300,
                                      // dropdown below..
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Select PinCode"),
                                          DropdownButton<
                                              chooselocation.Pincode>(
                                            // value:val.state==""? val
                                            //     .masterModel!.response!.state!.first:val.state,
                                            hint: Text(val.pinCode),
                                            onChanged: (newValue) => val
                                                .updatePin(newValue!.pincode!),
                                            items: val
                                                .masterModel!.response!.pincode!
                                                .map<
                                                    DropdownMenuItem<
                                                        chooselocation
                                                        .Pincode>>((value) =>
                                                    DropdownMenuItem<
                                                        chooselocation.Pincode>(
                                                      value: value,
                                                      child: Text(value.pincode!
                                                          .toString()),
                                                    ))
                                                .toList(),

                                            // add extra sugar..
                                            icon: Icon(Icons.arrow_drop_down),
                                            iconSize: 42,
                                            underline: SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),

                              SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Aadress"),
                                  SizedBox(
                                    // height: 48,
                                    child: TextFormField(
                                      maxLines: 4,
                                      controller: val.address1,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) =>
                                          ValidateAll.inputValidate(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding: EdgeInsets.only(
                                            left: 15, right: 5, top: 15),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Enter Primary Address",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Aadhar no"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.ahdarno,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(12),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (input) =>
                                          ValidateAll.validateAadhar(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Phone No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Aadhar Number",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Aadhar font"),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Document_Upload(
                                                  fileName: "Aadhar Card Font",
                                                ))),
                                    child: Container(
                                      height: 48,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          border:
                                              Border.all(color: Colors.black38),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: val.frontimg != null
                                          ? Text("${val.frontimg!.path}")
                                          : const Text(
                                              "Upload Aadhar front Image"),
                                    ),
                                  )
                                  // SizedBox(
                                  //   height: 200,
                                  //   child: Row(
                                  //     children: [
                                  //       Expanded(
                                  //           child: Container(
                                  //         alignment: Alignment.center,
                                  //         decoration: BoxDecoration(
                                  //             borderRadius: BorderRadius.circular(23),
                                  //             color: Colors.amber[50]),
                                  //         child: file1 != null
                                  //             ? Container(
                                  //                 margin: EdgeInsets.only(
                                  //                     left: 24, right: 24),
                                  //                 height: 250,
                                  //                 child:
                                  //                     const PDF().fromPath(file1 ?? ""),
                                  //               )
                                  //             : Icon(
                                  //                 Icons.image,
                                  //                 size: 50,
                                  //                 color: Colors.grey.shade300,
                                  //               ),
                                  //       )),
                                  //       Expanded(
                                  //           child: Column(
                                  //         mainAxisAlignment: MainAxisAlignment.center,
                                  //         crossAxisAlignment: CrossAxisAlignment.center,
                                  //         children: [
                                  //           ElevatedButton(
                                  //               style: ButtonStyle(
                                  //                   backgroundColor:
                                  //                       MaterialStatePropertyAll(
                                  //                           Colors.red.shade200)),
                                  //               onPressed: () => insertVechicle(),
                                  //               child: Text("Remove")),
                                  //           SizedBox(
                                  //             height: 10,
                                  //           ),
                                  //           ElevatedButton.icon(
                                  //               style: ButtonStyle(
                                  //                   backgroundColor:
                                  //                       MaterialStatePropertyAll(
                                  //                           Colors.amber.shade200)),
                                  //               onPressed: () => insertVechicle(),
                                  //               icon: Icon(Icons.picture_as_pdf),
                                  //               label: Text("Insert PDF"))
                                  //         ],
                                  //       ))
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Aadhar back"),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Document_Upload(
                                                    fileName:
                                                        "Aadhar Card Back"))),
                                    child: Container(
                                      height: 48,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          border:
                                              Border.all(color: Colors.black38),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: val.backimg != null
                                          ? Text("${val.backimg!.path}")
                                          : Text("Upload Aadhar back image"),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Year of Exprience"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.exp_year,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(3),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (input) =>
                                          ValidateAll.inputValidate(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle: Theme.of(context)
                                        //     .textTheme
                                        //     .bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter email"),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Experience Year",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),

                        // ,Text(
                        //   "Document Details",
                        //   style: Theme.of(context).textTheme.bodyLarge,
                        // ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Licence Detais"),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              //select type of cab by choosing option
                              // Container(
                              //   height: 48,
                              //   padding:
                              //       EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              //   decoration: BoxDecoration(
                              //       // color: Colors.grey.shade300,
                              //       border: Border.all(color: Colors.grey.shade300),
                              //       borderRadius: BorderRadius.circular(10)),
                              //   // color: Colors.grey.shade300,
                              //   // dropdown below..
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Text("Vechicle type"),
                              //       DropdownButton<String>(
                              //         value: selectedValue,
                              //         onChanged: (newValue) =>
                              //             setState(() => selectedValue = newValue!),
                              //         items: items
                              //             .map<DropdownMenuItem<String>>(
                              //                 (String value) =>
                              //                     DropdownMenuItem<String>(
                              //                       value: value,
                              //                       child: Text(value),
                              //                     ))
                              //             .toList(),

                              //         // add extra sugar..
                              //         icon: Icon(Icons.arrow_drop_down),
                              //         iconSize: 42,
                              //         underline: SizedBox(),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 16,
                              // ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Licence Number"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.license_no,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) =>
                                          ValidateAll.inputValidate(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle:
                                        //     Theme.of(context).textTheme.bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Vechicle No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "License Number",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("upload licence"),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Document_Upload(
                                                  fileName: "Licence",
                                                ))),
                                    child: Container(
                                      height: 48,
                                      width: double.infinity,
                                      padding: EdgeInsets.only(left: 15),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade200,
                                          border:
                                              Border.all(color: Colors.black38),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: val.license_img != null
                                          ? Text("${val.license_img!.path}")
                                          : Text("Upload Licence image"),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Bank Account Detais"),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Bank Holder Full name"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.ac_name,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) =>
                                          ValidateAll.inputValidate(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle:
                                        //     Theme.of(context).textTheme.bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Vechicle No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Name",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Bank Account No."),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.acc_no,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        LengthLimitingTextInputFormatter(20),
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (input) => Validate(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle:
                                        //     Theme.of(context).textTheme.bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Vechicle No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Account Number",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter Bank Name"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.bank_name,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) =>
                                          ValidateAll.inputValidate(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle:
                                        //     Theme.of(context).textTheme.bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Vechicle No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "Bank Name",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Enter BANK IFSC Code"),
                                  SizedBox(
                                    height: 48,
                                    child: TextFormField(
                                      maxLines: 1,
                                      controller: val.ifsc,
                                      keyboardType: TextInputType.emailAddress,
                                      validator: (input) =>
                                          ValidateAll.inputValidate(input),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      ),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        filled: true,
                                        errorStyle: TextStyle(fontSize: 0),
                                        contentPadding:
                                            EdgeInsets.only(left: 15, right: 5),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors.amber, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade200, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // labelStyle:
                                        //     Theme.of(context).textTheme.bodyMedium,
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey.shade100, // Border color
                                            width: 2.0, // Border width
                                          ),
                                        ),
                                        // enabled: true,
                                        // label: Text("Enter Vechicle No."),
                                        // floatingLabelAlignment:
                                        //     FloatingLabelAlignment.start,
                                        hintText: "IFSC Code number",
                                        // suffixIcon: Container(
                                        //   height: 40,
                                        //   color: Colors.amber,
                                        //   alignment: null,
                                        //   child: Text("Choose Location"),
                                        // ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }));
  }
}
