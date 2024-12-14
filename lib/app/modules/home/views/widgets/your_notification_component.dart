import 'package:flutter/material.dart';

class YourNotificationComponent extends StatefulWidget {
  @override
  _YourNotificationComponentState createState() =>
      _YourNotificationComponentState();
}

class _YourNotificationComponentState extends State<YourNotificationComponent> {
  bool _isVisible = true;  // State to control the visibility of the notification

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: _isVisible,  // If true, the notification is shown, if false, it's hidden
      child: Container(
        padding: EdgeInsets.all(16),
        color: Colors.orange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Attention! High temperatures will occur today. Avoid outside during 12:00 - 16:00! It is suggested to plan watering early in the morning.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isVisible = false;  // Hide the notification when the X button is pressed
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
