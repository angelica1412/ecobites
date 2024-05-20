import 'package:flutter/material.dart';

class scheduleStore extends StatelessWidget {
  final String day;
  final String time;

  const scheduleStore({super.key, required this.day, required this.time});



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 100,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    day
                  ),
                ),
              )
          ),
          Text(time),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
