import 'package:cached_network_image/cached_network_image.dart';
import 'package:feranta_franchise/configs/app_url.dart';
import 'package:feranta_franchise/static/validator/all_textfield_validator.dart';
import 'package:feranta_franchise/view_model/resister/all_resister_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../../../../model/past_record/all_record_model.dart';
import '../../../../static/flutter_toast_message/toast_messge.dart';

class CustomerResister extends StatefulWidget {
  UserList? customerDetails;
  CustomerResister({this.customerDetails, super.key});

  @override
  State<CustomerResister> createState() => _CustomerResisterState();
}

class _CustomerResisterState extends State<CustomerResister> {
  GlobalKey<FormState> formKey = new GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.customerDetails != null) {
        Provider.of<ResisterViewmodel>(context, listen: false)
          ..isLoading = false
          ..clearCustomerResistationForm()
          ..initCustomerDet(widget.customerDetails!);
      } else {
        Provider.of<ResisterViewmodel>(context, listen: false)
          ..isLoading = false
          ..clearCustomerResistationForm();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
            "${widget.customerDetails != null ? "Update" : "Register"} Customer"),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Provider.of<ResisterViewmodel>(context, listen: false)
              ..isLoading = false
              ..clearCustomerResistationForm();
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Consumer<ResisterViewmodel>(builder: (context, customer, _) {
          return ElevatedButton(
              onPressed: () async {
                // var loginD =
                //     Provider.of<LoginViewmodel>(context, listen: false);
                // .userRegister();
                if (formKey.currentState!.validate()) {
                  if (widget.customerDetails != null) {
                    await customer.updatecustomerRegisterView(
                        context, widget.customerDetails!.id);
                  } else {
                    await customer.customerRegister(context);
                  }
                  // ShowToast(msg: "Form is validate");
                } else {
                  ShowToast(msg: "Fill all the details");
                }
              },
              child: customer.isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      "${widget.customerDetails != null ? "Update" : "Registration"}"));
        }),
      ),
      body: Consumer<ResisterViewmodel>(builder: (context, customer, _) {
        return SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: badges.Badge(
                      // badgeColor: primaryColor,
                      badgeStyle: badges.BadgeStyle(
                        badgeColor: Colors.black,
                      ),
                      position: badges.BadgePosition.custom(bottom: 2, end: 10),
                      badgeContent: InkWell(
                        onTap: () async {
                          await customer.customererLogo(context);
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      child: customer.customerImage != null
                          ? CircleAvatar(
                              radius: 55,

                              //backgroundImage: NetworkImage(DashStrings.serviceImg),
                              backgroundImage:
                                  FileImage(customer.customerImage!),
                              onBackgroundImageError: (e, st) {},
                            )
                          //  Image.file(
                          //   height: ,
                          //   width: ,
                          //     customer.profileImage!,
                          //     fit: BoxFit.fill,
                          //   )
                          : customer.customerImage_update != null
                              ? CircleAvatar(
                                  radius: 55,
                                  backgroundImage: CachedNetworkImageProvider(
                                      "${AppUrl.imageUrl}${customer.customerImage_update}")
                                  // backgroundImage:
                                  //     AssetImage('assets/images/appLauncherIcon.jpeg'),
                                  )
                              : const CircleAvatar(
                                  radius: 55,
                                  backgroundImage:
                                      CachedNetworkImageProvider("")),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text("Enter Name"),
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
                          controller: customer.cname, // val.name,
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                              ValidateAll.inputValidate(input),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            errorStyle: const TextStyle(fontSize: 0),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.amber, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            // labelStyle: Theme.of(context)
                            //     .textTheme
                            //     .bodyMedium,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100, // Border color
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text("Enter Phone Number"),
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
                          controller: customer.ccontact, // val.name,
                          keyboardType: TextInputType.number,
                          validator: (input) =>
                              ValidateAll.validateMobile(input),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            errorStyle: const TextStyle(fontSize: 0),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.amber, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            // labelStyle: Theme.of(context)
                            //     .textTheme
                            //     .bodyMedium,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            // enabled: true,
                            // label: Text("Enter email"),
                            // floatingLabelAlignment:
                            //     FloatingLabelAlignment.start,
                            hintText: "Phone Number",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text("Enter Email Address"),
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
                          controller: customer.cemail, // val.name,
                          keyboardType: TextInputType.text,
                          // validator: (input) =>
                          //     ValidateAll.validateEmail(input),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            errorStyle: const TextStyle(fontSize: 0),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.amber, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            // labelStyle: Theme.of(context)
                            //     .textTheme
                            //     .bodyMedium,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            // enabled: true,
                            // label: Text("Enter email"),
                            // floatingLabelAlignment:
                            //     FloatingLabelAlignment.start,
                            hintText: "Email Address",
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text("Enter WhatsApp Number"),
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
                          controller: customer.caltcontact, // val.name,
                          keyboardType: TextInputType.number,
                          validator: (input) =>
                              ValidateAll.validateMobile(input),
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(10),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            errorStyle: const TextStyle(fontSize: 0),
                            contentPadding:
                                const EdgeInsets.only(left: 15, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.amber, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade200, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            // labelStyle: Theme.of(context)
                            //     .textTheme
                            //     .bodyMedium,
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: Colors.grey.shade100, // Border color
                                width: 2.0, // Border width
                              ),
                            ),
                            // enabled: true,
                            // label: Text("Enter email"),
                            // floatingLabelAlignment:
                            //     FloatingLabelAlignment.start,
                            hintText: "Phone Number",
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
                ],
              )),
        );
      }),
    );
  }
}
