import 'package:flutter/material.dart';
import 'package:physiotherapy/screens/Homepage/homepage_screen.dart';
import 'package:physiotherapy/screens/dashboard/dashboard.dart';
import 'package:physiotherapy/screens/details/details_screen.dart';
import 'package:physiotherapy/screens/login/login_screen.dart';
import 'package:physiotherapy/screens/poses/pose_screen.dart';
import 'package:physiotherapy/screens/previewScreen/preview_screen.dart';

import 'fadeInRouteAnimation.dart';
import 'routeConstants.dart';

Route onGenerateRoute(RouteSettings settings) {
  Route page;
  switch (settings.name) {
    case RouteConstants.LOGIN:
      page = FadeInRoute(routeName: settings.name, page: LoginScreen());
      break;
    case RouteConstants.HOMEPAGE:
      page = FadeInRoute(routeName: settings.name, page: Homepage());
      break;
    case RouteConstants.DASHBOARD:
      page = FadeInRoute(routeName: settings.name, page: Dashboard());
      break;
    case RouteConstants.PREVIEWSCREEN:
      page = FadeInRoute(
          routeName: settings.name,
          page: PreviewScreen(
            pose: settings.arguments,
          ));
      break;
    case RouteConstants.POSEDESCRIPTION:
      page = FadeInRoute(
          routeName: settings.name,
          page: EachPosePage(
            pose: settings.arguments,
          ));
      break;
    case RouteConstants.PRODUCTDESCRIPTION:
      page = FadeInRoute(
          routeName: settings.name,
          page: DetailsScreen(
            product: settings.arguments,
          ));
      break;
    default:
      page = FadeInRoute(routeName: settings.name, page: LoginScreen());
  }
  return page;
}
