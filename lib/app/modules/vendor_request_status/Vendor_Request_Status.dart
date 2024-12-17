import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
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
              setRegularText("No customers found.", AppColors.titleText, 14)
            ],
          ),
        )
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
                          _buildRow('Service For :', customer['service_for']),
                          _buildRow('Type :', customer['type']),
                          _buildRow('Name :', customer['name']),
                          _buildRow('Unit Number :', customer['unit_number']),
                          _buildRow('Driver Number :', customer['driver_number']),
                          _buildRow('Address :', customer['address']),
                          _buildRow('Remark :', customer['remark']),
                          _buildRow('Estimate Time :', customer['est_time']),
                          _buildRow('Estimate Price :', customer['est_price']),
                          _buildRow('Vendor Name :', customer['vendor_name']),
                          _buildRow('Vendor Email :', customer['vendor_email']),
                          _buildRow('Vendor Mobile :', customer['vendor_mobile']),
                          _buildRow('Vendor Address :', customer['vendor_address']),
                          _buildRow('Status:', customer['rname']),
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
}
