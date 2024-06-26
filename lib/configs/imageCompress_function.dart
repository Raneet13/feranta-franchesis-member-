import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<XFile?> compressFile(
    {required File file,
    int height = 1920,
    int width = 1080,
    int quality = 25}) async {
  final filePath = file.absolute.path;

  // Create output file path
  // eg:- "Volume/VM/abcd_out.jpeg"
  final lastIndex = filePath.lastIndexOf(new RegExp(r'.png|.jpeg|.jpg'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  print("OUTPATH :  ${outPath}");
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    outPath, //file.path
    minWidth: height,
    minHeight: width,
    format: CompressFormat.jpeg,
    quality: quality,
  );

  // print(file.lengthSync());
  // print(File(result!.path).lengthSync());

  return result;
}
