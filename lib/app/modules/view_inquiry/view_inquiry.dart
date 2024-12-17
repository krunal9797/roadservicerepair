import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/view_inquiry/view_inquiry_controller.dart';
import 'package:roadservicerepair/app/utils/LabelValueRow.dart';
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
                          LabelValueRow(
                            label: 'Service For :',
                            value: viewInquiry['service_for'],
                          ),
                          LabelValueRow(
                            label: 'Type :',
                            value: viewInquiry['type'],
                          ),
                          LabelValueRow(
                            label: 'Unit Number :',
                            value: viewInquiry['unit_number'],
                          ),
                          LabelValueRow(
                            label: 'Driver Number :',
                            value: viewInquiry['driver_number'],
                          ),
                          LabelValueRow(
                            label: 'Address :',
                            value: viewInquiry['address'],
                          ),
                          LabelValueRow(
                            label: 'Remark :',
                            value: viewInquiry['remark'],
                          ),
                          LabelValueRow(
                            label: 'Creation :',
                            value: viewInquiry['createdon'],
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
