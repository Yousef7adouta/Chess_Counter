import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:timer_app/color_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? timer;
  @override
  startD() {
    timer = Timer(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, "/first");
    });
  }

  @override
  void initState() {
    startD();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.color5,
      body: Center(
        child: SpinKitDualRing(
          color: ColorManager.color1,
          size: 95.0,
        ),
      ),
    );
  }
}
