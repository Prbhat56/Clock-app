import 'package:flutter/material.dart';
import 'package:clock_application/clock_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSoundOn = false;
  bool isTimerStarted = false;
  bool isclicked = false;
  void resetTimer() {
    setState(() {
      isTimerStarted = false;
      isclicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.white), // Back arrow icon
          onPressed: () {
            Navigator.of(context).pop(); // Action to go back
          },
        ),
        title: const Text(
          "Mindful Meal Timer",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.grey, // Text color changed to grey
          ),
        ),
        backgroundColor: const Color(0xFF2D2F41)
            .withOpacity(0.85), // Deeper shade of the background color
      ),
      body: Container(
        color: const Color(0xFF2D2F41),
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    // Small grey dot
                    backgroundColor: Colors.grey[400],
                    radius: 5,
                  ),
                  const SizedBox(width: 10),
                  const CircleAvatar(
                    // Bigger white dot
                    backgroundColor: Colors.white,
                    radius: 7,
                  ),
                  const SizedBox(width: 10),
                  CircleAvatar(
                    // Small grey dot
                    backgroundColor: Colors.grey[400],
                    radius: 5,
                  ),
                ],
              ),
              const SizedBox(
                  height: 10), // Spacing between the dots and the text
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Finish Your Meal",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You can eat until you feel full",
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.center,
                child: ClockView(
                  isSoundOn: isSoundOn,
                  isTimerStarted: isTimerStarted,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Switch(
                value: isSoundOn,
                onChanged: (bool newValue) {
                  setState(() {
                    isSoundOn = newValue; // Update the state of the switch
                  });
                },
                activeTrackColor:
                    Colors.green, // Remaining space color when switch is on
                activeColor:
                    Colors.white, // Color of the small circle when switch is on
              ),
              Text(
                isSoundOn
                    ? "Sound On"
                    : "Sound Off", // Text changes based on the state of the switch
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isTimerStarted = !isTimerStarted; // Toggle timer state
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      primary: isTimerStarted
                          ? Colors.lightGreenAccent.withOpacity(0.7)
                          : Color(0xFF2D2F41),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: Text(
                      isTimerStarted ? "Pause" : "Start",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      isTimerStarted
                          ? () {
                              resetTimer();
                             
                            }
                          : null;
                    },
                    style: ElevatedButton.styleFrom(
                      primary: isclicked
                          ? Colors.lightGreenAccent.withOpacity(0.7)
                          : Color(0xFF2D2F41),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(color: Colors.white, width: 2.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                    ),
                    child: Text(
                      isTimerStarted
                          ? "LET`S STOP I`M FULL NOW"
                          : "LET`S STOP I`M FULL NOW",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
