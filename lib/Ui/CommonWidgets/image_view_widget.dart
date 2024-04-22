import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageViewWidget extends StatelessWidget {
  const ImageViewWidget({super.key, required this.image});

  final File? image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Uploaded Image"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: 400.h,
              width: 300.w,
              decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(image: FileImage(image!),fit: BoxFit.fill)),
              // child: Image.file(
              //   image!,
              //   fit: BoxFit.fill,
              // ),
            ),
          )
        ],
      ),
    );
  }
}
