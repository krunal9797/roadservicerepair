import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roadservicerepair/app/constants/app_colors.dart';
import 'package:roadservicerepair/app/modules/forgot_password/forgot_password_controller.dart';
import 'package:roadservicerepair/app/utils/button_utl.dart';
import 'package:roadservicerepair/app/utils/text_field_utl.dart';
import 'package:roadservicerepair/app/utils/text_utl.dart';
import 'package:http/http.dart' as http;

import '../../constants/Api.dart';
import '../../utils/shake_widget.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  //Controller
  TextEditingController txtEmail = TextEditingController();

  //FocusNode
  FocusNode fnEmail = FocusNode();

  //Shake Key
  final isEmail = GlobalKey<ShakeWidgetState>();


  submit() async {
    final email = txtEmail.text.toString().trim();
    // pankilpatel.cmpicamcal15@gmail.com
    print(""+email);
    if (email.isEmpty ) {
      Get.snackbar("Error", "Please enter email");
      return;
    }


    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST',  Uri.parse(Api.FORGETPASSWORD));
    request.body = json.encode({
      "email": ""+email
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      Map<String, dynamic> parsedResponse = json.decode(responseBody);
      // Handle the parsed response
      handleResponse(parsedResponse);

    }
    else {
      print(response.reasonPhrase);
    }

  }
  void handleResponse(Map<String, dynamic> response) {
    if (response['status'] == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successful')),

      );
      Navigator.pop(context);

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('failed')),

      );

      Navigator.pop(context);
      // Handle other status codes or success
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
            bottom: false,
            top: false,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: AppColors.whiteText,
                  surfaceTintColor: AppColors.whiteText,
                  title:
                      setSemiText("Forgot Password", AppColors.titleText, 16),
                ),
                backgroundColor: AppColors.primary,
                body: ListView(
                  children: [
                    const SizedBox(height: 40),

                    //TextField

                    setTextField(context, "Email", "Enter Email", isEmail,
                        txtEmail, fnEmail),

                    const SizedBox(height: 20),

                    Center(
                      child: setButton(
                          () => {
                            submit()

                          },
                          setSemiText("Submit", AppColors.whiteText, 16),
                          AppColors.button,
                          200,
                          50),
                    ),
                  ],
                )),
          );

  }
}
