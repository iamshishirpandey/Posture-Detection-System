import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:physiotherapy/authentication/auth_client.dart';
import 'package:physiotherapy/models/user.dart';
import 'package:physiotherapy/providers/providers.dart';
import 'package:physiotherapy/utils/database.dart';
import 'package:physiotherapy/utils/ui_constants.dart';
import 'package:physiotherapy/widgets/cards/card_items.dart';
import 'package:physiotherapy/widgets/cards/card_main.dart';
import 'package:physiotherapy/widgets/cards/card_section.dart';
import 'package:physiotherapy/widgets/cards/custom_clipper.dart';
import 'package:physiotherapy/widgets/dashboard_widgets/poses_list/poses_list_error_widget.dart';
import 'package:physiotherapy/widgets/dashboard_widgets/poses_list/poses_list_initial_widget.dart';
import 'package:physiotherapy/widgets/dashboard_widgets/poses_list/poses_list_loading_widget.dart';
import 'package:physiotherapy/widgets/dashboard_widgets/poses_list/poses_list_widget.dart';

import '../../local_notifications_helper.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<User> userData = Database().retrieveUserInfo();
  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();

    final settingsAndroid = AndroidInitializationSettings('app_icon');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(settingsAndroid, settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
            child: FutureBuilder(
              future: userData,
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    children: <Widget>[
                      // Header - Greetings and Avatar
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Hello,\n${snapshot.data.userName}",
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white),
                            ),
                          ),
                          CircleAvatar(
                              radius: 26.0,
                              backgroundImage:
                                  NetworkImage(snapshot.data.imageUrl))
                        ],
                      ),

                      SizedBox(height: 50),
                      Container(
                        height: 80,
                      ),
                      // // Main Cards - Heartbeat and Blood Pressure
                      Container(
                        height: 140,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            CardMain(
                              image: AssetImage('assets/icons/heartbeat.png'),
                              title: "Activities",
                              value: "1",
                              unit: "daily",
                              color: Constants.lightGreen,
                            ),
                            CardMain(
                                image: AssetImage('assets/icons/blooddrop.png'),
                                title: "Average Accuracy",
                                value: "95.0",
                                unit: "%",
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
                                isDone: false,
                              )
                            ],
                          )),

                      SizedBox(height: 50),

                      // Scheduled Activities
                      InkWell(
                        onTap: () => showOngoingNotification(notifications,
                            title: 'Medicine Time',
                            body: 'You have morphin to take! :)'),
                        child: Text(
                          "SCHEDULED ACTIVITIES",
                          style: TextStyle(
                              color: Constants.textPrimary,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16.0,
                          right: 16.0,
                          bottom: 30.0,
                        ),
                        child: Consumer(
                          builder: (context, watch, child) {
                            final state = watch(
                              retrievePosesNotifierProvider.state,
                            );

                            return state.when(
                              () {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  context
                                      .read(retrievePosesNotifierProvider)
                                      .retrievePoses();
                                });
                                return PosesListInitialWidget();
                              },
                              retrieving: () => PosesListLoadingWidget(),
                              retrieved: (poses) => PosesListWidget(
                                poses: poses,
                              ),
                              error: (message) => PosesListErrorWidget(),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
