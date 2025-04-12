import 'package:adwise/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({
    super.key,
    required this.formKey, required bool isPhoneLogin,
  });

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            onSaved: (emal) {
              // Email
            },
            validator: emaildValidator.call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email address",
              prefixIcon: Padding(
                  padding:  EdgeInsets.symmetric(
                      vertical: AppConstants.defaultPadding * 0.75),
                  child: Icon(
                    PhosphorIcons.envelopeSimpleOpen(PhosphorIconsStyle.regular),
                  )
                  ),
            ),
          ),
           SizedBox(height: AppConstants.defaultPadding),
          TextFormField(
            onSaved: (pass) {
              // Password
            },
            validator: passwordValidator.call,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: Padding(
                padding:
                     EdgeInsets.symmetric(vertical: AppConstants.defaultPadding * 0.75),
                child: Icon(
                  PhosphorIcons.password(
                      PhosphorIconsStyle.regular),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
