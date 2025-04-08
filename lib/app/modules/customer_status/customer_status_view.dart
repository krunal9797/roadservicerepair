import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/utils/LabelValueRow.dart';
import 'customer_status_controller.dart';

class CustomerStatusView extends StatelessWidget {
  const CustomerStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerStatusController());

    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.customerInfo.isEmpty) {
          return const Center(child: Text("No customer data found."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: controller.customerInfo.length,
          itemBuilder: (context, index) {
            var item = controller.customerInfo[index];

            return Card(
              color:  item['cust_email'] != null && item['cust_email'].isNotEmpty
                  ? Colors.greenAccent.withOpacity(0.2) // Color when email exists
                  : Colors.redAccent.withOpacity(0.2), // Color when email is empty
              child:ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('service :'),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(child: Text(item['service']))
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item['cust_email'] != null && item['cust_email'].isNotEmpty)
                      LabelValueRow(
                        label: 'Email :',
                        value: item['cust_email'] ?? 'N/A',
                      ),
                    LabelValueRow(
                      label: 'Name :',
                      value: item['name'] ?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Driver Number :',
                      value: item['driver_number']?? 'N/A',
                    ),

                    LabelValueRow(
                      label: 'Service For :',
                      value: item['service_for']?? 'N/A',
                    ),

                    LabelValueRow(
                      label: 'Unit Number :',
                      value: item['unit_number']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Driver Number :',
                      value: item['driver_number']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Address :',
                      value: item['address']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Remark :',
                      value: item['remark']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Est Time :',
                      value: item['est_time']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Est Price :',
                      value: item['est_price']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Vendor Name :',
                      value: item['vendor_name']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Vendor Email :',
                      value: item['vendor_email']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Vendor Mobile :',
                      value: item['vendor_mobile']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Vendor Address :',
                      value: item['vendor_address']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'Reason :',
                      value: item['reason']?? 'N/A',
                    ),
                    LabelValueRow(
                      label: 'status :',
                      value: item['sta_tus']?? 'N/A',
                    ),

                  ],
                ),

                // trailing: Wrap(
                //   spacing: -16,
                //   children: [
                //
                //     IconButton(
                //       icon: const Icon(
                //         Icons.delete,
                //         size: 30,
                //         color: Colors.redAccent,
                //       ),
                //       onPressed: () {
                //         //_.deleteItem(item['id']);
                //       },
                //     ),
                //   ],
                // ),

              ),
            );
          },
        );
      }),
    );
  }
}
