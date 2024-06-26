// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:feranta_franchise/view_model/resister/all_resister_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../../configs/app_url.dart';
import '../../../../model/past_record/all_record_model.dart';
import '../../../../static/color.dart';
import '../../../../static/flutter_toast_message/toast_messge.dart';
import '../../../../static/validator/all_textfield_validator.dart';
import '../upload_document.dart';
import 'package:feranta_franchise/model/resister/master_model.dart'
    as chooselocation;

class OwnerResisterPage extends StatefulWidget {
  UserList? ownerDetails;
  OwnerResisterPage({this.ownerDetails, super.key});

  @override
  State<OwnerResisterPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<OwnerResisterPage> {
  GlobalKey<FormState> formKey = new GlobalKey();

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
      if (widget.ownerDetails != null) {
        Provider.of<ResisterViewmodel>(context, listen: false)
          ..isLoading = false
          ..clearownerResistationForm()
          ..initOwnerallfield(widget.ownerDetails!);
      }
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
      ..clearownerResistationForm();
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
                ..clearownerResistationForm();
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Owner ${widget.ownerDetails != null ? "Update" : "Registration"} Form",
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
                    if (widget.ownerDetails != null) {
                      await loginD.updateownerRegisterViewmodel(
                          context, widget.ownerDetails!.id, true);
                    } else if (loginD.termsCheck &&
                        loginD.criminalCheck &&
                        loginD.frontimg != null &&
                        loginD.backimg != null &&
                        loginD.img != null &&
                        loginD.city != "") {
                      await loginD.ownerRegister(context);
                    } else {
                      ShowToast(
                          msg:
                              "give logo, Aadhar Front,Aadhar Back, City, also Check Criminal Record And Terms First before submit");
                    }
                  }
                  // } else {
                  //   null;
                  // }
                },
                child: loginD.isLoading
                    ? CircularProgressIndicator()
                    : Text(
                        "${widget.ownerDetails != null ? "update" : "Registration"}"));
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
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            children: [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Personal Details",
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  )),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colo.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 2)
                                    ],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Enter Logo"),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 12,
                                          color: Colors.red,
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 100,
                                      width: 100,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Stack(
                                        children: [
                                          val.img != null
                                              ? Container(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              23),
                                                      color: Colors.amber[50],
                                                      image: DecorationImage(
                                                          image: FileImage(
                                                              val.img!),
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
                                                          BorderRadius.circular(
                                                              23),
                                                      color: Colors.amber[50],
                                                      image: DecorationImage(
                                                          image: CachedNetworkImageProvider(
                                                              "${AppUrl.imageUrl}${val.img_update}"))),
                                                  // child: Icon(
                                                  //   Icons
                                                  //       .account_circle_outlined,
                                                  //   size: 50,
                                                  //   color: Colors.grey.shade300,
                                                  // ),
                                                ),
                                          Positioned(
                                              bottom: 10,
                                              right: 0,
                                              child: InkWell(
                                                onTap: () =>
                                                    val.insertLogo(context),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Enter Name"),
                                            Icon(
                                              Icons.star,
                                              color: Colors.red,
                                              size: 12,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.name,
                                            keyboardType: TextInputType.text,
                                            validator: (value) =>
                                                ValidateAll.inputValidate(
                                                    value),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text("Enter Email"),
                                            // Icon(
                                            //   Icons.star,
                                            //   color: Colors.red,
                                            //   size: 12,
                                            // )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.email,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            // validator: (input) =>
                                            //     ValidateAll.validateEmail(
                                            //         input),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Enter Phone Nuber"),
                                            Icon(
                                              Icons.star,
                                              color: Colors.red,
                                              size: 12,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.contact,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter Phone No."),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "Mobile Number",
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
                                    // Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text("Enter Password"),
                                    //     SizedBox(
                                    //       height: 48,
                                    //       child: TextFormField(
                                    //         maxLines: 1,
                                    //         controller: val.resister_password,
                                    //         keyboardType: TextInputType.text,
                                    //         // validator: (input) =>
                                    //         //     ValidateAll.inputValidate(input),
                                    //         style: TextStyle(
                                    //           color: Colors.black,
                                    //           fontSize: 12,
                                    //         ),
                                    //         decoration: InputDecoration(
                                    //           fillColor: Colors.grey.shade200,
                                    //           filled: true,
                                    //           errorStyle:
                                    //               TextStyle(fontSize: 0),
                                    //           contentPadding: EdgeInsets.only(
                                    //               left: 15, right: 5),
                                    //           focusedBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors
                                    //                   .amber, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           enabledBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade200, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           // labelStyle: Theme.of(context)
                                    //           //     .textTheme
                                    //           //     .bodyMedium,
                                    //           disabledBorder:
                                    //               OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade100, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           border: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade100, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           // enabled: true,
                                    //           // label: Text("Enter Phone No."),
                                    //           // floatingLabelAlignment:
                                    //           //     FloatingLabelAlignment.start,
                                    //           hintText: "password",
                                    //           // suffixIcon: Container(
                                    //           //   height: 40,
                                    //           //   color: Colors.amber,
                                    //           //   alignment: null,
                                    //           //   child: Text("Choose Location"),
                                    //           // ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),

                                    // SizedBox(
                                    //   height: 16,
                                    // ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                            "Enter Alternate Phone number"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.altcontact,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter Phone No."),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "Mobile Number",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter Date Of Birth"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.dobController,
                                            keyboardType: TextInputType.number,
                                            readOnly: true,
                                            // validator: (input) =>
                                            //     ValidateAll.validateMobile(
                                            //         input),
                                            // inputFormatters: <TextInputFormatter>[
                                            //   LengthLimitingTextInputFormatter(
                                            //       10),
                                            //   FilteringTextInputFormatter
                                            //       .digitsOnly,
                                            // ],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter Phone No."),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "Select DateOf Birth",
                                              suffixIcon: InkWell(
                                                  onTap: () =>
                                                      val.selectDate(context),
                                                  child: Icon(
                                                      Icons.calendar_month)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter Father Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.father_name,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter email"),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "Father Name",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter Mother Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.mother_name,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter email"),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "Mother Name",
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Radio<int>(
                                                value: 1,
                                                groupValue: val
                                                    .married_type, // val.married_type,
                                                onChanged: (int? value) => val
                                                    .updateMariedType(value!),
                                              ),
                                              Text('Married')
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Radio<int>(
                                                value: 2,
                                                groupValue: val
                                                    .married_type, // val.married_type,
                                                onChanged: (int? value) => val
                                                    .updateMariedType(value!),
                                              ),
                                              Text('Unmarried')
                                            ],
                                          ),
                                        )

                                        // Add more options here
                                      ],
                                    ),
                                    val.married_type == 1
                                        ? SizedBox(
                                            height: 16,
                                          )
                                        : SizedBox(),
                                    val.married_type == 1
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Enter Wife/Spouse Name"),
                                              SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller: val.wife_name,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  // validator: (input) =>
                                                  //     ValidateAll.inputValidate(input),
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle:
                                                        TextStyle(fontSize: 0),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .amber, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade200, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // labelStyle:
                                                    //     Theme.of(context).textTheme.bodyMedium,
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // enabled: true,
                                                    // label: Text("Enter Vechicle No."),
                                                    // floatingLabelAlignment:
                                                    //     FloatingLabelAlignment.start,
                                                    hintText:
                                                        "Wife/Spouse Name",
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
                                          )
                                        : SizedBox(),
                                    val.married_type == 1
                                        ? SizedBox(
                                            height: 16,
                                          )
                                        : SizedBox(),

                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter Aadress"),
                                        SizedBox(
                                          // height: ,
                                          child: TextFormField(
                                            maxLines: 4,
                                            controller: val.address1,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5, top: 15),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter Phone No."),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "Present Address",
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
                                          Text("Select State"),
                                          DropdownButton<chooselocation.State>(
                                            // value:val.state==""? val
                                            //     .masterModel!.response!.state!.first:val.state,
                                            hint: Text(val.state),
                                            onChanged: (newValue) =>
                                                val.updateSttate(newValue!),
                                            items: val
                                                .masterModel!.response!.state!
                                                .map<
                                                    DropdownMenuItem<
                                                        chooselocation
                                                        .State>>((value) =>
                                                    DropdownMenuItem<
                                                        chooselocation.State>(
                                                      value: value,
                                                      child: Text(value
                                                          .stateName!
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter City"),
                                        Icon(
                                          Icons.star,
                                          size: 12,
                                          color: Colors.red,
                                        )
                                      ],
                                    ),
                                    Container(
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
                                            onChanged: (newValue) => val
                                                        .state ==
                                                    ""
                                                ? ShowToast(
                                                    msg: "First Select State")
                                                : val.updateCity(newValue!),
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
                                    Container(
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
                                          Text("Select District"),
                                          DropdownButton<
                                              chooselocation.Districts>(
                                            // value:val.state==""? val
                                            //     .masterModel!.response!.state!.first:val.state,
                                            hint: Text(val.ditrict),
                                            onChanged: (newValue) => val.city ==
                                                    ""
                                                ? ShowToast(
                                                    msg: "First Select City")
                                                : val.updateDistrict(newValue!),
                                            items: val.masterModel!.response!
                                                .districts!
                                                .map<
                                                    DropdownMenuItem<
                                                        chooselocation
                                                        .Districts>>((value) =>
                                                    DropdownMenuItem<
                                                        chooselocation
                                                        .Districts>(
                                                      value: value,
                                                      child: Text(value
                                                          .districtName!
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

                                    Container(
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
                                          Text("Select Block"),
                                          DropdownButton<chooselocation.Blocks>(
                                            // value:val.City==""? val
                                            //     .masterModel!.response!.City!.first:val.City,
                                            hint: Text(val.block),
                                            onChanged: (newValue) => val
                                                        .ditrict ==
                                                    ""
                                                ? ShowToast(
                                                    msg:
                                                        "First Select District")
                                                : val.updateBlock(newValue!),
                                            items: val
                                                .masterModel!.response!.blocks!
                                                .map<
                                                    DropdownMenuItem<
                                                        chooselocation
                                                        .Blocks>>((value) =>
                                                    DropdownMenuItem<
                                                        chooselocation.Blocks>(
                                                      value: value,
                                                      child: Text(value
                                                          .blockName!
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
                                    val.block == ""
                                        ? SizedBox()
                                        : SizedBox(
                                            height: 16,
                                          ),

                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter Village Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.villageName,
                                            keyboardType: TextInputType.text,

                                            // inputFormatters: <TextInputFormatter>[
                                            //   LengthLimitingTextInputFormatter(
                                            //       6),
                                            //   FilteringTextInputFormatter
                                            //       .digitsOnly,
                                            // ],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter Phone No."),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "Village Name",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter PinCode Number"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.pincode,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  6),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter Phone No."),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "PinCode Number",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Enter Aadhar no"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 12,
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.ahdarno,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  12),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            validator: (input) =>
                                                ValidateAll.validateAadhar(
                                                    input),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle: Theme.of(context)
                                              //     .textTheme
                                              //     .bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Enter Aadhar font"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 12,
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Document_Upload(
                                                        fileName:
                                                            "Aadhar Card Font",
                                                      ))),
                                          child: Container(
                                            height: 48,
                                            width: double.infinity,
                                            padding: EdgeInsets.only(left: 15),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                border: Border.all(
                                                    color: Colors.black38),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: val.frontimg != null
                                                ? Text("${val.frontimg!.path}")
                                                : val.frontimg_update != null
                                                    ? Text(
                                                        "${val.frontimg_update!}")
                                                    : Text(
                                                        "Upload Aadhar front"),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text("Enter Aadhar back"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: 12,
                                              color: Colors.red,
                                            )
                                          ],
                                        ),
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
                                                border: Border.all(
                                                    color: Colors.black38),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: val.backimg != null
                                                ? Text("${val.backimg!.path}")
                                                : val.backimg_update != null
                                                    ? Text(
                                                        "${val.backimg_update}")
                                                    : Text(
                                                        "Upload Aadhar back"),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
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
                                          const Text("Select Blood Group"),
                                          DropdownButton<
                                              chooselocation.BloodGroup>(
                                            // value:val.state==""? val
                                            //     .masterModel!.response!.state!.first:val.state,
                                            hint: Text(val.blood_group),
                                            onChanged: (newValue) =>
                                                val.updateBloodGrup(newValue!),
                                            items: val.masterModel!.response!
                                                .bloodGroup!
                                                .map<
                                                    DropdownMenuItem<
                                                        chooselocation
                                                        .BloodGroup>>((value) =>
                                                    DropdownMenuItem<
                                                        chooselocation
                                                        .BloodGroup>(
                                                      value: value,
                                                      child: Text(value
                                                          .bloodGroup
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Vechicle Detais",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colo.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 2)
                                    ],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Select Role"),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade200,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Checkbox(
                                                value: val.isCheck,
                                                onChanged: (value) =>
                                                    val.ischeckUpdate(value!),
                                              ),
                                              SizedBox(width: 10),
                                              Text(
                                                'Are you work as a driver',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    val.isCheck
                                        ? SizedBox(height: 16)
                                        : SizedBox(),
                                    val.isCheck
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      "Enter Driving Licence Number"),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 12,
                                                    color: Colors.red,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller: val.license_no,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle:
                                                        TextStyle(fontSize: 0),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .amber, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade200, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // labelStyle:
                                                    //     Theme.of(context).textTheme.bodyMedium,
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // enabled: true,
                                                    // label: Text("Enter Vechicle No."),
                                                    // floatingLabelAlignment:
                                                    //     FloatingLabelAlignment.start,
                                                    hintText:
                                                        "Driving License Number",
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
                                          )
                                        : SizedBox(),
                                    val.isCheck
                                        ? SizedBox(
                                            height: 16,
                                          )
                                        : SizedBox(),
                                    val.isCheck
                                        ? Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "Upload Driving licence"),
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
                                                              fileName:
                                                                  "Licence",
                                                            ))),
                                                child: Container(
                                                  height: 48,
                                                  width: double.infinity,
                                                  padding:
                                                      EdgeInsets.only(left: 15),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          Colors.grey.shade200,
                                                      border: Border.all(
                                                          color:
                                                              Colors.black38),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: val.license_img != null
                                                      ? Text(
                                                          "${val.license_img!.path}")
                                                      : val.license_img_update !=
                                                              null
                                                          ? Text(
                                                              "${val.license_img_update!}")
                                                          : Text(
                                                              "Upload Driving Licence image"),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                    val.isCheck
                                        ? SizedBox(
                                            height: 16,
                                          )
                                        : SizedBox(),
                                    val.isCheck
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Enter Driving Year of Exprience"),
                                              SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller: val.exp_year,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: <TextInputFormatter>[
                                                    LengthLimitingTextInputFormatter(
                                                        3),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle:
                                                        TextStyle(fontSize: 0),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .amber, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade200, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // labelStyle: Theme.of(context)
                                                    //     .textTheme
                                                    //     .bodyMedium,
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
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
                                          )
                                        : SizedBox(),

                                    val.isCheck
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                      "Enter Driving License Expiry Date"),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 12,
                                                    color: Colors.red,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller: val
                                                      .drivingExpiryController,
                                                  // keyboardType: TextInputType.number,
                                                  readOnly: true,
                                                  // validator: (input) =>
                                                  //     ValidateAll.validateMobile(
                                                  //         input),
                                                  // inputFormatters: <TextInputFormatter>[
                                                  //   LengthLimitingTextInputFormatter(
                                                  //       10),
                                                  //   FilteringTextInputFormatter
                                                  //       .digitsOnly,
                                                  // ],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle:
                                                        TextStyle(fontSize: 0),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .amber, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade200, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // labelStyle: Theme.of(context)
                                                    //     .textTheme
                                                    //     .bodyMedium,
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // enabled: true,
                                                    // label: Text("Enter Phone No."),
                                                    // floatingLabelAlignment:
                                                    //     FloatingLabelAlignment.start,
                                                    hintText:
                                                        "Driving License Expiry Date",
                                                    suffixIcon: InkWell(
                                                        onTap: () => val
                                                            .driverLicenseExpiry(
                                                                context),
                                                        child: Icon(Icons
                                                            .calendar_month)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : SizedBox(),
                                    SizedBox(
                                      height: 16,
                                    ),

                                    //  Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     const Text("Enter Engine Number"),
                                    //     SizedBox(
                                    //       height: 48,
                                    //       child: TextFormField(
                                    //         maxLines: 1,
                                    //         controller: val.engineNumberField,
                                    //         keyboardType:
                                    //             TextInputType.emailAddress,
                                    //         validator: (input) =>
                                    //             ValidateAll.inputValidate(
                                    //                 input),
                                    //         style: TextStyle(
                                    //           color: Colors.black,
                                    //           fontSize: 12,
                                    //         ),
                                    //         decoration: InputDecoration(
                                    //           fillColor: Colors.grey.shade200,
                                    //           filled: true,
                                    //           errorStyle:
                                    //               TextStyle(fontSize: 0),
                                    //           contentPadding: EdgeInsets.only(
                                    //               left: 15, right: 5),
                                    //           focusedBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors
                                    //                   .amber, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           enabledBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade200, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           // labelStyle:
                                    //           //     Theme.of(context).textTheme.bodyMedium,
                                    //           disabledBorder:
                                    //               OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade100, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           border: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade100, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           // enabled: true,
                                    //           // label: Text("Enter Vechicle No."),
                                    //           // floatingLabelAlignment:
                                    //           //     FloatingLabelAlignment.start,
                                    //           hintText:
                                    //               "Engine Number",
                                    //           // suffixIcon: Container(
                                    //           //   height: 40,
                                    //           //   color: Colors.amber,
                                    //           //   alignment: null,
                                    //           //   child: Text("Choose Location"),
                                    //           // ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 16,
                                    // ),
                                    //  Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text("Enter RC Number"),
                                    //     SizedBox(
                                    //       height: 48,
                                    //       child: TextFormField(
                                    //         maxLines: 1,
                                    //         controller: val.rcNumberField,
                                    //         keyboardType:
                                    //             TextInputType.emailAddress,
                                    //         validator: (input) =>
                                    //             ValidateAll.inputValidate(
                                    //                 input),
                                    //         style: TextStyle(
                                    //           color: Colors.black,
                                    //           fontSize: 12,
                                    //         ),
                                    //         decoration: InputDecoration(
                                    //           fillColor: Colors.grey.shade200,
                                    //           filled: true,
                                    //           errorStyle:
                                    //               TextStyle(fontSize: 0),
                                    //           contentPadding: EdgeInsets.only(
                                    //               left: 15, right: 5),
                                    //           focusedBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors
                                    //                   .amber, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           enabledBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade200, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           // labelStyle:
                                    //           //     Theme.of(context).textTheme.bodyMedium,
                                    //           disabledBorder:
                                    //               OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade100, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           border: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade100, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           // enabled: true,
                                    //           // label: Text("Enter Vechicle No."),
                                    //           // floatingLabelAlignment:
                                    //           //     FloatingLabelAlignment.start,
                                    //           hintText:
                                    //               "RC Number",
                                    //           // suffixIcon: Container(
                                    //           //   height: 40,
                                    //           //   color: Colors.amber,
                                    //           //   alignment: null,
                                    //           //   child: Text("Choose Location"),
                                    //           // ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 16,
                                    // ),
                                    //  Column(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.start,
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: [
                                    //     Text("Enter Driving Licence Number"),
                                    //     SizedBox(
                                    //       height: 48,
                                    //       child: TextFormField(
                                    //         maxLines: 1,
                                    //         controller: val.license_no,
                                    //         keyboardType:
                                    //             TextInputType.emailAddress,
                                    //         validator: (input) =>
                                    //             ValidateAll.inputValidate(
                                    //                 input),
                                    //         style: TextStyle(
                                    //           color: Colors.black,
                                    //           fontSize: 12,
                                    //         ),
                                    //         decoration: InputDecoration(
                                    //           fillColor: Colors.grey.shade200,
                                    //           filled: true,
                                    //           errorStyle:
                                    //               TextStyle(fontSize: 0),
                                    //           contentPadding: EdgeInsets.only(
                                    //               left: 15, right: 5),
                                    //           focusedBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors
                                    //                   .amber, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           enabledBorder: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade200, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           // labelStyle:
                                    //           //     Theme.of(context).textTheme.bodyMedium,
                                    //           disabledBorder:
                                    //               OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade100, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           border: OutlineInputBorder(
                                    //             borderRadius:
                                    //                 BorderRadius.circular(10.0),
                                    //             borderSide: BorderSide(
                                    //               color: Colors.grey
                                    //                   .shade100, // Border color
                                    //               width: 2.0, // Border width
                                    //             ),
                                    //           ),
                                    //           // enabled: true,
                                    //           // label: Text("Enter Vechicle No."),
                                    //           // floatingLabelAlignment:
                                    //           //     FloatingLabelAlignment.start,
                                    //           hintText:
                                    //               "Insurance Number",
                                    //           // suffixIcon: Container(
                                    //           //   height: 40,
                                    //           //   color: Colors.amber,
                                    //           //   alignment: null,
                                    //           //   child: Text("Choose Location"),
                                    //           // ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    // SizedBox(
                                    //   height: 16,
                                    // ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Bank Details",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colo.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black26, blurRadius: 2)
                                    ],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter Bank Account Holder Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.ac_name,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle:
                                              //     Theme.of(context).textTheme.bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter Bank Account Number"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.acc_no,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  20),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle:
                                              //     Theme.of(context).textTheme.bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter Vechicle No."),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "Bank Account Number",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter Bank Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.bank_name,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle:
                                              //     Theme.of(context).textTheme.bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter Bank Branch Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.branch_name,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle:
                                              //     Theme.of(context).textTheme.bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter Vechicle No."),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "Branch Name",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Enter BANK IFSC Code"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.ifsc,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  TextStyle(fontSize: 0),
                                              contentPadding: EdgeInsets.only(
                                                  left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors
                                                      .amber, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade200, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // labelStyle:
                                              //     Theme.of(context).textTheme.bodyMedium,
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: BorderSide(
                                                  color: Colors.grey
                                                      .shade100, // Border color
                                                  width: 2.0, // Border width
                                                ),
                                              ),
                                              // enabled: true,
                                              // label: Text("Enter Vechicle No."),
                                              // floatingLabelAlignment:
                                              //     FloatingLabelAlignment.start,
                                              hintText: "IFSC Code",
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
                            ],
                          ),
                        ),
                        val.isCheck
                            ? Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Pension Detail",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colo.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 2)
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Column(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("Enter Nominee Name"),
                                              SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller: val.nomineeName,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle:
                                                        TextStyle(fontSize: 0),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .amber, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade200, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // labelStyle:
                                                    //     Theme.of(context).textTheme.bodyMedium,
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // enabled: true,
                                                    // label: Text("Enter Vechicle No."),
                                                    // floatingLabelAlignment:
                                                    //     FloatingLabelAlignment.start,
                                                    hintText: "Nominee Name",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Enter Relationship With The Nominator"),
                                              SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller:
                                                      val.nomineeRelationship,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle:
                                                        TextStyle(fontSize: 0),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .amber, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade200, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // labelStyle:
                                                    //     Theme.of(context).textTheme.bodyMedium,
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // enabled: true,
                                                    // label: Text("Enter Vechicle No."),
                                                    // floatingLabelAlignment:
                                                    //     FloatingLabelAlignment.start,
                                                    hintText: "Relatinship",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Enter Permanent Address Of Nominator"),
                                              SizedBox(
                                                // height: 48,
                                                child: TextFormField(
                                                  maxLines: 4,
                                                  controller:
                                                      val.nomineeAddress,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle:
                                                        TextStyle(fontSize: 0),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .amber, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade200, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // labelStyle:
                                                    //     Theme.of(context).textTheme.bodyMedium,
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // enabled: true,
                                                    // label: Text("Enter Vechicle No."),
                                                    // floatingLabelAlignment:
                                                    //     FloatingLabelAlignment.start,
                                                    hintText:
                                                        "Permanent Address",
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Enter Date Of Birth Of Nominator"),
                                              SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller:
                                                      val.dobNomineeController,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  readOnly: true,
                                                  // validator: (input) =>
                                                  //     ValidateAll.validateMobile(
                                                  //         input),
                                                  // inputFormatters: <TextInputFormatter>[
                                                  //   LengthLimitingTextInputFormatter(
                                                  //       10),
                                                  //   FilteringTextInputFormatter
                                                  //       .digitsOnly,
                                                  // ],
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle:
                                                        TextStyle(fontSize: 0),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors
                                                            .amber, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade200, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // labelStyle: Theme.of(context)
                                                    //     .textTheme
                                                    //     .bodyMedium,
                                                    disabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide: BorderSide(
                                                        color: Colors.grey
                                                            .shade100, // Border color
                                                        width:
                                                            2.0, // Border width
                                                      ),
                                                    ),
                                                    // enabled: true,
                                                    // label: Text("Enter Phone No."),
                                                    // floatingLabelAlignment:
                                                    //     FloatingLabelAlignment.start,
                                                    hintText:
                                                        "Select Date Of Birth Nominee",
                                                    suffixIcon: InkWell(
                                                        onTap: () => val
                                                            .selectNomineeBirth(
                                                                context),
                                                        child: Icon(Icons
                                                            .calendar_month)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                value: val.termsCheck,
                                onChanged: (value) => val.updateTerms(value!),
                              ),
                              SizedBox(width: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'All term & condition',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  TextButton(
                                      onPressed: () => context.push('/web',
                                              extra: {
                                                'id': '2',
                                                'url': AppUrl.ferantaTerms
                                              }),
                                      child: Text(
                                        "Read More",
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 12,
                                            decoration:
                                                TextDecoration.underline),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Checkbox(
                                value: val.criminalCheck,
                                onChanged: (value) =>
                                    val.updateCriminal(value!),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'No criminal record',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
        }));
  }
}
