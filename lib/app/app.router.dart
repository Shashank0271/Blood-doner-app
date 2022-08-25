// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedRouterGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';

import '../ui/EditProfile/edit_profile_view.dart';
import '../ui/Page/page_view.dart';
import '../ui/completeProfile/complete_profile_view.dart';
import '../ui/home/home_view.dart';
import '../ui/login/login_view.dart';
import '../ui/signup/signup_view.dart';
import '../ui/startup/startup_view.dart';

class Routes {
  static const String startUpView = '/';
  static const String homeView = '/home-view';
  static const String completeProfileView = '/complete-profile-view';
  static const String signupView = '/signup-view';
  static const String loginView = '/login-view';
  static const String editProfileView = '/edit-profile-view';
  static const String myPageView = '/my-page-view';
  static const all = <String>{
    startUpView,
    homeView,
    completeProfileView,
    signupView,
    loginView,
    editProfileView,
    myPageView,
  };
}

class StackedRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startUpView, page: StartUpView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.completeProfileView, page: CompleteProfileView),
    RouteDef(Routes.signupView, page: SignupView),
    RouteDef(Routes.loginView, page: LoginView),
    RouteDef(Routes.editProfileView, page: EditProfileView),
    RouteDef(Routes.myPageView, page: MyPageView),
  ];
  @override
  Map<Type, StackedRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, StackedRouteFactory>{
    StartUpView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const StartUpView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeView(),
        settings: data,
      );
    },
    CompleteProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CompleteProfileView(),
        settings: data,
      );
    },
    SignupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const SignupView(),
        settings: data,
      );
    },
    LoginView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const LoginView(),
        settings: data,
      );
    },
    EditProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditProfileView(),
        settings: data,
      );
    },
    MyPageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const MyPageView(),
        settings: data,
      );
    },
  };
}
