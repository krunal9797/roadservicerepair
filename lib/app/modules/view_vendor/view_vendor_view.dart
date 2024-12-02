import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/view_vendor/view_vendor_controller.dart';
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name :'),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(child: Text(customer['name']))
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
                                Expanded(child: Text(customer['mobile_no']))
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
                                Expanded(child: Text(customer['address']))
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
                          )


                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete,size: 40,color:Colors.red,),
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
