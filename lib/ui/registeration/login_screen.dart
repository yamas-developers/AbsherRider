import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../api/mj_api_service.dart';
import '../../api/mj_apis.dart';
import '../../config/mj_config.dart';
import '../../helpers/constants.dart';
import '../../helpers/public_methods.dart';
import '../../helpers/route_constants.dart';
import '../../helpers/session_helper.dart';
import '../../providers/user/user_provider.dart';
import '../common_widgets/rounded_center_button.dart';
import '../common_widgets/rounded_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkBoxValue = false;

  TextEditingController phoneCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  bool isLoading = false;
  String emailErrorText = '';
  String passwordErrorText = '';

  bool customerSelected = true;
  bool shouldSubmit = true;

  void onBoxChanged(val) {
    setState(() {
      checkBoxValue = val;
    });
  }

  submit() async {
    emailErrorText = '';
    passwordErrorText = '';
    shouldSubmit = true;

    if (phoneCtrl.text.isEmpty || phoneCtrl.text.trim() == '') {
      setState(() {
        emailErrorText = 'Please enter phone';
      });
      shouldSubmit = false;
    }
    if (passwordCtrl.text.isEmpty) {
      setState(() {
        passwordErrorText = 'Password can not be empty';
      });
      shouldSubmit = false;
    }

    if (passwordCtrl.text.isNotEmpty) {
      if (passwordCtrl.text.length < 8) {
        passwordErrorText = 'Your Password:';
        setState(() {
          passwordErrorText += '\n - Is not 8 characters long';
        });
        shouldSubmit = false;
      }
    }

    if (shouldSubmit) {
      MjApiService apiService = MjApiService();
      dynamic payload = {
        "password": passwordCtrl.text,
        "phone": phoneCtrl.text,
      };
      log("payload here: ${payload}");
      try {
        await setSession(null); //////temporary
        showProgressDialog(context, MJConfig.please_wait, isDismissable: false);
        dynamic response = await apiService.postRequest(MJ_Apis.login, payload);
        if (response != null) {
          await setSession(response["response"]["token"]);
          showToast(response['message']);
          UserProvider userProvider = context.read<UserProvider>();
          await userProvider.fetchUser();
          hideProgressDialog(context);
          if (userProvider.isLogin)
            Navigator.pushNamedAndRemoveUntil(
                context, main_screen, (val) => false);
          else {
            Navigator.pushReplacementNamed(context, login_screen);
          }
        } else {
          hideProgressDialog(context);
          showToast(getString("login_failed"));
        }
      } catch (e) {
        hideProgressDialog(context);
        log("error in login screen: ${e}");
      } finally {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: getWidth(context),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: getHeight(context) * 0.05,
              ),
              Image.asset(
                'assets/images/app_logo.png',
                width: 120,

                // height: 140,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                getString("auth_sign_in_continue"),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: lightModeOn(context) ? mediumGreyFontColor : lighterGreyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 30,
              ),
              RoundedTextField(
                label: getString("auth__phone"),
                icon: Icons.phone,
                errorText: emailErrorText,
                controller: phoneCtrl,
              ),
              SizedBox(
                height: 2,
              ),
              RoundedTextField(
                controller: passwordCtrl,
                label: getString("auth__password"),
                icon: Icons.lock,
                errorText: passwordErrorText,
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 26,
                  ),
                  Checkbox(
                    shape: CircleBorder(),
                    value: checkBoxValue,
                    onChanged: onBoxChanged,
                    checkColor: mainColor,
                  ),
                  Text(
                    getString("auth__remember_me"),
                    style: TextStyle(
                        color: lightModeOn(context) ? darkGreyColor : lighterGreyColor, fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(
                height: 0,
              ),
              // Spacer(),

              RoundedCenterButtton(
                  onPressed: () {
                    // Navigator.pushNamed(context, "home_screen");
                    submit();
                  },
                  title: getString("auth__login")),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    getString("auth__forgot_password"),
                    style: TextStyle(
                        color: lightModeOn(context) ? mainColor : mainColorLightest, fontWeight: FontWeight.w500),
                  )),

              // Text(
              //   getString("auth__login_with"),
              //   style: TextStyle(
              //       color: lightModeOn(context) ? mediumGreyColor : lighterGreyColor, fontWeight: FontWeight.w500),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // RoundedSocialMediaButtton(
              //   onPressed: () {},
              //   title: getString("auth__continue_fb"),
              //   imageIcon: "assets/icons/facebook_icon.png",
              //   color: facebookColor,
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // RoundedSocialMediaButtton(
              //   onPressed: () {},
              //   title: getString("auth__continue__google"),
              //   imageIcon: "assets/icons/google_icon.png",
              //   color: googleColor,
              // ),
              // SizedBox(
              //   height: 15,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    getString("auth__do_not_have_account"),
                    style: TextStyle(
                        color: lightModeOn(context) ? Colors.black : lighterGreyColor, fontWeight: FontWeight.w400, fontSize: 15),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, "signup_screen");
                      },
                      child: Text(
                        getString("auth__sign_up"),
                        style: TextStyle(
                            color: lightModeOn(context) ? mainColor : mainColorLight, fontWeight: FontWeight.w500),
                      )),
                ],
              ),

              // SizedBox(
              //   height: getHeight(context) * 0.15,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
