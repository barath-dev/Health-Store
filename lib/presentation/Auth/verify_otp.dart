import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hospital/core/theme/theme_helper.dart';
import 'package:hospital/core/utils/size_utils.dart';
import 'package:hospital/core/utils/snack_bar.dart';
import 'package:hospital/data/auth_repository.dart';

import '../../widgets/custom_elevated_button.dart';

class OtpVerificationPage extends StatefulWidget {
  final ContactNumber contactNumber;
  const OtpVerificationPage(this.contactNumber, {super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  bool isResendEnabled = false;
  late Timer _timer;
  int _start = 180; // Countdown duration in seconds

  void showSuccessBar() {
    SnackBarUtils.showFlushBarSuccess(context, "OTP verified successfully");
  }

  void showFailureBar() {
    SnackBarUtils.showFlushBarFailure(context, "Failed to verify OTP");
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void startTimer() {
    setState(() {
      _start = 180;
      isResendEnabled = false;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          isResendEnabled = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: SizeUtils.height,
          width: double.maxFinite,
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
              Align(
                alignment: Alignment.center,
                child: CustomImageView(
                  imagePath: ImageConstants.logo,
                  height: 151.v,
                  width: 125.h,
                ),
              ),
              SizedBox(height: 41.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter Verification Code",
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 15.v),
              Text("A 4-digit code has been sent to"),
              const SizedBox(height: 5),
              Row(children: [
                Text(
                  "${widget.contactNumber.countryCode} ${widget.contactNumber.number}",
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(width: 5),
                InkWell(
                  onTap: () => {
                    NavigatorService.pushNamedAndRemoveUntil(
                        AppRoutes.loginPage)
                  },
                  child: const Icon(
                    Icons.edit_rounded,
                    color: Color.fromRGBO(43, 120, 101, 1),
                    size: 24,
                  ),
                ),
              ]),
              SizedBox(height: 7.v),
              // Pin code
              SizedBox(
                height: 70.v,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildTextField(focusNode1, controller1, focusNode2),
                    buildTextField(
                        focusNode2, controller2, focusNode3, focusNode1),
                    buildTextField(
                        focusNode3, controller3, focusNode4, focusNode2),
                    buildTextField(focusNode4, controller4, null, focusNode3),
                  ],
                ),
              ),
              SizedBox(height: 7.v),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Didn't receive OTP?"),
                  TextButton(
                    onPressed: isResendEnabled
                        ? () async {
                            await AuthRepository.sendOTP(
                              widget.contactNumber.number,
                              widget.contactNumber.countryCode,
                            ).then((value) {
                              if (value) {
                                SnackBarUtils.showFlushBarSuccess(
                                    context, "Successfully sent OTP");
                                startTimer();
                              }
                            }).catchError((e) {
                              SnackBarUtils.showFlushBarFailure(
                                  context, "Failed to Re-send OTP");
                            });
                          }
                        : null,
                    child: Text("Resend (${isResendEnabled ? "now" : _start})"),
                  ),
                ],
              ),
              const Spacer(),
              CustomElevatedButton(
                onPressed: () async {
                  var otp = controller1.text.trim() +
                      controller2.text.trim() +
                      controller3.text.trim() +
                      controller4.text.trim();
                  var responseMsg = await AuthRepository.verifyOtp(
                    otp,
                    widget.contactNumber.number,
                    widget.contactNumber.countryCode,
                  );
                  if (responseMsg != "failed") {
                    if (responseMsg == "newUser") {
                      NavigatorService.pushNamed(
                        AppRoutes.userIntrestsPage,
                      );
                    } else {
                      NavigatorService.pushNamedAndRemoveUntil(
                        AppRoutes.homePage,
                      );
                    }
                    showSuccessBar();
                  } else {
                    showFailureBar();
                  }
                },
                text: "Verify OTP",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(FocusNode focusNode, TextEditingController controller,
      FocusNode? nextFocusNode,
      [FocusNode? prevFocusNode]) {
    return SizedBox(
      height: 65.v,
      width: 64.h,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        autofocus: true,
        onSaved: (newValue) {},
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.h),
          ),
        ),
        textAlign: TextAlign.center,
        style: theme.textTheme.titleLarge!.copyWith(color: Colors.black),
        onChanged: (value) {
          if (value.length == 1) {
            nextFocusNode != null
                ? FocusScope.of(context).requestFocus(nextFocusNode)
                : FocusScope.of(context).unfocus();
          } else if (value.isEmpty && prevFocusNode != null) {
            FocusScope.of(context).requestFocus(prevFocusNode);
          }
        },
      ),
    );
  }
}
