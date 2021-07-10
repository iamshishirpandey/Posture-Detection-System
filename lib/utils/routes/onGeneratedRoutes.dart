import 'package:flutter/material.dart';
import 'package:physiotherapy/screens/dashboard/dashboard.dart';
import 'package:physiotherapy/screens/login/login_screen.dart';

import 'fadeInRouteAnimation.dart';
import 'routeConstants.dart';

Route onGenerateRoute(RouteSettings settings) {
  Route page;
  switch (settings.name) {
    case RouteConstants.LOGIN:
      page = FadeInRoute(routeName: settings.name, page: LoginScreen());
      break;

    case RouteConstants.DASHBOARD:
      page = FadeInRoute(routeName: settings.name, page: Dashboard());
      break;
    default:
      page = FadeInRoute(routeName: settings.name, page: LoginScreen());
  }
  return page;
}
