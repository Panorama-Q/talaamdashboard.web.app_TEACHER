// ignore_for_file: invalid_return_type_for_catch_error, body_might_complete_normally_catch_error

import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/utils/extensions/num.dart';

import 'package:iconsax/iconsax.dart';

import '../../../styles/styles.dart';
import '../../../utils/colors_manager.dart';
import '../../../utils/sizes_manager.dart';
import '../../widgets/progress_button.dart';
import '../controllers/posts_controller.dart';

class AddPostScreen extends GetView<PostsController> {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("إضافة خدمة إستشارة"),
            centerTitle: true,
          ),
          body: Form(
            key: controller.addPostKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("تفاصيل الخدمة"),
                        Sizes.size12.h.heightSizedBox,
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: TextFormField(
                            controller: controller.postEditingController,
                            minLines: 4,
                            maxLines: 8,
                            decoration: InputDecoration(
                              counterStyle:
                                  TextStyle(fontWeight: FontWeight.w200),
                              filled: true,
                              fillColor: ColorsManager.veryLightGrey,
                              hintText: 'ما الذي يدور في ذهنك؟',
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                            ),
                          ),
                        ),
                        Sizes.size20.h.heightSizedBox,
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('الحد الأدني للخدمة'),
                                  Sizes.size12.h.heightSizedBox,
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: TextFormField(
                                      controller: controller.minPriceController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: InputDecoration(
                                        counterStyle: TextStyle(
                                            fontWeight: FontWeight.w200),
                                        filled: true,
                                        fillColor: ColorsManager.veryLightGrey,
                                        hintText: "1 رس",
                                        hintStyle: TextStyle(fontSize: 12),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Sizes.size20.w.widthSizedBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('الحد الأقصي للخدمة'),
                                  Sizes.size12.h.heightSizedBox,
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: TextFormField(
                                      controller: controller.maxPriceController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      decoration: InputDecoration(
                                        counterStyle: TextStyle(
                                            fontWeight: FontWeight.w200),
                                        filled: true,
                                        fillColor: ColorsManager.veryLightGrey,
                                        hintText: "1 رس",
                                        hintStyle: TextStyle(fontSize: 12),
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Sizes.size20.h.heightSizedBox,
                        GestureDetector(
                          onTap: () async {
                            controller.pickPostImages();
                          },
                          child: DottedBorder(
                            color: ColorsManager.veryLightGrey,
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(12),
                            child: Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Iconsax.document_upload,
                                    color: ColorsManager.primary,
                                  ),
                                  SizedBox(width: 10),
                                  Text("إضافة صور ل للخدمة"),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Sizes.size12.h.heightSizedBox,
                        const ImageWidget(),
                      ],
                    ).paddingAll(20),
                  ),
                ),
                AppProgressButton(
                  radius: 12,
                  backgroundColor: Styles.primaryColor,
                  text: "إضافة الخدمة",
                  onPressed: (anim) async {
                    if (controller.postEditingController.text.isEmpty) {
                      Get.snackbar(
                        "Can't add an empty post",
                        "Please write a post ",
                        snackPosition: SnackPosition.TOP,
                      );
                      return;
                    }
                    if (controller.minPriceController.text.isEmpty) {
                      Get.snackbar(
                        "Can't add an empty min price",
                        "Please write a min price ",
                        snackPosition: SnackPosition.TOP,
                      );
                      return;
                    }
                    if (controller.maxPriceController.text.isEmpty) {
                      Get.snackbar(
                        "Can't add an empty max price",
                        "Please write a max price ",
                        snackPosition: SnackPosition.TOP,
                      );
                      return;
                    }
                    controller.addPost();
                  },
                ).paddingAll(20),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ImageWidget extends GetWidget<PostsController> {
  const ImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.image.value.path != ''
          ? Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    controller.image.value,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(CupertinoIcons.photo_fill_on_rectangle_fill),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.imageUrl.value = "";
                    controller.image.value = File("");
                    controller.update();
                  },
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
              ],
            )
          : const SizedBox(),
    );
  }
}
