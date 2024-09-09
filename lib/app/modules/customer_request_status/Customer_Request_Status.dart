import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:roadservicerepair/app/modules/customer_request_status/Customer_Request_Status_Controller.dart';

import '../../constants/app_colors.dart';
import '../../utils/text_utl.dart';

class CustomerRequestStatus extends StatefulWidget {
  const CustomerRequestStatus({super.key});

  @override
  State<CustomerRequestStatus> createState() => _CustomerRequestStatusState();
}

class _CustomerRequestStatusState extends State<CustomerRequestStatus> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<Customer_Request_Status_Controller>(
        init: Customer_Request_Status_Controller(),
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
                    "No customers found.", AppColors.titleText, 14)
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
                    child:ListTile(

                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Service :'),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(child: Text(customer['service']))
                            ],
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('truck_make :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(customer['truck_make']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('make_other :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(customer['make_other']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Email :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(customer['email']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Mobile_no :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(customer['cust_mobileno']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Address :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(customer['cust_address']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Country :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(customer['country_name']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Time :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(customer['est_time']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Estimate Price :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(customer['est_price']))
                                ],
                              ),
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
