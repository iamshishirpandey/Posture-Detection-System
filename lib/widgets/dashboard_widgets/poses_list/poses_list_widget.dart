import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:physiotherapy/models/pose.dart';
import 'package:physiotherapy/utils/routes/routeConstants.dart';
import 'package:physiotherapy/utils/ui_constants.dart';
import 'package:physiotherapy/widgets/cards/card_items.dart';
import 'package:physiotherapy/widgets/common/custom_widgets.dart';

class PosesListWidget extends StatelessWidget {
  final List<Pose> poses;

  const PosesListWidget({
    Key key,
    @required this.poses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: poses.length,
      separatorBuilder: (context, index) => SizedBox(
        height: 32.0,
      ),
      itemBuilder: (_, index) {
        Pose pose = poses[index];
        String poseTitle = pose.title;
        String poseSubtitle = pose.sub;
        String videoUrl = pose.videoUrl;
        String poseBenefits = pose.benefits;

        return InkWell(
          onTap: () {
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
            ));

            Navigator.of(context)
                .pushNamed(RouteConstants.POSEDESCRIPTION, arguments: pose);
          },
          child: CardItems(
            image: Image.asset(
              'assets/icons/sukhasana.png',
              height: 35,
              width: 35,
            ),
            title: poseTitle,
            value: poseSubtitle,
            unit: "",
            color: Constants.lightYellow,
            progress: 0,
          ),
        );
      },
    );
  }
}
