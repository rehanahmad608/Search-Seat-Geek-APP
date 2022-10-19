import 'dart:async';

import 'package:flutter/material.dart';
import 'package:type_ahead/screens/type_ahead/type_ahead_screen.dart';
import 'package:type_ahead/widgets/screen_size_config/screen_size_config.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = '/splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  int _start = 3;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 0,
            child: SizedBox(
                height: ScreenConfig.screenSizeHeight * 1.1,
                width: ScreenConfig.screenSizeWidth,
                child: Container(
                  color: Colors.white,
                )),
          ),
          Center(
            child: SizedBox(
                width: ScreenConfig.screenSizeWidth * 0.8,
                child: const Text(
                  'Search Seat Geek',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }
}
