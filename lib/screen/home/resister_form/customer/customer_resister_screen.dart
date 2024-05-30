import 'package:feranta_franchise/static/validator/all_textfield_validator.dart';
import 'package:feranta_franchise/view_model/resister/all_resister_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../../../../static/flutter_toast_message/toast_messge.dart';

class CustomerResister extends StatelessWidget {
  CustomerResister({super.key});
  GlobalKey<FormState> formKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Resister Customer"),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        child: Consumer<ResisterViewmodel>(builder: (context, customer, _) {
          return ElevatedButton(
              onPressed: () async {
                // var loginD =
                //     Provider.of<LoginViewmodel>(context, listen: false);
                // .userRegister();
                if (formKey.currentState!.validate()) {
                  if (customer.customerImage != null) {
                    await customer.customerRegister(context);
                  } else {
                    ShowToast(msg: "Enter profile image");
                  }
                  // ShowToast(msg: "Form is validate");
                } else {
                  ShowToast(msg: "Fill all the detais");
                }
              },
              child: customer.isLoading
                  ? CircularProgressIndicator()
                  : Text("Register"));
        }),
      ),
      body: Consumer<ResisterViewmodel>(builder: (context, customer, _) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: badges.Badge(
                      // badgeColor: primaryColor,
                      position: badges.BadgePosition.custom(bottom: 2, end: 10),
                      badgeContent: InkWell(
                        onTap: () async {
                          await customer.customererLogo();
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
                          : const CircleAvatar(
                              radius: 55,
                              //backgroundImage: NetworkImage(DashStrings.serviceImg),
                              // backgroundImage:
                              //     AssetImage('assets/images/appLauncherIcon.jpeg'),
                            ),
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
                          controller: customer.cname, // val.name,
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
                            contentPadding: EdgeInsets.only(left: 15, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
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
                            hintText: "ASUTOSH NAYAK",
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
                      Text("Enter Phone No"),
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
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            errorStyle: TextStyle(fontSize: 0),
                            contentPadding: EdgeInsets.only(left: 15, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
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
                            hintText: "1234567890",
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
                      Text("Enter Email Address"),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          maxLines: 1,
                          controller: customer.cemail, // val.name,
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
                            contentPadding: EdgeInsets.only(left: 15, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
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
                            hintText: "abc@gmail.com",
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
                      Text("Enter WhatsApp no"),
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
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          decoration: InputDecoration(
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            errorStyle: TextStyle(fontSize: 0),
                            contentPadding: EdgeInsets.only(left: 15, right: 5),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
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
                            hintText: "1234567890",
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
                ],
              )),
        );
      }),
    );
  }
}
