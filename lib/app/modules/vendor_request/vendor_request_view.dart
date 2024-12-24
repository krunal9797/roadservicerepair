import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/vendor_request/vendor_request_controller.dart';
import 'package:roadservicerepair/app/utils/VendorInfoRow.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

class VendorReqView extends StatefulWidget {
  const VendorReqView({super.key});

  @override
  State<VendorReqView> createState() => _VendorReqViewState();
}

class _VendorReqViewState extends State<VendorReqView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VendorReqController>(
        init: VendorReqController(),
        builder: (_) {
          return Obx(() => _.arr.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   child: Center(
                      //     child: CircularProgressIndicator(),
                      //   ),
                      // ),
                      const Icon(
                        Icons.error_outline,
                        size: 50,
                        color: AppColors.detailText,
                      ),
                      setRegularText(
                          "No vendor request found.", AppColors.titleText, 14)
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _.arr.length,
                  itemBuilder: (context, index) {
                    final vendor = _.arr[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('vendor_name :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['vendor_name']))
                                ],
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                VendorInfoRow(
                                  label: 'Service',
                                  value: vendor['service'],
                                ),
                                VendorInfoRow(
                                  label: 'Service For',
                                  value: vendor['service_for'],
                                ),
                                VendorInfoRow(
                                  label: 'Name',
                                  value: vendor['name'],
                                ),
                                VendorInfoRow(
                                  label: 'Unit Number',
                                  value: vendor['unit_number'],
                                ),
                                VendorInfoRow(
                                  label: 'Driver Number',
                                  value: vendor['driver_number'],
                                ),
                                VendorInfoRow(
                                  label: 'Address',
                                  value: vendor['address'],
                                ),
                                VendorInfoRow(
                                  label: 'Remark',
                                  value: vendor['remark'],
                                ),
                                VendorInfoRow(
                                  label: 'Estimate Time',
                                  value: vendor['est_time'],
                                ),
                                VendorInfoRow(
                                  label: 'Estimate Price',
                                  value: vendor['est_price'],
                                ),
                                VendorInfoRow(
                                  label: 'Vendor Name',
                                  value: vendor['vendor_name'],
                                ),
                                VendorInfoRow(
                                  label: 'Vendor Email',
                                  value: vendor['vendor_email'],
                                ),
                                VendorInfoRow(
                                  label: 'Vendor Mobile',
                                  value: vendor['vendor_mobile'],
                                ),
                                VendorInfoRow(
                                  label: 'Vendor Address',
                                  value: vendor['vendor_address'],
                                ),
                                VendorInfoRow(
                                  label: 'Status',
                                  value: vendor['rname'],
                                ),
                              ],
                            ),
                            trailing: Wrap(
                              spacing: -16,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    size: 40,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    String id = vendor['id'];
                                    _.editInquiry(id);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Colors.redAccent,
                                  ),
                                  onPressed: () {
                                    _.deleteItem(vendor['id']);
                                  },
                                )
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
