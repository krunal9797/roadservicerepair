import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/vendor_request/vendor_request_controller.dart';
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
              :ListView.builder(
            itemCount: _.arr.length,
            itemBuilder: (context, index) {
              final vendor = _.arr[index];
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

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('vendor_email:'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['vendor_email']))
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
                                  Expanded(child: Text(vendor['email']))
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('service :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['service']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('truck_make :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['truck_make']))
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
                                  Expanded(child: Text(vendor['make_other']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('vi_number :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['vi_number']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('tire_type :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['tire_type']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('tire_size :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['tire_size']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('towing_for :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['towing_for']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('vendor_mobile :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['vendor_mobile']))
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
                                  Expanded(child: Text(vendor['address']))
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
                                  Expanded(child: Text(vendor['country_name']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('cust_mobileno :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['cust_mobileno']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('cust_address :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['cust_address']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('remark :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['remark']))
                                ],
                              ),
                            ),


                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('state_name :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['state_name']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('city_name :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['city_name']))
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('rname :'),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(child: Text(vendor['rname']))
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
                                  Expanded(child: Text(vendor['est_time']))
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
                                  Expanded(child: Text(vendor['est_price']))
                                ],
                              ),
                            )



                          ],
                        ),
                        // trailing: IconButton(
                        //   icon: Icon(Icons.edit,size: 40,color: Colors.red,),
                        //   onPressed: () {
                        //      String id = vendor['id'];
                        //     _.editInquiry(id);
                        //   },
                        // ),
                        // IconButton(
                        //   icon: const Icon(
                        //     Icons.delete,
                        //     size: 30,
                        //     color: Colors.redAccent,
                        //   ),
                        //   onPressed: () {
                        //
                        //     _.deleteItem(viewInquiry['id']);
                        //   },
                        // )

              trailing: Wrap(
              spacing: -16,
              children: [

              IconButton(
              icon: Icon(Icons.edit,size: 40,color: Colors.red,),
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
