import 'package:cached_network_image/cached_network_image.dart';
import 'package:feranta_franchise/configs/app_url.dart';
import 'package:feranta_franchise/configs/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;
import '../../static/flutter_toast_message/toast_messge.dart';
import '../../view_model/profile/profile_viewmodel.dart';

class EditProfiletls extends StatefulWidget {
  const EditProfiletls({super.key});

  @override
  State<EditProfiletls> createState() => _EditProfiletlsState();
}

class _EditProfiletlsState extends State<EditProfiletls> {
  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height -
      (MediaQuery.of(context).padding.top +
          MediaQuery.of(context).padding.bottom);

  @override
  void initState() {
    // TODO: implement initState
    // final provider = Provider.of<UserProvider>(context, listen: false);
    // provider.viewProfle();

    super.initState();
  }

  List<Map<String, dynamic>> profile = [
    {"icon": Icons.location_on, "name": "Address"},
    {"icon": Icons.notifications, "name": "Notification"},
    {"icon": Icons.settings, "name": "Settings"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          "Edit Profile",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height * 0.8,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Consumer<ProfileViewmodel>(builder: (context, profile, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: badges.Badge(
                        // badgeColor: primaryColor,
                        position:
                            badges.BadgePosition.custom(bottom: 2, end: 10),
                        badgeContent: InkWell(
                          onTap: () async {
                            await profile.insertProfileImage();
                          },
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        child: profile.profileImage != null
                            ? CircleAvatar(
                                radius: 55,

                                //backgroundImage: NetworkImage(DashStrings.serviceImg),
                                backgroundImage:
                                    FileImage(profile.profileImage!),
                                onBackgroundImageError: (e, st) {},
                              )
                            //  Image.file(
                            //   height: ,
                            //   width: ,
                            //     profile.profileImage!,
                            //     fit: BoxFit.fill,
                            //   )
                            : CircleAvatar(
                                radius: 55,

                                //backgroundImage: NetworkImage(DashStrings.serviceImg),
                                backgroundImage: CachedNetworkImageProvider(
                                    "${AppUrl.imageUrl}${profile.profileDetailsModel!.response!.userDetails!.profileImage ?? ""}"),
                                onBackgroundImageError: (e, st) {},
                              ),
                      ),
                    ),
                    Text(
                      'Name',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    CustomTextField(
                      controller: profile.nameController,
                      KeyBoardType: TextInputType.name,
                      hint: 'name',
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      'Email',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    CustomTextField(
                      controller: profile.emailController,
                      KeyBoardType: TextInputType.emailAddress,
                      hint: "xyz@gmail.com",
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      'Phone No',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    CustomTextField(
                      controller: profile.phoneController,
                      KeyBoardType: TextInputType.phone,
                      hint: "1234567890",
                    ),
                  ],
                ),

                // Align(
                //   alignment: Alignment.center,
                //   child: Text(
                //     'Upload Profile',
                //     style: Theme.of(context).textTheme.bodyMedium,
                //   ),
                // ),
                // SizedBox(
                //   height: height * 0.02,
                // ),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () async {
                        if (profile.nameController.text != "" &&
                            profile.emailController.text != "") {
                          await profile.updateProfileViewmodel();
                        } else {
                          ShowToast(msg: "Please Fill all the Field");
                        }
                      },
                      child: profile.isLoading
                          ? CircularProgressIndicator()
                          : Text("Update Profile")),
                ),

                // PrimaryButton(
                //   width: width,
                //   height: 47,
                //   onPressed: () {
                //     final name = _nameController.text.trim();
                //     final email = _emailController.text.trim();
                //     final phoneNumber = _phoneController.text.trim();
                //     // if (name.isEmpty) {
                //     //   Get.snackbar('Error', 'Name can not be empty');
                //     //   return;
                //     // }
                //     // if (email.isEmpty) {
                //     //   Get.snackbar('Error', 'Email can not be empty');
                //     //   return;
                //     // }

                //     // if (phoneNumber.isEmpty) {
                //     //   Get.snackbar('Error', 'Phone number can not be empty');
                //     //   return;
                //     // }
                //     showDialog(
                //       context: context,
                //       builder: (_) =>
                //           const Center(child: CircularProgressIndicator()),
                //     );
                //     // profileController
                //     //     .updateUserData(name, email, phoneNumber)
                //     //     .then((value) async {
                //     //   if (value) {
                //     //     await profileController.getUserData();
                //     //     Get.snackbar('Successful', 'Profile updated successfully');
                //     //     Navigator.pop(context);
                //     //     Navigator.pop(context);
                //     //   } else {
                //     //     Navigator.pop(context);

                //     //     Get.snackbar('Error', 'Something went wrong');
                //     //   }
                //     // });
                //   },
                //   child: const Text(
                //     "Submit",
                //     style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 14,
                //         letterSpacing: 1.2,
                //         fontWeight: FontWeight.w600),
                //   ),
                // )
              ],
            );
          }),
        ),
      ),
    );
  }
}
