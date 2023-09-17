import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class MyRatingbar extends StatefulWidget {
  final double initialRating;
  final int itemCount;
  final double itemSize;
  MyRatingbar({required this.initialRating, required this.itemCount, required this.itemSize});
  @override
  State<MyRatingbar> createState() => _MyRatingbarState();
}

class _MyRatingbarState extends State<MyRatingbar> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: initialRating,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: itemCount,
      itemSize: itemSize,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (ratingValue) {
        setState(() {
          rating = ratingValue;
        });
      },
    );
  }
}

