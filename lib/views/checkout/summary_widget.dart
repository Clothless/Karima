import 'package:flutter/cupertino.dart';

class Summery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              "Summary",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}