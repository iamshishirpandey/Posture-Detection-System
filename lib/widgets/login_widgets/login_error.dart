import 'package:flutter/material.dart';

import 'google_sign_in_button.dart';

class LoginError extends StatelessWidget {
  final String errorMessage;

  const LoginError({
    Key key,
    @required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GoogleSignInButton(),
        SizedBox(height: 16.0),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.pinkAccent,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
