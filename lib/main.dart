import 'dart:async';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Timer_App(),
    );
  }
}

class Timer_App extends StatefulWidget {
  const Timer_App({super.key});

  @override
  State<Timer_App> createState() => _Timer_AppState();
}

class _Timer_AppState extends State<Timer_App> {
  // ----------------------------------------------------------------------
 
  Duration duration = Duration(minutes: 25);
  Timer? stop;

  Start_timer() {
    stop = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int new_min = duration.inSeconds - 1;
        duration = Duration(seconds: new_min);
      });
    });
  }



  bool is_running = true;
 
  
  // ------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 70, 118),
        centerTitle: true,
        title: Text("Timer App",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("assets/img/background.jpg"),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularPercentIndicator(
                  radius: 90,
                  lineWidth: 5.0,
                  percent: duration.inMinutes / 25,
                  progressColor: Color.fromARGB(255, 232, 43, 172),
                  center: Text(
                    "${duration.inMinutes.toString().padLeft(2, "0")}:${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                    style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                is_running
                    ? ElevatedButton(
                        onPressed: () {
                          is_running = false;
                          Start_timer();
                        },
                        child: Text(
                          "Start timer",
                          style: TextStyle(fontSize: 19),
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 232, 43, 172),
                            ),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (stop!.isActive) {
                                  stop!.cancel();
                                } else {
                                  Start_timer();
                                }
                              });
                            },
                            child: Text(
                              stop!.isActive ? "Stop" : "resume",
                              style: TextStyle(fontSize: 19),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 232, 43, 172),
                                ),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              stop!.cancel();
                              setState(() {
                                is_running = true;
                                duration = Duration(minutes: 25);
                              });
                            },
                            child: Text(
                              "cancel",
                              style: TextStyle(fontSize: 19),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(
                                  Color.fromARGB(255, 232, 43, 172),
                                ),
                                shape: MaterialStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
