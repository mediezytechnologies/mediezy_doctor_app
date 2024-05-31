import 'package:flutter/material.dart';
import 'package:mediezy_doctor/Ui/CommonWidgets/text_style_widget.dart';

class ShortNamesWidget extends StatelessWidget {
  ShortNamesWidget(
      {super.key,
      required this.firstText,
      required this.secondText,
      this.typeId = 0});

  final String firstText;
  final String secondText;
  int typeId;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return typeId != 0
        ? Row(
            children: [
              Text(
                firstText,
                style: size.width > 450 ? greyTabMain : greyMain,
              ),
              Text(
                secondText,
                style: size.width > 450 ? blackTabMainText : blackMainText,
              ),
            ],
          )
        : const SizedBox();
  }
}
