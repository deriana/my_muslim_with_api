import 'package:flutter/material.dart';
import 'package:muslim_app_hideri/main.dart';

class FastingWidget extends StatefulWidget {
  final Function(bool) onChanged;

  const FastingWidget({super.key, required this.onChanged});

  @override
  _FastingWidgetState createState() => _FastingWidgetState();
}

class _FastingWidgetState extends State<FastingWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: MainApp.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "../../assets/mosque.png",
                width: 60,
                height: 60,
              ),
              SizedBox(width: 10),
              Text(
                "Are you fasting today?",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          ClipOval(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isChecked = !isChecked;
                    widget.onChanged(isChecked);  // Call the callback with the new state
                  });
                },
                child: Container(
                  width: 30.0,
                  height: 30.0,
                  decoration: BoxDecoration(
                    color: isChecked
                        ? MainApp.secondaryColor
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isChecked
                          ? Colors.transparent
                          : MainApp.secondaryColor,
                      width: 1.0,
                    ),
                  ),
                  child: isChecked
                      ? const Icon(
                          Icons.check,
                          size: 20.0,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
