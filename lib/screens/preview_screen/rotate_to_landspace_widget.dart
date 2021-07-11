import 'package:flutter/material.dart';

class RotateToLandscapeWidget extends StatelessWidget {
  const RotateToLandscapeWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  text: 'Please rotate your device to the ',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  children: [
                    TextSpan(
                      text: 'landscape mode.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Text(
                      'Rotate to the right',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontFamily: '',
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Icon(Icons.arrow_forward_rounded),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
