import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediezy_doctor/Ui/Consts/app_colors.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? imagePath;
  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),

      body: Container(
        color: kCardColor,
        child: Column(children: [
    Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: size.height * 0.16,
                          width: size.width * 0.33,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70.r),
                          ),
                          child: FadedScaleAnimation(
                            scaleDuration: const Duration(milliseconds: 400),
                            fadeDuration: const Duration(milliseconds: 400),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(70.r),
                              child: imagePath != null
                                  ? Image.file(
                                      File(imagePath!),
                                      height: 80.h,
                                      width: 80.w,
                                      fit: BoxFit.cover,
                                    )
                                  : (widget.patientImage == ""
                                      ? Image.asset(
                                          "assets/icons/profile pic.png",
                                          height: 80.h,
                                          width: 80.w,
                                          color: kMainColor,
                                        )
                                      : Image.network(
                                          widget.patientImage,
                                          height: 80.h,
                                          width: 80.w,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image.asset(
                                              "assets/icons/profile pic.png",
                                              height: 80.h,
                                              width: 80.w,
                                              color: kMainColor,
                                            ),
                                          ),
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Center(
                                              child: Shimmer.fromColors(
                                                baseColor: kShimmerBaseColor,
                                                highlightColor:
                                                    kShimmerHighlightColor,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            80.r),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.h,
                        right: 100.w,
                        child: IconButton(
                          onPressed: () {
                            placePicImage();
                          },
                          icon: Icon(
                            Icons.add_a_photo,
                            size: 26.sp,
                            weight: 5,
                            color: kMainColor,
                          ),
                        ),
                      ),
                    ],
                  ),       
          
        
        ],),
      ),
    );
    
  }

 Future placePicImage() async {
    var image = await imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 30,
    );
    if (image == null) return;
    final imageTemporary = image.path;
    setState(() {
      imagePath = imageTemporary;
      print("$imageTemporary======= image");
    });
  }

}
