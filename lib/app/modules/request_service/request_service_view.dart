

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/request_service/request_service_controller.dart';
import 'package:roadservicerepair/app/utils/button_utl.dart';
import 'package:roadservicerepair/app/utils/drop_down_utl.dart';
import 'package:roadservicerepair/app/utils/text_field_utl.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';
import 'package:roadservicerepair/model/CityData.dart';

import '../../../model/Country.dart';
import '../../../model/StateData.dart';

class ReqServiceView extends StatefulWidget {
  const ReqServiceView({Key? key}) : super(key: key);

  @override
  State<ReqServiceView> createState() => _ReqServiceViewState();
}

class _ReqServiceViewState extends State<ReqServiceView> {
  final controller = Get.put(ReqServiceController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.whiteText,
          title: Obx(() => setSemiText(controller.pageTitle.value, AppColors.titleText, 16)),
        ),
        backgroundColor: AppColors.primary,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            setTextField(
              context,
              "Service",
              "Enter Service Name",
              controller.isService,
              controller.txtService,
              controller.fnService,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Service For",
              "Enter Service For ",
              controller.isServiceFor,
              controller.txtServiceFor,
              controller.fnServiceFor,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Type",
              "Enter Type",
              controller.isType,
              controller.txtType,
              controller.fnType,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Name",
              "Enter Name",
              controller.isName,
              controller.txtName,
              controller.fnName,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Unit Number",
              "Enter Unit Number",
              controller.isUnitNo,
              controller.txtUnitNo,
              controller.fnUnitNo,
            ),
            const SizedBox(height: 15),
            setTextField(
              context,
              "Driver Number",
              "Enter Driver Number",
              controller.isDriverNo,
              controller.txtDriverNo,
              controller.fnDriverNo,
            ),

            const SizedBox(height: 15),
            setTextField(
              context,
              "Remark",
              "Enter Remark",
              controller.isRemark,
              controller.txtRemark,
              controller.fnRemark,
            ),
            const SizedBox(height: 15),
            Stack(
              children: [
                // Address Input Field
                setTextFormField(context, "Address", "Enter address", controller.isAddress,
                    controller.txtAddress, controller.fnAddress),
                // Location Icon Button
                Positioned(
                  right: 20, // Align to the right
                  top: 0, // Align to the top of the field
                  bottom: 0, // Align to the bottom of the field
                  child:IconButton(
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 30, // Set the size of the icon here
                    ),
                    onPressed: () {
                      controller.fetchCurrentLocation(controller.txtAddress);
                    },
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
            Center(
              child: InkWell(
                onTap: () {
                  print('click');
                  controller.showImagePickerOption(context);
                },
                child: Obx(
                      () => controller.imagePath.value == null
                      ? Image.asset(
                    'assets/images/add.jpg',
                    width: 150,
                    height: 100,
                  )
                      : Image.file(
                    controller.imagePath.value as File ,
                    width: 150,
                    height: 100,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Obx(() {
                return controller.isLoading.value
                    ? CircularProgressIndicator()
                    : setButton(
                      () => controller.sendNow(context),
                  setSemiText("Send Now", AppColors.whiteText, 16),
                  AppColors.button,
                  200,
                  50,
                );
              }),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
