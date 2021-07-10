import 'package:flutter/material.dart';
import 'package:physiotherapy/authentication/auth_client.dart';
import 'package:physiotherapy/models/user.dart';
import 'package:physiotherapy/utils/database.dart';
import 'package:physiotherapy/utils/ui_constants.dart';
import 'package:physiotherapy/widgets/cards/card_items.dart';
import 'package:physiotherapy/widgets/cards/card_main.dart';
import 'package:physiotherapy/widgets/cards/card_section.dart';
import 'package:physiotherapy/widgets/cards/custom_clipper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<User> userData = Database().retrieveUserInfo();

  @override
  void initState() {
    super.initState();

    // imageUrl = userData.imageUrl;
    // userName = userData.userName;
  }

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: MyCustomClipper(clipType: ClipType.bottom),
            child: Container(
              color: Theme.of(context).accentColor,
              height: Constants.headerHeight + statusBarHeight,
            ),
          ),
          Positioned(
            right: -45,
            top: -30,
            child: ClipOval(
              child: Container(
                color: Colors.black.withOpacity(0.05),
                height: 220,
                width: 220,
              ),
            ),
          ),

          // BODY
          Padding(
            padding: EdgeInsets.all(Constants.paddingSide),
            child: ListView(
              children: <Widget>[
                // Header - Greetings and Avatar
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Hello,\nPatient",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Colors.white),
                      ),
                    ),
                    CircleAvatar(
                        radius: 26.0,
                        backgroundImage:
                            AssetImage('assets/icons/profile_picture.png'))
                  ],
                ),

                SizedBox(height: 50),

                // Main Cards - Heartbeat and Blood Pressure
                Container(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      CardMain(
                        image: AssetImage('assets/icons/heartbeat.png'),
                        title: "Hearbeat",
                        value: "66",
                        unit: "bpm",
                        color: Constants.lightGreen,
                      ),
                      CardMain(
                          image: AssetImage('assets/icons/blooddrop.png'),
                          title: "Blood Pressure",
                          value: "66/123",
                          unit: "mmHg",
                          color: Constants.lightYellow)
                    ],
                  ),
                ),

                // Section Cards - Daily Medication
                SizedBox(height: 50),

                Text(
                  "YOUR DAILY MEDICATIONS",
                  style: TextStyle(
                    color: Constants.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20),

                Container(
                    height: 125,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        CardSection(
                          image: AssetImage('assets/icons/capsule.png'),
                          title: "Metforminv",
                          value: "2",
                          unit: "pills",
                          time: "6-7AM",
                          isDone: false,
                        ),
                        CardSection(
                          image: AssetImage('assets/icons/syringe.png'),
                          title: "Trulicity",
                          value: "1",
                          unit: "shot",
                          time: "8-9AM",
                          isDone: true,
                        )
                      ],
                    )),

                SizedBox(height: 50),

                // Scheduled Activities
                Text(
                  "SCHEDULED ACTIVITIES",
                  style: TextStyle(
                      color: Constants.textPrimary,
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 20),

                Container(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: <Widget>[
                      CardItems(
                        image: Image.asset(
                          'assets/icons/Walking.png',
                        ),
                        title: "Walking",
                        value: "750",
                        unit: "steps",
                        color: Constants.lightYellow,
                        progress: 0,
                      ),
                      CardItems(
                        image: Image.asset(
                          'assets/icons/Swimming.png',
                        ),
                        title: "Swimming",
                        value: "30",
                        unit: "mins",
                        color: Constants.lightBlue,
                        progress: 0,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
