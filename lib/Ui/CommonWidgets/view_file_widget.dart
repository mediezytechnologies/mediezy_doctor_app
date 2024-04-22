import 'package:flutter/material.dart';

class ViewFileWidget extends StatefulWidget {
  const ViewFileWidget({super.key, required this.viewFile});
  final String viewFile;
  @override
  State<ViewFileWidget> createState() => _ViewFileWidgetState();
}

class _ViewFileWidgetState extends State<ViewFileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Image(image: NetworkImage(widget.viewFile)))
        ],
      ),
      // body:PDFView(
      //   filePath: pdfAssetPath,
      //   autoSpacing: true,
      //   pageSnap: true,
      //   swipeHorizontal: true,
      // ),
    );
  }
}
