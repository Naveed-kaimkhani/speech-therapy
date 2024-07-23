import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_therapy/presentation/widgets/already_account.dart';
import 'package:speech_therapy/style/styling.dart';

import '../../Login/login_screen.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor:Styling.darkBlue,
            onSaved: (email) {},
            decoration:  InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(16.h),
                child: const Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 16.h),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor:Styling.darkBlue,
              decoration:InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: const Icon(Icons.lock),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () {},
            child: Text("Sign Up".toUpperCase()),
          ),
           SizedBox(height: 16.h),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}