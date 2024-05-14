import 'package:flutter/material.dart';

class Feedbacktile extends StatefulWidget {
  const Feedbacktile({super.key});

  @override
  State<Feedbacktile> createState() => _FeedbacktileState();
}

class _FeedbacktileState extends State<Feedbacktile> {
  final starColor = const Color.fromARGB(255, 249, 165, 25);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 25,
                // You can add the user's avatar here
                // child: Icon(Icons.person, size: 40, color: Colors.black),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Pratik Dixit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: starColor, size: 20),
                      Icon(Icons.star, color: starColor, size: 20),
                      Icon(Icons.star, color: starColor, size: 20),
                      Icon(Icons.star, color: starColor, size: 20),
                      Icon(Icons.star, color: starColor, size: 20),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the printer took a galley of type and scrambled it to make a type specimen book.",
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
