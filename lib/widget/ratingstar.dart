import 'package:flutter/material.dart';

class Ratingstarwidget extends StatefulWidget {
  const Ratingstarwidget(
      {super.key, required this.star, required this.maxRating});
  final String star;
  final String maxRating;
  @override
  State<Ratingstarwidget> createState() => _RatingstarwidgetState();
}

class _RatingstarwidgetState extends State<Ratingstarwidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          Text(
            widget.star,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          Container(
            height: 20,

            width: 250, // Adjust the width as needed
            color: const Color.fromARGB(
                255, 249, 165, 25), // Adjust the color as needed
            margin: const EdgeInsets.symmetric(
                horizontal: 8), // Adjust the margin as needed
          ),
          Text(
            widget.maxRating,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
