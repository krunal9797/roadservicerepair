import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:roadservicerepair/app/modules/edit_vendor_request_status/edit_vendor_request_status.dart';
import 'package:roadservicerepair/app/modules/vendor_request_status/Vendor_Request_status_Controller.dart';

import '../../constants/app_colors.dart';
import '../../utils/text_utl.dart';

class VendorRequestStatus extends StatefulWidget {
  const VendorRequestStatus({super.key});

  @override
  State<VendorRequestStatus> createState() => _VendorRequestStatusState();
}

class _VendorRequestStatusState extends State<VendorRequestStatus> {
  int? _expandedIndex = 0;  // Initializing to 0 to expand the first element


  @override
  Widget build(BuildContext context) {
    return GetBuilder<VendorRequestStatusController>(
      init: VendorRequestStatusController(),
      builder: (_) {
        print('Rebuilding UI with arr: ${_.arr}');
        return Obx(() => _.arr.isEmpty
            ? Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 50,
                color: AppColors.detailText,
              ),
              setRegularText("No customers found", AppColors.titleText, 14)
            ],
          ),
        )
       //admin request

            : ListView.builder(
          itemCount: _.arr.length,
          itemBuilder: (context, index) {
            final customer = _.arr[index];
            final isExpanded = _expandedIndex == index;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 2.0),
                  child: Card(
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Service :'),
                            SizedBox(width: 10),
                            Expanded(child: Text(customer['service'])),
                          ],
                        ),
                      ),
                      subtitle: isExpanded
                          ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRow('Service For:', customer['service_for'] ?? 'N/A'),
                          _buildRow('Name:', customer['name'] ?? 'N/A'),
                          _buildRow('Unit Number:', customer['unit_number'] ?? 'N/A'),
                          //_buildRow('Driver Number:', customer['driver_number'] ?? 'N/A'),
                          _buildRow('Address:', customer['address'] ?? 'N/A'),
                          _buildRow('Remark:', customer['remark'] ?? 'N/A'),
                          _buildRow('Estimate Time:', customer['est_time'] ?? 'N/A'),
                          _buildRow('Estimate Price:', customer['est_price'] ?? 'N/A'),
                          _buildRow('Vendor Name:', customer['vendor_name'] ?? 'N/A'),
                          _buildRow('Vendor Email:', customer['vendor_email'] ?? 'N/A'),
                          _buildRow('Vendor Mobile:', customer['vendor_mobile'] ?? 'N/A'),
                          _buildRow('Vendor Address:', customer['vendor_address'] ?? 'N/A'),

                          Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
                                child:                           _buildRow('Status:', customer['rname'] ?? 'N/A'),
                              ),
                              //krunal edit

                              Positioned(
                                right: 16, // Adjust this value for precise positioning
                                bottom: 8, // Adjust this value as needed
                                child: GestureDetector(
                                  onTap: () {
                                    editVendorRequestStatus(customer['id']);
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
                            ],
                          ),

                        ],
                      )
                          : null,
                      onTap: () {
                        setState(() {
                          _expandedIndex = isExpanded ? null : index;
                        });
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ));
      },
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title),
          const SizedBox(width: 10),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Future<void> editVendorRequestStatus( String id) async{
    print("krunal "+id);
    Get.to(() => const EditVendorRequestStatus(), arguments: id);
  }


}
