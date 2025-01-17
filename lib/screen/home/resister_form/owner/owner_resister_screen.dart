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
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            "Owner ${widget.ownerDetails != null ? "Update" : "Registration"} Form",
            style: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
                        loginD.city != "") {
                      await loginD.ownerRegister(context);
                    } else {
                      ShowToast(
                          msg:
                              "give logo, Aadhaar Front,Aadhaar Back, City, also Check Criminal Record And Terms First before submit");
                    }
                  }
                  // } else {
                  //   null;
                  // }
                },
                child: loginD.isLoading
                    ? const CircularProgressIndicator()
                    : Text(
                        "${widget.ownerDetails != null ? "update" : "Register"}"));
          }),
        ),
        body: Consumer<ResisterViewmodel>(builder: (context, val, _) {
          return val.masterModel == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: ListView(
                      shrinkWrap: true,
                      primary: true,
                      // physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        const SizedBox(
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
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colo.white,
                                    boxShadow: [
                                      const BoxShadow(
                                          color: Colors.black26, blurRadius: 2)
                                    ],
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(" Upload Profile Pic"),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        // Icon(
                                        //   Icons.star,
                                        //   size: 12,
                                        //   color: Colors.red,
                                        // )
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
                                                child: const Material(
                                                  color: Colors.white,
                                                  child: Icon(
                                                    Icons.edit,
                                                    size: 25,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
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
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
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
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Text("Enter Phone Number"),
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
                                            validator: (value) =>
                                                ValidateAll.validateMobile(
                                                    value),
                                            inputFormatters: <TextInputFormatter>[
                                              LengthLimitingTextInputFormatter(
                                                  10),
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
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
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter Date Of Birth"),
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
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                              hintText: "Select Date Of Birth",
                                              suffixIcon: InkWell(
                                                  onTap: () =>
                                                      val.selectDate(context),
                                                  child: const Icon(
                                                      Icons.calendar_month)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter Father Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.father_name,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter Mother Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.mother_name,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
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
                                              const Text('Married')
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
                                              const Text('Unmarried')
                                            ],
                                          ),
                                        )

                                        // Add more options here
                                      ],
                                    ),
                                    val.married_type == 1
                                        ? const SizedBox(
                                            height: 16,
                                          )
                                        : const SizedBox(),
                                    val.married_type == 1
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                  "Enter Wife/Spouse Name"),
                                              SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller: val.wife_name,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  // validator: (input) =>
                                                  //     ValidateAll.inputValidate(input),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle: const TextStyle(
                                                        fontSize: 0),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
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
                                        : const SizedBox(),
                                    val.married_type == 1
                                        ? const SizedBox(
                                            height: 16,
                                          )
                                        : const SizedBox(),

                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter Address"),
                                        SizedBox(
                                          // height: ,
                                          child: TextFormField(
                                            maxLines: 4,
                                            controller: val.address1,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15,
                                                      right: 5,
                                                      top: 15),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    // select type of cab by choosing option
                                    Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(
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
                                          Row(children: [
                                            const Text("Select State"),
                                            Icon(
                                              Icons.star,
                                              color: Colors.red,
                                              size: 12,
                                            )
                                          ]),
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
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: 42,
                                            underline: const SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Row(
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
                                      padding: const EdgeInsets.symmetric(
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
                                          const Text("Select City"),
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
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: 42,
                                            underline: const SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(
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
                                          const Text("Select District"),
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
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: 42,
                                            underline: const SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),

                                    Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(
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
                                          const Text("Select Block"),
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
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: 42,
                                            underline: const SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    val.block == ""
                                        ? const SizedBox()
                                        : const SizedBox(
                                            height: 16,
                                          ),

                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter Village Name"),
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
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter Pin Code Number"),
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
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),

                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Text("Enter Aadhaar Number"),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            // Icon(
                                            //   Icons.star,
                                            //   size: 12,
                                            //   color: Colors.red,
                                            // )
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
                                            // validator: (input) =>
                                            //     ValidateAll.validateAadhar(
                                            //         input),
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                              hintText: "Aadhaar Number",
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
                                    const SizedBox(
                                      height: 16,
                                    ),

                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Text("Enter Aadhaar Front Side"),
                                            // SizedBox(
                                            //   width: 5,
                                            // ),
                                            // Icon(
                                            //   Icons.star,
                                            //   size: 12,
                                            //   color: Colors.red,
                                            // )
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
                                            padding:
                                                const EdgeInsets.only(left: 15),
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
                                                    : const Text(
                                                        "Upload Aadhaar Front Side"),
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Row(
                                          children: [
                                            Text("Enter Aadhaar Back Side"),
                                            // SizedBox(
                                            //   width: 5,
                                            // ),
                                            // Icon(
                                            //   Icons.star,
                                            //   size: 12,
                                            //   color: Colors.red,
                                            // )
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
                                            padding:
                                                const EdgeInsets.only(left: 15),
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
                                                    : const Text(
                                                        "Upload Aadhaar Back Side"),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      height: 48,
                                      padding: const EdgeInsets.symmetric(
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
                                            icon: const Icon(
                                                Icons.arrow_drop_down),
                                            iconSize: 42,
                                            underline: const SizedBox(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Driver Details",
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colo.white,
                                    boxShadow: [
                                      const BoxShadow(
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
                                        const Text("Select Role"),
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
                                              const SizedBox(width: 10),
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
                                        ? const SizedBox(height: 16)
                                        : const SizedBox(),
                                    val.isCheck
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Row(
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
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle: const TextStyle(
                                                        fontSize: 0),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
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
                                                        "Driving Licence Number",
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
                                        : const SizedBox(),
                                    val.isCheck
                                        ? const SizedBox(
                                            height: 16,
                                          )
                                        : const SizedBox(),
                                    val.isCheck
                                        ? Column(
                                            children: [
                                              const Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                    "Upload Driving Licence"),
                                              ),
                                              const SizedBox(
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
                                                      const EdgeInsets.only(
                                                          left: 15),
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
                                                          : const Text(
                                                              "Upload Driving Licence image"),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    val.isCheck
                                        ? const SizedBox(
                                            height: 16,
                                          )
                                        : const SizedBox(),
                                    val.isCheck
                                        ? Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
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
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle: const TextStyle(
                                                        fontSize: 0),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
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
                                        : const SizedBox(),
                                    val.isCheck
                                        ? Container(
                                            height: 48,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade300,
                                                border: Border.all(
                                                    color: Colo.black),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            // color: Colors.grey.shade300,
                                            // dropdown below..
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                const Text(
                                                    "Select Licence Type"),
                                                DropdownButton<String>(
                                                  // value:val.state==""? val
                                                  //     .masterModel!.response!.state!.first:val.state,
                                                  hint: Text(
                                                      val.licenseTpeSelect),
                                                  onChanged: (newValue) =>
                                                      val.updateLicenseType(
                                                          newValue!),
                                                  items: val.licenseTyppe
                                                      .map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (value) =>
                                                              DropdownMenuItem<
                                                                  String>(
                                                                value: value,
                                                                child: Text(
                                                                  value
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                ),
                                                              ))
                                                      .toList(),

                                                  // add extra sugar..
                                                  icon: const Icon(
                                                      Icons.arrow_drop_down),
                                                  iconSize: 42,
                                                  underline: const SizedBox(),
                                                ),
                                              ],
                                            ),
                                          )
                                        : SizedBox(),
                                    val.isCheck
                                        ? const SizedBox(
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
                                              const Row(
                                                children: [
                                                  Text(
                                                      "Enter Driving Licence Expiry Date"),
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
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle: const TextStyle(
                                                        fontSize: 0),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
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
                                                        "Driving Licence Expiry Date",
                                                    suffixIcon: InkWell(
                                                        onTap: () => val
                                                            .driverLicenseExpiry(
                                                                context),
                                                        child: const Icon(Icons
                                                            .calendar_month)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        : const SizedBox(),
                                    const SizedBox(
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
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
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
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                    color: Colo.white,
                                    boxShadow: [
                                      const BoxShadow(
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
                                        const Text(
                                            "Enter Bank Account Holder Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.ac_name,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
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
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter Bank Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.bank_name,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter Bank Branch Name"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.branch_name,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter BANK IFSC Code"),
                                        SizedBox(
                                          height: 48,
                                          child: TextFormField(
                                            maxLines: 1,
                                            controller: val.ifsc,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                            decoration: InputDecoration(
                                              fillColor: Colors.grey.shade200,
                                              filled: true,
                                              errorStyle:
                                                  const TextStyle(fontSize: 0),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      left: 15, right: 5),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                borderSide: const BorderSide(
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text("Enter Cheque image"),
                                        InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Document_Upload(
                                                          fileName: "cheque"))),
                                          child: Container(
                                            height: 48,
                                            width: double.infinity,
                                            padding:
                                                const EdgeInsets.only(left: 15),
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                                color: Colors.grey.shade200,
                                                border: Border.all(
                                                    color: Colors.black38),
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: val.cheque != null
                                                ? Text("${val.cheque!.path}")
                                                : val.cheque_update != null
                                                    ? Text(
                                                        "${val.cheque_update}")
                                                    : const Text(
                                                        "Upload cheque image"),
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          ),
                        ),
                        val.isCheck
                            ? Padding(
                                padding:
                                    const EdgeInsets.only(left: 8, right: 8),
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
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colo.white,
                                          boxShadow: [
                                            const BoxShadow(
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
                                              const Text("Enter Nominee Name"),
                                              SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller: val.nomineeName,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle: const TextStyle(
                                                        fontSize: 0),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
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
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                  "Enter Relationship With The Nominee"),
                                              SizedBox(
                                                height: 48,
                                                child: TextFormField(
                                                  maxLines: 1,
                                                  controller:
                                                      val.nomineeRelationship,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle: const TextStyle(
                                                        fontSize: 0),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
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
                                                    hintText: "Relationship",
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
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                  "Enter Permanent Address Of Nominee"),
                                              SizedBox(
                                                // height: 48,
                                                child: TextFormField(
                                                  maxLines: 4,
                                                  controller:
                                                      val.nomineeAddress,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle: const TextStyle(
                                                        fontSize: 0),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            left: 15,
                                                            right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
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
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                  "Enter Date Of Birth Of Nominee"),
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
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                  ),
                                                  decoration: InputDecoration(
                                                    fillColor:
                                                        Colors.grey.shade200,
                                                    filled: true,
                                                    errorStyle: const TextStyle(
                                                        fontSize: 0),
                                                    contentPadding:
                                                        const EdgeInsets.only(
                                                            left: 15, right: 5),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      borderSide:
                                                          const BorderSide(
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
                                                        child: const Icon(Icons
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
                            : const SizedBox(),
                        const SizedBox(
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
                              const SizedBox(width: 10),
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
                                      child: const Text(
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
                        const SizedBox(
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
                              const SizedBox(width: 10),
                              Text(
                                'No criminal record',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
        }));
  }
}
