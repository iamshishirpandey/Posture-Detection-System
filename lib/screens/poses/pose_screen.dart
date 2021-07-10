import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:physiotherapy/models/pose.dart';
import 'package:physiotherapy/utils/routes/routeConstants.dart';
import 'package:physiotherapy/utils/ui_constants.dart';

class EachPosePage extends StatefulWidget {
  final Pose pose;

  const EachPosePage({
    Key key,
    @required this.pose,
  }) : super(key: key);

  @override
  _EachPosePageState createState() => _EachPosePageState();
}

class _EachPosePageState extends State<EachPosePage> {
  int currentIndex;

  String poseName;
  String poseSubtitle;
  String poseNameDisplay;
  String poseImageUrl;
  List<String> benefitList;

  @override
  void initState() {
    super.initState();

    poseName = widget.pose.title;
    poseNameDisplay = poseName[0].toUpperCase() + poseName.substring(1);

    poseSubtitle =
        widget.pose.sub[0].toUpperCase() + widget.pose.sub.substring(1);

    benefitList = widget.pose.benefits.split('. ');
    print(widget.pose.image);
    poseImageUrl = widget.pose.image;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: PageScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: screenWidth * 0.8,
                  child: poseImageUrl != null
                      ? Image.network(
                          poseImageUrl,
                        )
                      : Image.asset(
                          'assets/images/triangle.png',
                          fit: BoxFit.fitHeight,
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 16.0),
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Icon(
                    //         Icons.access_time,
                    //         color: Colors.black.withOpacity(0.8),
                    //       ),
                    //       SizedBox(width: 8.0),
                    //       Text(
                    //         '3 minutes',
                    //         style: TextStyle(
                    //           fontSize: 18.0,
                    //           fontWeight: FontWeight.w400,
                    //           letterSpacing: 1,
                    //           color: Colors.black,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        print('Play button tapped !');
                        SystemChrome.setSystemUIOverlayStyle(
                            SystemUiOverlayStyle(
                          statusBarColor: Colors.white,
                          statusBarIconBrightness: Brightness.dark,
                        ));

                        Navigator.of(context)
                            .pushNamed(RouteConstants.PREVIEWSCREEN,
                                arguments: widget.pose)
                            .then((_) {
                          SystemChrome.setSystemUIOverlayStyle(
                              SystemUiOverlayStyle(
                            statusBarColor: Colors.transparent,
                            statusBarIconBrightness: Brightness.dark,
                          ));
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Constants.lightAccent,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 16.0,
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 36.0,
                              ),
                              Text(
                                'Play',
                                // maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    poseNameDisplay,
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    poseSubtitle,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Text(
                    'Some of the benefits of the $poseNameDisplay pose are as follows:',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.6,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: ListView.builder(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: benefitList.length,
                    padding: EdgeInsets.all(0.0),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          // top: 8.0,
                          bottom: 16.0,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '•  ',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.6,
                                color: Colors.black,
                              ),
                            ),
                            Flexible(
                              child: Text(
                                '${benefitList[index]}',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.6,
                                  color: Colors.lightBlue,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark,
                  ));
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
