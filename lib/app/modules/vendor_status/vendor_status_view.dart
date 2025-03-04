import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/modules/vendor_status/vendor_status_controller.dart';
import 'package:roadservicerepair/app/utils/LabelValueRow.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

import '../../constants/app_colors.dart';

class VendorStatusView extends StatefulWidget {
  const VendorStatusView({super.key});

  @override
  State<VendorStatusView> createState() => _VendorStatusViewState();
}

class _VendorStatusViewState extends State<VendorStatusView> {
  dynamic viewInquiry;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VendorStatusController>(
        init: VendorStatusController(),
        builder: (_) {
          return Obx(() => _.arr.isEmpty
              ? Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                const Icon(
                  Icons.error_outline,
                  size: 50,
                  color: AppColors.detailText,
                ),
                setRegularText(
                    "No inquiry found.", AppColors.titleText, 14)
              ],
            ),
          )
              : ListView.builder(
            itemCount: _.arr.length,
            itemBuilder: (context, index) {
              viewInquiry = _.arr[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(

                    child:ListTile(

                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('service :'),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(child: Text(viewInquiry['service']))
                          ],
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelValueRow(
                            label: 'Service For :',
                            value: viewInquiry['service_for'],
                          ),
                          LabelValueRow(
                            label: 'Name :',
                            value: viewInquiry['name'],
                          ),

                          LabelValueRow(
                            label: 'Unit Number :',
                            value: viewInquiry['unit_number'],
                          ),
                          // LabelValueRow(
                          //   label: 'Driver Number :',
                          //   value: viewInquiry['driver_number'],
                          // ),
                          LabelValueRow(
                            label: 'Address :',
                            value: viewInquiry['address'],
                          ),
                          LabelValueRow(
                            label: 'Remark :',
                            value: viewInquiry['remark'],
                          ),

                          LabelValueRow(
                            label: 'Estimate time :',
                            value: viewInquiry['est_time'],
                          ),

                          LabelValueRow(
                            label: 'Estimate Price :',
                            value: viewInquiry['est_price'],
                          ),

                          LabelValueRow(
                            label: 'Vendor Name :',
                            value: viewInquiry['vendor_name'],
                          ),
                          LabelValueRow(
                            label: 'Vendor Email :',
                            value: viewInquiry['vendor_email'],
                          ),

                          LabelValueRow(
                            label: 'Vendor Mobile :',
                            value: viewInquiry['vendor_mobile'],
                          ),

                          LabelValueRow(
                            label: 'Vendor Address :',
                            value: viewInquiry['vendor_address'],
                          ),

                          LabelValueRow(
                            label: 'reason :',
                            value: viewInquiry['reason'],
                          ),

                          // Text("user " + _.userType),
                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                                child: LabelValueRow(
                                  label: 'Status :',
                                  value: viewInquiry['sta_tus'],
                                ),
                              ),
                              Visibility(
                                visible: _.userType == "2", // Only visible if userType is "1"
                                child: Positioned(
                                  right: 16, // Adjust this value for precise positioning
                                  bottom: 8, // Adjust this value as needed
                                  child: GestureDetector(
                                    onTap: () {
                                      _.editVendorStatus(viewInquiry['vs_id']);
                                      // Action to perform when the text is tapped
                                    },
                                    child: Text(
                                      "✏️ Edit Status",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Visibility(
                                visible: _.userType == "0", // Only visible if userType is "1"
                                child: Positioned(
                                  right: 16, // Adjust this value for precise positioning
                                  bottom: 8, // Adjust this value as needed
                                  child: GestureDetector(
                                    onTap: () {
                                      _.deleteVendorStatus(viewInquiry['vs_id']);  // Pass scroll controller
//                                      _.deleteVendorStatus(viewInquiry['vs_id']);
                                      // Action to perform when the text is tapped
                                    },
                                    child: Text(
                                      "🗑 Delete",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),

                    ),
                  ),
                ],
              );
            },
          ));
        });
  }
}
