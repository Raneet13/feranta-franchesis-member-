import 'dart:io';
import 'package:feranta_franchise/view_model/resister/all_resister_viewmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../static/flutter_toast_message/toast_messge.dart';
import '../../../view_model/auth/login-viewmodel.dart';

class Document_Upload extends StatefulWidget {
  String fileName;
  Document_Upload({required this.fileName, super.key});

  @override
  State<Document_Upload> createState() => _Document_UploadState();
}

class _Document_UploadState extends State<Document_Upload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Consumer<ResisterViewmodel>(builder: (context, val, _) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => val.insertDemoImage(context),
                    child: val.seeDemo != null
                        ? Image.file(
                            height: 150,
                            width: double.infinity,
                            val.seeDemo!,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 150,
                            alignment: Alignment.center,
                            color: Colors.white,
                            child: Icon(
                              Icons.drive_folder_upload,
                              size: 50,
                            ),
                          ),
                  ),
                  Text(
                    "Upload ${widget.fileName}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  // Text(
                  //   "Follow the instruction you have recived in \nthe mail and upload it securely from here",
                  //   style: TextStyle(color: Colors.black38),
                  // ),
                  // InkWell(
                  //   onTap: () async {
                  //     val.insertDemoImage(context);
                  //     //   FilePickerResult? result =
                  //     //       await FilePicker.platform.pickFiles();

                  //     //   if (result != null) {
                  //     //     File file = File(result.files.single.path!);
                  //     //   } else {
                  //     //     // User canceled the picker
                  //     //   }
                  //   },
                  //   child: Container(
                  //     height: 50,
                  //     width: double.maxFinite,
                  //     margin: EdgeInsets.only(top: 15),
                  //     child: Container(
                  //       color: Colors.black26,
                  //       // dashPattern: [5, 5],
                  //       child: Center(
                  //         child: TextButton.icon(
                  //           onPressed: null, //() => val.insertDemoImage(),
                  //           icon: Icon(Icons.file_open),
                  //           label: Text("Add a File"),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)))),
                    onPressed: () {
                      if (val.seeDemo != null) {
                        val.submitImage(filename: widget.fileName);
                        Navigator.pop(context);
                      } else {
                        ShowToast(msg: "First upload Image");
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          );
        }),
      ),
    );
  }
}
