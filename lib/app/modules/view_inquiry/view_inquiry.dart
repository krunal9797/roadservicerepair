import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/view_inquiry/view_inquiry_controller.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';

class ViewInquiryView extends StatefulWidget {
  const ViewInquiryView({super.key});

  @override
  State<ViewInquiryView> createState() => _ViewInquiryViewState();
}

class _ViewInquiryViewState extends State<ViewInquiryView> {

  dynamic viewInquiry;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewInquiryController>(
        init: ViewInquiryController(),
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
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('truck_make :'),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['truck_make']))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('make_other:'),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['make_other']))
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
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['vi_number']))
                              ],
                            ),
                          ),


                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Truck Tire Type :'),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['truck_tire_type']))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' Tire Size :'),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['tire_size']))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Towing_For :'),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['towing_for']))
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
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['email']))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('mobile_no :'),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['mobile_no']))
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
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['address']))
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
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['country_name']))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('State_Name :'),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['state_name']))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('City_Name :'),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['city_name']))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Remark :'),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['remark']))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Created Date :'),
                                SizedBox(
                                  width: 5,
                                ),
                                Expanded(child: Text(viewInquiry['createdon']))
                              ],
                            ),
                          ),



                        ],
                      ),

                      trailing: Wrap(
                        spacing: -16,
                        children: [

                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.redAccent,
                            ),
                            onPressed: () {

                              _.deleteItem(viewInquiry['id']);
                            },
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
