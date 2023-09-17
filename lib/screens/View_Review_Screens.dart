import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieapp/screens/Discription_Screens.dart';

import '../helpers/DatabaseHandlers.dart';

class ViewReviewScreens extends StatefulWidget {
  final int reviewid;
  const ViewReviewScreens({super.key, required this.reviewid});

  @override
  State<ViewReviewScreens> createState() => _ViewReviewScreensState();
}

class _ViewReviewScreensState extends State<ViewReviewScreens> {
  List allreviewdata = [];

  Future<void> getdata() async {
    DatabaseHandler obj = DatabaseHandler();
    var allData = await obj.viewreview(widget.reviewid);
    setState(() {
      allreviewdata = allData;
    });
  }

  @override
  void initState() {
    getdata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight:size.height*0.1,
          backgroundColor: Colors.redAccent.shade100,
          title: Text("View Review",style: (TextStyle(fontSize: 25.0))),
        ),
        body: ListView.builder(
          itemCount: allreviewdata.length,
          itemBuilder: (context, index) {
            var myrate =  allreviewdata[index];
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RatingBar.builder(
                              initialRating: myrate["addrating"],
                              minRating: 1,
                              ignoreGestures: true,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 25,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,

                              ),
                              onRatingUpdate: (rating) {

                              },
                            ),
                            Text(
                              myrate["addtitle"],
                              style: const TextStyle(
                                  fontSize: 20.0, fontFamily: "Oswald"),
                            ),
                            Text(
                              myrate["addreview"],
                              maxLines: 5,
                              style: const TextStyle(
                                  fontSize: 17.0, fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ),
                      IconButton(onPressed: () async{
                        int id = myrate["rid"];
                        DatabaseHandler obj =
                        DatabaseHandler();
                        var st = await obj.deletereview(id);
                        if (st == 1) {
                          // reset/refresh the list
                        } else {
                          Fluttertoast.showToast(
                              msg: "Record not deleted",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );
                        }
                      }, icon:  Icon(Icons.delete))
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Divider(
                    color: Colors.black26,
                    height: 5,
                    thickness: 1,
                    indent: 10,
                    endIndent: 10,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
