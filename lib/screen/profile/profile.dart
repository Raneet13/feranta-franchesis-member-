import 'package:cached_network_image/cached_network_image.dart';
import 'package:feranta_franchise/screen/profile/profile_shimmer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../configs/app_url.dart';
import '../../configs/custom_elivated_button.dart';
import '../../static/color.dart';
import '../../view_model/auth/login-viewmodel.dart';
import '../../view_model/profile/profile_viewmodel.dart';
import 'edit_profile.dart';

class ProfileScren extends StatefulWidget {
  const ProfileScren({super.key});

  @override
  State<ProfileScren> createState() => _ProfileScrenState();
}

class _ProfileScrenState extends State<ProfileScren> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        Provider.of<ProfileViewmodel>(context, listen: false)
            .viewProfiledetails());
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            // title: Text('Enter OTP'),
            content: const Text("Are you sure you want to logout"),
            actions: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colo.black),
                child: Text(
                  'No',
                  style: TextStyle(
                      // decoration: TextDecoration.underline,
                      color: Colo.white),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,

                    elevation: 4,
                    side: BorderSide(
                        color: Colors.transparent,
                        width: .3), // Change border color and width here
                    // Text color
                  ),
                  child: Text(
                    'Yes',
                    // style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Provider.of<LoginViewmodel>(context, listen: false)
                        .Logout(context);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        // minimum: EdgeInsets.only(left: 10, right: 10),
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.bottomCenter,
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * .8,
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child:
                    Consumer<ProfileViewmodel>(builder: (context, profile, _) {
                  return profile.profileDetailsModel != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Transform.translate(
                              offset: Offset(0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Material(
                                        elevation: 10.0,
                                        color: Colors.white,
                                        shape: CircleBorder(),
                                        child: Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: SizedBox(
                                            height: 70,
                                            width: 70,
                                            child: profile
                                                        .profileDetailsModel!
                                                        .response!
                                                        .userDetails!
                                                        .profileImage ==
                                                    null
                                                ? Icon(
                                                    Icons.account_circle,
                                                    size: 60,
                                                  )
                                                : CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    backgroundImage:
                                                        CachedNetworkImageProvider(
                                                      "${AppUrl.imageUrl}${profile.profileDetailsModel!.response!.userDetails!.profileImage}",
                                                    )),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${profile.profileDetailsModel!.response!.userDetails!.fullName ?? ""}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      TextButton.icon(
                                          onPressed: () {
                                            context.push('/profie/editProfile',
                                                extra: {'id': '2'});
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             Profile_screen()));
                                          },
                                          style: ButtonStyle(
                                            // shape: MaterialStateProperty.all<
                                            //     RoundedRectangleBorder>(
                                            //   RoundedRectangleBorder(
                                            //       borderRadius:
                                            //           BorderRadius.circular(18.0),
                                            //       side: BorderSide(color: Colors.black)),
                                            // ),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.transparent),
                                          ),
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colo.yellow,
                                          ),
                                          label: Text(
                                            "Edit Profile",
                                            style: TextStyle(
                                                color: Colors.amber,
                                                fontSize: 14),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Feranta",
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelLarge,
                                          ),
                                        ),
                                        ListView(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            children: [
                                              Container(
                                                // height: 50,
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.grey.shade100,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 5.0)
                                                    ]),
                                                child: ListTile(
                                                  onTap: () => context
                                                      .push('/web', extra: {
                                                    'id': '2',
                                                    'url': AppUrl.ferantaPrivacy
                                                  }),
                                                  leading: const Icon(
                                                    Icons.security,
                                                    size: 20,
                                                  ),
                                                  title: Text("Privacy Policy",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                // height: 50,
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.grey.shade100,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 5.0)
                                                    ]),
                                                child: ListTile(
                                                  onTap: () => context
                                                      .push('/web', extra: {
                                                    'id': '2',
                                                    'url': AppUrl.ferantaTerms
                                                  }),
                                                  leading: const Icon(
                                                    Icons.description,
                                                    size: 20,
                                                  ),
                                                  title: Text(
                                                      "Terms & Conditions",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                // height: 50,
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.grey.shade100,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 5.0)
                                                    ]),
                                                child: ListTile(
                                                  onTap: () => context
                                                      .push('/web', extra: {
                                                    'id': '2',
                                                    'url':
                                                        AppUrl.ferantaCustomer
                                                  }),
                                                  leading: const Icon(
                                                    Icons.support_agent,
                                                    size: 20,
                                                  ),
                                                  title: Text("Customer Care",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                // height: 50,
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                    color: Colors.grey.shade100,
                                                    boxShadow: const [
                                                      BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 5.0)
                                                    ]),
                                                child: ListTile(
                                                  onTap: () => context
                                                      .push('/web', extra: {
                                                    'id': '2',
                                                    'url': AppUrl.ferantaAbout
                                                  }),
                                                  leading: SizedBox(
                                                    height: 25,
                                                    width: 25,
                                                    child: Image.asset(
                                                      "assets/logo/feranta_new_logo_.png",
                                                    ),
                                                  ),
                                                  title: Text("About Feranta",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyMedium),
                                                ),
                                              ),
                                            ]),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        child: Text("Logout"),
                                        onPressed: () =>
                                            showLogoutDialog(context),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : profileShimmer(context);
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
