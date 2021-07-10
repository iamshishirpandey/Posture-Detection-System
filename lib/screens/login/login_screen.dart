import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physiotherapy/application/states/auth_sign_in_state.dart';
import 'package:physiotherapy/providers/providers.dart';
import 'package:physiotherapy/utils/colors.dart';
import 'package:physiotherapy/utils/routes/routeConstants.dart';
import 'package:physiotherapy/widgets/login_widgets/login_error.dart';
import 'package:physiotherapy/widgets/login_widgets/login_initial_widget.dart';
import 'package:physiotherapy/widgets/login_widgets/login_signed_in_widget.dart';
import 'package:physiotherapy/widgets/login_widgets/login_signing_in_widget.dart';
import 'package:websafe_svg/websafe_svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(Palette.loginBackground);
    // FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.005,
            ),
            Hero(
              tag: '',
              child: Text(
                "Physio",
                style: TextStyle(
                  fontFamily: 'TitilliumWeb',
                  fontSize: screenSize.width / 8,
                  color: Colors.black,
                ),
              ),
            ),
            WebsafeSvg.asset(
              'assets/images/cover1.svg',
              width: MediaQuery.of(context).size.width,
              semanticsLabel: 'Cover Image',
            ),

            ProviderListener(
              provider: authSignInNotifierProvider.state,
              onChange: (context, state) async {
                if (state is SignedIn) {
                  FirebaseUser signedInUser = state.user;

                  await Future.delayed(Duration(seconds: 1));

                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: AppColor.nameBackground,
                    statusBarIconBrightness: Brightness.dark,
                  ));
                  context.read(storeUserDataNotifierProvider).storeData(
                        uid: signedInUser.uid,
                        imageUrl: signedInUser.photoUrl,
                        userName: signedInUser.displayName,
                      );
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(
                          RouteConstants.HOMEPAGE, (_) => false)
                      .then((_) {
                    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                      statusBarColor: Colors.yellowAccent,
                      statusBarIconBrightness: Brightness.dark,
                    ));
                  });
                }
              },
              child: Consumer(
                builder: (context, watch, child) {
                  final state = watch(
                    authSignInNotifierProvider.state,
                  );

                  return state.when(
                    () => LoginInitialWidget(),
                    signingIn: () => LoginSignningInWidget(),
                    signedIn: (_) => LoginSignedInWidget(),
                    error: (message) => LoginError(errorMessage: message),
                  );
                },
              ),
            )
            // _googleSignInButton(),
          ],
        ),
      ),
    );
  }
}
