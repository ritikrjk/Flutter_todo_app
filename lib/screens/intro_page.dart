import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome TO DODO",
              style: TextStyle(fontSize: 29),
            ),
            const Text(
              "A Simple Note making App to make life Easier",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, 'homepage');
              },
              child: Container(
                width: 120,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.green),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                      child: Text(
                    "Tap to Start",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
