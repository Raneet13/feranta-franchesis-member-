import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../static/color.dart';
import '../../static/flutter_toast_message/toast_messge.dart';
import '../../view_model/permission_viewmodel/permission-view_model.dart';

class PermissionPhone extends StatefulWidget {
  const PermissionPhone({super.key});

  @override
  State<PermissionPhone> createState() => _PermissionPhoneState();
}

class _PermissionPhoneState extends State<PermissionPhone> {
  // List<Contact> _contacts = [];
  // late Future<void> _initializeControllerFuture;
  // final ImagePicker _picker = ImagePicker();
  // XFile? _image;

  // @override
  // void initState() {
  //   // TODO: implement initState

  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     WidgetsFlutterBinding.ensureInitialized();
  //   });
  // }

  // Future<void> _requestPermission() async {
  //   var status = await Permission.contacts.status;
  //   if (status.isDenied) {
  //     if (await Permission.contacts.request().isGranted) {
  //       // Permission granted
  //       _fetchContacts();
  //     }
  //   } else if (status.isGranted) {
  //     // Permission already granted
  //     _fetchContacts();
  //   } else if (status.isPermanentlyDenied) {
  //     // Permission permanently denied, handle appropriately
  //     openAppSettings();
  //   }
  // }

  // Future<void> _fetchContacts() async {
  //   Iterable<Contact> contacts = await ContactsService.getContacts();
  //   setState(() {
  //     _contacts = contacts.toList();
  //   });
  // }

  //camera permission

  //gallery

  //

  @override
  Widget build(BuildContext context) {
    return Consumer<PermissionViewModel>(builder: (context, permission, _) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Application Permission"),
          centerTitle: true,
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(bottom: 18, left: 15, right: 15),
          child: SizedBox(
            height: 40,
            width: double.infinity,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: permission.cameraPermission &&
                            permission.locationPermission
                        ? Colo.primaryColor
                        : Colo.primaryColor.withOpacity(0.4)),
                onPressed: () async {
                  if (permission.cameraPermission &&
                      permission.locationPermission &&
                      permission.photoPermissioon) {
                    final SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString("locEnDs", "true");
                    context.pushReplacement('/login');
                  } else {
                    ShowToast(
                        msg:
                            "First Allow all the permission which is require for use all feature of this application");
                  }

//                   // permission.requestlocationPermission(); //location
// //  permission.requestCameraPermission();//camera permissioon
//                   permission.permissionPhotoOrStorage(); //storage permission

                  // _requestGalleryPermission();
                },
                // },
                child: Text("Next")),
          ),
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 200,
            //   width: 200,
            //   child: Image.asset(
            //     "assets/logo/captain_icon.jpeg",
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Camera Permission Required For Image Capture To Create and Update Account",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => permission.requestCameraPermission(),
                          child: Text(
                              "${permission.cameraPermission ? "Allowed" : "Allow"}",
                              style: Theme.of(context).textTheme.bodySmall),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: permission.cameraPermission
                                ? Colors.green
                                : Colo.primaryColor,
                            padding: EdgeInsets.all(5),
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                      ]),
                  Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Location Permission Required For Current Location ued in Attendance",
                            maxLines: 3,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              permission.requestlocationPermission(),
                          child: Text(
                              "${permission.locationPermission ? "Allowed" : "Allow"}",
                              style: Theme.of(context).textTheme.bodySmall),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: permission.locationPermission
                                ? Colors.green
                                : Colo.primaryColor,
                            padding: EdgeInsets.all(5),
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                      ]),
                  Divider(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Allow Storage Permission For Access photos, and media to create your account and update Account",
                            maxLines: 3,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () =>
                              permission.permissionPhotoOrStorage(),
                          child: Text(
                              "${permission.photoPermissioon ? "Allowed" : "Allow"}",
                              style: Theme.of(context).textTheme.bodySmall),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: permission.photoPermissioon
                                ? Colors.green
                                : Colo.primaryColor,
                            padding: EdgeInsets.all(5),
                            minimumSize: Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        )
                      ]),
                  Divider(),
                ],
              ),
            ),
          ],
        )),
      );
    });
  }
}
