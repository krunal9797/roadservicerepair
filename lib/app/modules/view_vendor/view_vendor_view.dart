import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/view_vendor/view_vendor_controller.dart';
import 'package:roadservicerepair/app/utils/DetailRow.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

class VendorsView extends StatefulWidget {
  const VendorsView({super.key});

  @override
  State<VendorsView> createState() => _VendorsViewState();
}

class _VendorsViewState extends State<VendorsView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VendorsController>(
        init: VendorsController(),
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
                          "No vendors found.", AppColors.titleText, 14)
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: _.arr.length,
                  itemBuilder: (context, index) {
                    final customer = _.arr[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(8.0),
                              // child: Row(
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     Text('Name :'),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     Expanded(child: Text(customer['name']))
                              //   ],
                              // ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DetailRow(
                                  label: 'Type :',
                                  value: customer['type'],
                                ),
                                DetailRow(
                                  label: 'Customer Type :',
                                  value: customer['cust_type'],
                                ),
                                DetailRow(
                                  label: 'Working Hours :',
                                  value: customer['working_hours'],
                                ),
                                DetailRow(
                                  label: 'Company Name :',
                                  value: customer['company_name'],
                                ),
                                DetailRow(
                                  label: 'Contact Person :',
                                  value: customer['contact_person'],
                                ),
                                DetailRow(
                                  label: 'Service Type :',
                                  value: customer['service_type'],
                                ),
                                DetailRow(
                                  label: 'Mobile No :',
                                  value: customer['mobile_no'],
                                ),
                                DetailRow(
                                  label: 'Country :',
                                  value: customer['country'],
                                ),
                                // DetailRow(
                                //   label: 'Country :',
                                //   value: customer['country'],
                                // ),
                                // DetailRow(
                                //   label: 'State :',
                                //   value: customer['state'],
                                // ),
                                // DetailRow(
                                //   label: 'City :',
                                //   value: customer['city'],
                                // ),

                                DetailRow(
                                  label: 'Address :',
                                  value: customer['address'],
                                ),
                                DetailRow(
                                  label: 'Email :',
                                  value: customer['email'],
                                ),
                                DetailRow(
                                  label: 'Country Name :',
                                  value: customer['country_name'],
                                ),
                                DetailRow(
                                  label: 'Country Name :',
                                  value: customer['country_name'],
                                ),
                                DetailRow(
                                  label: 'State Name :',
                                  value: customer['state_name'],
                                ),
                                DetailRow(
                                  label: 'City Name :',
                                  value: customer['city_name'],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                size: 40,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                _.deleteItem(customer['u_id']);
                              },
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
