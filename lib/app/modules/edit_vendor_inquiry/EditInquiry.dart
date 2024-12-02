import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:roadservicerepair/app/modules/edit_vendor_inquiry/EditInquiry_controller.dart';

import '../../constants/app_colors.dart';
import '../../utils/button_utl.dart';
import '../../utils/text_field_utl.dart';
import '../../utils/text_utl.dart';

class Editinquiry extends StatefulWidget {
  const Editinquiry({super.key});

  @override
  State<Editinquiry> createState() => _EditinquiryState();
}

class _EditinquiryState extends State<Editinquiry> {
  final controller = Get.put(EditinquiryController());
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
            const SizedBox(height: 15),


            setTextField1(
              context,
              "Name.",
              "Enter Name",
              controller.isName,
              controller.txtName,
              controller.fnName,
            ),




            const SizedBox(height: 15),

            setTextField1(
              context,
              "Service.",
              "Enter service",
              controller.isServices,
              controller.txtServices,
              controller.fnServices,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "truck_make.",
              "Enter truck_make",
              controller.isTruck_make,
              controller.txtTruck_make,
              controller.fnTruck_make,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "make_other.",
              "Enter make_other",
              controller.isMake_other,
              controller.txtMake_other,
              controller.fnMake_other,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "vi_number.",
              "Enter vi_number",
              controller.isvi_number,
              controller.txtvi_number,
              controller.fnvi_number,
            ),

            const SizedBox(height: 15),

            setTextField1(
              context,
              "tire_type.",
              "Enter tire_type",
              controller.isTire_type,
              controller.txtTire_type,
              controller.fnTire_type,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "tire_size.",
              "Enter tire_size",
              controller.isTire_size,
              controller.txtTire_size,
              controller.fnTire_size,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "towing_for.",
              "Enter towing_for",
              controller.istowing_for,
              controller.txttowing_for,
              controller.fntowing_for,
            ),
            const SizedBox(height: 15),

            setTextField1(
              context,
              "country_name.",
              "Enter country_name",
              controller.iscountry_name,
              controller.txtcountry_name,
              controller.fncountry_name,
            ), const SizedBox(height: 15),

            setTextField1(
              context,
              "state_name.",
              "Enter state_name",
              controller.isstate_name,
              controller.txtstate_name,
              controller.fnstate_name,
            ), const SizedBox(height: 15),

            setTextField1(
              context,
              "city_name.",
              "Enter city_name",
              controller.iscity_name,
              controller.txtcity_name,
              controller.fncity_name,
            ),


            const SizedBox(height: 15),


            setTextField1(
              context,
              "Mobile No.",
              "Enter mobile number",
              controller.isMobile,
              controller.txtMobile,
              controller.fnMobile,
            ),
            const SizedBox(height: 15),
            setTextField1(
              context,
              "Email",
              "Enter Email",
              controller.isEmail,
              controller.txtEmail,
              controller.fnEmail,
            ),
            const SizedBox(height: 15),





            // customer
            // setTextField1(
            //   context,
            //   "Customer Name",
            //   "Name",
            //   controller.isCustomerName,
            //   controller.txtCustomerName,
            //   controller.fnCustomerName,
            // ),
            // const SizedBox(height: 15),
            // setTextField1(
            //   context,
            //   "Customer Email",
            //   "Email",
            //   controller.isCustomerEmail,
            //   controller.txtCustomerEmail,
            //   controller.fnCustomerEmail,
            // ),
            // const SizedBox(height: 15),
            // setTextField1(
            //   context,
            //   "Customer MobileNo",
            //   "Mobile Number",
            //   controller.isCustomerNumber,
            //   controller.txtCustomerNumber,
            //   controller.fnCustomerNumber,
            // ),
            // const SizedBox(height: 15),
            // end customer

            setTextFormField1(
              context,
              "Your Location",
              "Enter your address",
              controller.isAdrs,
              controller.txtAdrs,
              controller.fnAdrs,
            ),
            const SizedBox(height: 15),

            setTextField(
              context,
              "Time",
              "Enter Time",
              controller.isest_time,
              controller.txtest_time,
              controller.fnest_time,
            ),
            const SizedBox(height: 15),

            setTextField(
              context,
              "Price",
              "Enter your Price",
              controller.isest_price,
              controller.txtest_price,
              controller.fnest_price,
            ),
            const SizedBox(height: 15),
            // setTextFormField1(
            //   context,
            //   "Request Information",
            //   "Enter problem",
            //   controller.isReqInfo,
            //   controller.txtReqInfo,
            //   controller.fnReqInfo,
            // ),
            const SizedBox(height: 30),


 //            Center(
 //              child: Obx(() {
 //              /*  if (controller.status.value == 0) {
 //
 //                } else {
 //                  return SizedBox(); // Hide image when status is not 0
 //
 //                }
 // */
 //                return Image.network(
 //                  controller.imageurl.value,
 //                  width: 100,
 //                  height: 80,
 //                  fit: BoxFit.cover,
 //                );
 //              }),
 //            ),



            // Center(
            //   child: InkWell(
            //     onTap: () {
            //       print('click');
            //       controller.showImagePickerOption(context);
            //     },
            //     child: Obx(
            //           () => controller.imagePath.value == null
            //           ? Image.asset(
            //         'assets/images/add.jpg',
            //         width: 150,
            //         height: 100,
            //       )
            //           : Image.file(
            //         controller.imagePath.value as File ,
            //         width: 150,
            //         height: 100,
            //       ),
            //     ),
            //   ),
            // ),
             const SizedBox(height: 20),
            Center(
              child: setButton(
                    () => controller.sendNow(context),
                setSemiText("Update Now", AppColors.whiteText, 16),
                AppColors.button,
                200,
                50,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
