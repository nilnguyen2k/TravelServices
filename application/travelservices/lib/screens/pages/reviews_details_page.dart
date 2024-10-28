import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/product_details_model.dart';
import 'package:travelservices/screens/arguments/list_reviews_details_arguments.dart';

class ReviewsDetailsPage extends StatefulWidget {
  const ReviewsDetailsPage({Key? key}) : super(key: key);

  @override
  State<ReviewsDetailsPage> createState() => _ReviewsDetailsPageState();
}

class _ReviewsDetailsPageState extends State<ReviewsDetailsPage> {

  List<ReviewProductDetailsModel> listReview = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, (){
      setState(() {
        ReviewsDetailsArgument args = ModalRoute.of(context)!.settings.arguments as ReviewsDetailsArgument;
        listReview = args.reviews;
      });
    });
    super.initState();
  }

  Map<String, dynamic> reviewTotal(List<ReviewProductDetailsModel> reviews) {
    
    if (reviews.isEmpty) {
      return {
      "numReview" : 0,
      "point" : 0.0
    };
    }

    double point = 0;
    for (ReviewProductDetailsModel review in reviews) {
      point = point + review.point;
    }
    return {
      "numReview" : reviews.length,
      "point" : point/reviews.length
    };
  }

  String getValueName(String? firstname, String? lastname) {
    if (firstname == null) {
      if (lastname == null) {
        return "Customer";
      } else {
        return lastname;
      }
    } else {
      if (lastname == null) {
        return firstname;
      } else {
        return "$firstname $lastname";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue.shade600,
            ),
          ),
          centerTitle: true,
          title: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/2 - MediaQuery.of(context).size.width/4),
            child: const Text(
              "Reviews",
              style: TextStyle(
                color: Colors.black
              ),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1), 
            child: Container(
              color: searchbar, 
              width: double.infinity, 
              height: 1
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/rating.png',
                        height: 60,
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${listReview.length} Reviews",
                              style: const TextStyle(
                                fontSize: 18
                              ),
                            ),
                            const SizedBox(height: 5),
                            RatingBarIndicator(
                              rating: reviewTotal(listReview)["point"],
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Image.asset(
                        "assets/images/rating.png",
                        height: 60,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: List.generate(listReview.length, (index) {
                    return reviewContainer(
                      listReview[index].user.avatar,
                      getValueName(listReview[index].user.firstname, listReview[index].user.lastname),
                      listReview[index].modifiedDate.toString(),
                      listReview[index].point,
                      listReview[index].content
                    );
                  }),
                )
              ],
            ),
          ),
        )
      ),
    );
  }

  Widget reviewContainer(String? avatar, String name, String date, double point, String content) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.grey.shade200, style: BorderStyle.solid)
        ),
        padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(avatar ?? avatarDefault),
                radius: 35,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 3),
                        child: Text(
                          name,
                          style: const TextStyle(
                            fontSize: 18
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          date
                        ),
                      ),
                      RatingBarIndicator(
                        rating: point,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 20,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            content,
                            style: const TextStyle(
                              fontSize: 17
                            ),
                          ),
                        ),
                      ),  
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}