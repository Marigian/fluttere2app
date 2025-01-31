import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class YourNotificationComponent extends StatefulWidget {
  final VoidCallback? onClose; // Callback when notification is closed

  const YourNotificationComponent({Key? key, this.onClose}) : super(key: key);

  @override
  _YourNotificationComponentState createState() =>
      _YourNotificationComponentState();
}

class _YourNotificationComponentState extends State<YourNotificationComponent> {
  bool _isVisible = true;  // State to control the visibility of the notification
  static final Logger logger = Logger(); // Logger instance

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
                logger.i("User closed the notification."); // Log close action

                setState(() {
                  _isVisible = false;  // Hide notification
                });

                if (widget.onClose != null) {
                  widget.onClose!();  // Trigger callback if provided
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
