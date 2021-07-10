import 'package:flutter/material.dart';
import 'package:physiotherapy/authentication/auth_client.dart';
import 'package:physiotherapy/models/user.dart';
import 'package:physiotherapy/utils/database.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String imageUrl;
  String userName = "Shishir";

  @override
  void initState() {
    super.initState();
    User userData = Database.user;
    print(userData.userName);
    // imageUrl = userData.imageUrl;
    // userName = userData.userName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 4,
              centerTitle: false,
              pinned: true,
              title: Text(
                'Hello, $userName ',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              actions: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Container(
                            color: Colors.black12,
                            child: Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.person,
                                color: Colors.black12,
                                size: 26,
                              ),
                            ),
                          ),
                        ),
                        imageUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: SizedBox(
                                  width: 38.0,
                                  child: Image.network(imageUrl),
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      'Inhale the future, exhale the past.', // Update the quote from backend
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 2,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Icon(
                              Icons.privacy_tip,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Privacy policy', // Update the quote from backend
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.email,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Contact us', // Update the quote from backend
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          children: [
                            Icon(
                              Icons.info,
                              color: Colors.black.withOpacity(0.6),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'About', // Update the quote from backend
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            AuthenticationClient().signOutGoogle();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              SizedBox(width: 8.0),
                              Text(
                                'LOGOUT', // Update the quote from backend
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
