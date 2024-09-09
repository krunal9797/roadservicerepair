import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../utils/text_utl.dart';
import 'Viewvendor_Inquiry_Controller.dart';

class ViewvendorInquiry extends StatefulWidget {
  const ViewvendorInquiry({super.key});

  @override
  State<ViewvendorInquiry> createState() => _ViewvendorInquiryState();
}

class _ViewvendorInquiryState extends State<ViewvendorInquiry> {
  int? _expandedIndex = 0; // Track the expanded index

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewvendorInquiryController>(
      init: ViewvendorInquiryController(),
      builder: (controller) {
        return Obx(() {
          if (controller.arr.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 20),
                  Icon(Icons.error_outline,
                      size: 50, color: AppColors.detailText),
                  setRegularText("No inquiry found.", AppColors.titleText, 14),
                ],
              ),
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: controller.arr.length,
              itemBuilder: (context, index) {
                final viewInquiry = controller.arr[index];
                final isExpanded = _expandedIndex == index;
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    children: [
                      ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Service:'),
                              SizedBox(width: 10),
                              Expanded(child: Text(viewInquiry['service'])),
                            ],
                          ),
                        ),
                        subtitle: isExpanded
                            ? Stack(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      _buildRow('Truck Tire Type:',
                                          viewInquiry['truck_tire_type']),
                                      _buildRow('Tire Size:',
                                          viewInquiry['tire_size']),
                                      _buildRow('Towing For:',
                                          viewInquiry['towing_for']),
                                      _buildRow('Truck Make:',
                                          viewInquiry['truck_make']),
                                      _buildRow('Make Other:',
                                          viewInquiry['make_other']),
                                      _buildRow('Vi Number:',
                                          viewInquiry['vi_number']),
                                      _buildRow('Country:',
                                          viewInquiry['country_name']),
                                      _buildRow('State Name:',
                                          viewInquiry['state_name']),
                                      _buildRow('City Name:',
                                          viewInquiry['city_name']),
                                      _buildRow(
                                          'Remark:', viewInquiry['remark']),
                                    ],
                                  ),
                                  Positioned(
                                    right: -10,
                                      bottom: 10,
                                      child: Column(
                                    children: [
                                      if (viewInquiry['sta_tus'] == "0")
                                        IconButton(
                                          icon: Icon(Icons.edit,
                                              size: 30,
                                              color: Colors.redAccent),
                                          onPressed: () {
                                            controller.editInquiry(
                                                viewInquiry['id'].toString());
                                          },
                                        )
                                    ],
                                  ))
                                ],
                              )
                            : null,
                        onTap: () {
                          setState(() {
                            _expandedIndex = isExpanded ? null : index;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        });
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
