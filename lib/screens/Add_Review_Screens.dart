import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieapp/screens/Homepage.dart';
import 'package:movieapp/widgets/MyTextBox.dart';

import '../helpers/DatabaseHandlers.dart';
import 'View_Review_Screens.dart';

class AddReviewScreens extends StatefulWidget {
  final int movieid;

  const AddReviewScreens({super.key, required this.movieid});

  @override
  State<AddReviewScreens> createState() => _AddReviewScreensState();
}

class _AddReviewScreensState extends State<AddReviewScreens> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
    double rating = 0;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: size.height * 0.1,
            backgroundColor: Colors.redAccent.shade100,
            title: Text("Your Review ", style: (TextStyle(fontSize: 25.0))),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text("How would you rate it?",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Oswald")),
                  const SizedBox(
                    height: 15.0,
                  ),
                  RatingBar.builder(
                    initialRating: rating,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 25,
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
                  ),
                  const Text("Title your review",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Oswald")),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomTextField(
                    controller: _titleController,
                    hintText: "what's most important to know?",
                    validator: (value) {
                      {
                        if (value!.isEmpty) {
                          return "Please enter title";
                        } else if (value.length <= 4) {
                          return "Please enter your valid title";
                        }
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text("Write your review",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Oswald")),
                  const SizedBox(
                    height: 10.0,
                  ),
                  CustomTextField(
                    controller: _reviewController,
                    hintText: "Please enter your valid review",
                    maxLines: 5,
                    validator: (value) {
                      {
                        if (value!.isEmpty) {
                          return "Please enter review";
                        } else if (value.length <= 4) {
                          return "Please enter your valid review";
                        }
                        return null;
                      }
                    },
                  )
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            height: size.height * 0.1,
            width: size.width * 0.05,
            decoration: const BoxDecoration(
              color: Color(0xff0F0D3C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      if (rating == 0.0) {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  title: Text("Error massage"),
                                  content: Text("Choose a rating to continue"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("ok"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ));
                      }
                      if (formKey.currentState!.validate()) {
                        var addtitle = _titleController.text.toString();
                        var addreview = _reviewController.text.toString();
                        var addrating = rating;

                        DatabaseHandler obj = DatabaseHandler();
                        var rid = await obj.insertreview(
                            addtitle, addreview, addrating, widget.movieid);
                        print("===========rid${rid}");
                        // ignore: use_build_context_synchronously
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ViewReviewScreens(
                            reviewid: rid,
                          ),
                        ));
                      }
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: const Center(
                          child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.blue, fontSize: 17.0),
                      )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Homepage(),
                      ));
                    },
                    child: Container(
                      height: size.height * 0.05,
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.white),
                      child: const Center(
                          child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.blue, fontSize: 17.0),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
