import 'dart:async';

import 'package:flutter/material.dart';
import 'package:timer_app/color_manager.dart';
import 'package:timer_app/selected_view.dart';
import 'package:timer_app/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/': (context) => const SplashView(),
        '/first': (context) => const SelectedTime(),
        '/second': (context) => const ChessClock()
      },
    );
  }
}

class ChessClock extends StatefulWidget {
  const ChessClock({super.key});

  @override
  State<ChessClock> createState() => _ChessClockState();
}

class _ChessClockState extends State<ChessClock> {
  int duration = 5; //in minutes
  int player1 = 0;
  int player2 = 0;
  int playerMove1 = 0;
  int playerMove2 = 0;
  Timer? timer1;
  Timer? timer2;
  int? playerTurn;

  @override
  void initState() {

    reset();
    super.initState();
  }

  reset() {
    setState(() {
      if (timer1 != null) {
        timer1!.cancel();
      }
      if (timer2 != null) {
        timer2!.cancel();
      }
      timer1 = null;
      timer2 = null;
      playerMove1 = 0;
      playerMove2 = 0;
      player1 = duration * 60;
      player2 = duration * 60;
      playerTurn = null;
    });
  }

  runTimer1() {
    if (timer2 != null) {
      setState(() {
        timer2!.cancel();
        playerMove2++;
      });
    }
    setState(() {
      playerTurn = 0;
    });

    timer1 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (player1 > 0) {
          player1--;
        } else {
          timer1!.cancel();
        }
      });
    });
  }

  runTimer2() {
    if (timer1 != null) {
      setState(() {
        timer1!.cancel();
        playerMove1++;
      });
    }
    setState(() {
      playerTurn = 1;
    });
    timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (player2 > 0) {
          player2--;
        } else {
          timer2!.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    if (timer1 != null) {
      timer1!.cancel();
    }
    if (timer2 != null) {
      timer2!.cancel();
    }
    
         duration = 0;

    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    duration = ModalRoute.of(context)!.settings.arguments as int;
    return SafeArea(
      child: Scaffold(
        body: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 80,
            fontWeight: FontWeight.w900,
          ),
          child: Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (player1 > 0 && player2 > 0) {
                      if (timer2 != null && timer2!.isActive) {
                        setState(() {
                          timer2!.cancel();
                        });
                      } else {
                        runTimer2();
                      }
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .40,
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: playerTurn == 0
                          ? ColorManager.color1
                          : ColorManager.color2,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: RotatedBox(
                              quarterTurns: 2,
                              child: Text(
                                "${player1 ~/ 60} : ${player1 % 60 < 10 ? "0" : ""}${player1 % 60}",
                                style: TextStyle(
                                  color: playerTurn == 0
                                      ? ColorManager.color4
                                      : ColorManager.color5,
                                  fontSize: 100,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ),
                        ),
                        RotatedBox(
                          quarterTurns: 2,
                          child: Text(
                            "Moves : $playerMove1",
                            style: const TextStyle(
                              color: ColorManager.color3,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          reset();
                        },
                        icon: const Icon(Icons.rotate_90_degrees_cw),
                        label: const Text("restart")),
                  ],
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (player1 > 0 && player2 > 0) {
                      if (timer1 != null && timer1!.isActive) {
                        setState(() {
                          timer1!.cancel();
                        });
                      } else {
                        runTimer1();
                      }
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .40,
                    padding: const EdgeInsets.all(0),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: playerTurn == 1
                          ? ColorManager.color1
                          : ColorManager.color2,
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Moves : $playerMove2",
                          style: const TextStyle(
                            color: ColorManager.color3,
                            fontSize: 20,
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              "${player2 ~/ 60} : ${player2 % 60 < 10 ? "0" : ""}${player2 % 60}",
                              style: TextStyle(
                                color: playerTurn == 1
                                    ? ColorManager.color4
                                    : ColorManager.color5,
                                fontSize: 100,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
