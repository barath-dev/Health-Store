import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'package:hospital/core/utils/size_utils.dart';
import 'package:hospital/core/utils/snack_bar.dart';

import 'package:hospital/data/auth_repository.dart';
import 'package:hospital/presentation/Auth/verify_otp.dart';
import 'package:hospital/widgets/custom_checkbox.dart';
import 'package:hospital/widgets/custom_elevated_button.dart';
import 'package:hospital/widgets/custom_textfield.dart';

import '../../core/theme/theme_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool termsAndCondition = false;
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  String countryCode = "+91";

  void showSuccessBar() {
    SnackBarUtils.showFlushBarSuccess(context, "OTP sent successfully");
  }

  void showFailureBar() {
    SnackBarUtils.showFlushBarFailure(context, "Failed to send OTP");
  }

  @override
  Widget build(BuildContext context) {
    print("LoginScreen");
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.maxFinite,
          height: SizeUtils.height,
          padding: EdgeInsets.only(
            left: 20.h,
            top: 100.v,
            right: 20.h,
            bottom: 20.v,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 41.v),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Login",
                ),
              ),
              SizedBox(height: 15.v),
              const Text(
                "Contact number",
              ),
              SizedBox(height: 7.v),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Text(
                  //   countryCode,
                  //   style: theme.textTheme.titleSmall,
                  // ),
                  CountryCodePicker(
                    onChanged: (value) {
                      // setState(() {
                      if (value.dialCode != null) countryCode = value.dialCode!;
                      // });
                    },
                    // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                    initialSelection: 'IN',
                    favorite: const ['IN', 'US'],
                    // optional. Shows only country name and flag
                    showCountryOnly: false,
                    // optional. Shows only country name and flag when popup is closed.
                    showOnlyCountryWhenClosed: false,
                    // optional. aligns the flag and the Text left
                    alignLeft: false,
                  ),
                  Expanded(
                    child: CustomTextFormField(
                      controller: _controller,
                      hintText: "Enter your contact number",
                      textInputType: TextInputType.number,
                      onSubmitted: (value) {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: 7.v),
              // _buildCheckmark(context),
              Row(
                children: [
                  Checkbox(
                      value: termsAndCondition,
                      onChanged: (value) {
                        setState(() {
                          termsAndCondition = value!;
                        });
                      }),
                  RichText(
                      maxLines: 3,
                      text: TextSpan(
                        text: "I agree to the ",
                        style: theme.textTheme.titleSmall,
                        children: [
                          TextSpan(
                            text: " and ",
                            style: theme.textTheme.titleSmall,
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(height: 7.v),
              const Spacer(),
              CustomElevatedButton(
                isDisabled: !termsAndCondition,
                onPressed: () async {
                  var contactNumber = ContactNumber(
                    countryCode: countryCode,
                    number: _controller.text.trim(),
                  );

                  await AuthRepository.sendOTP(
                          _controller.text.trim(), countryCode)
                      .then((res) {
                    if (res) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              OtpVerificationPage(contactNumber),
                        ),
                      );
                      showSuccessBar();
                    }
                    return;
                  }).catchError((err) {
                    SnackBarUtils.showFlushBarFailure(context, err.toString());
                  });
                  //debugPrint(res.toString());
                },
                text: "Send OTP",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckmark(BuildContext context) {
    return CustomCheckboxButton(
      text: "I agree to Terms and Condition and\nPrivacy Policy",
      isExpandedText: true,
      value: termsAndCondition,
      textStyle: theme.textTheme.titleSmall,
      onChange: (value) {
        setState(() {
          termsAndCondition = value;
        });
      },
    );
  }
}

class ContactNumber {
  final String countryCode;
  final String number;

  ContactNumber({
    required this.countryCode,
    required this.number,
  });
}
