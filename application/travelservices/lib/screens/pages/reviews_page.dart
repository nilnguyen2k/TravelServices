import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/models/message_model.dart';
import 'package:travelservices/models/product_by_status_model.dart';
import 'package:travelservices/screens/widgets/loading_widget.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {

  TextEditingController controller = TextEditingController();
  double ratingState = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Reviews",
            style: TextStyle(
              color: Colors.black
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue.shade600,
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
        body: FutureBuilder(
          future: getListOrderByStatus("experienced"),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data as List<ProductByStatusModel>;
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: data.length,
                itemBuilder:(context, index) {
                  return SizedBox(
                    child: Card(
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Container(
                                    height: 110,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(data[index].url),
                                        fit: BoxFit.fitHeight,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          data[index].nameService,
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Tickets: ${ticketAllType(data[index].tickets)}",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 16
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text(
                                          "Day of exp: ${data[index].bookDay} ${data[index].bookTime}",
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 16
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            "Create Date: ${data[index].createDate.year}-${data[index].createDate.month}-${data[index].createDate.day}",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.grey.shade500,
                                              fontSize: 14
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ) 
                              ),
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          Icons.reviews,
                                          color: Colors.blue.shade600,
                                        ),
                                        onPressed: (){
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false, 
                                            builder: (context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: SizedBox(
                                                  height: 300,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Image.asset(
                                                            "assets/images/verified.png",
                                                            height: 50,
                                                            width: 50,
                                                          ),
                                                          const SizedBox(width: 15),
                                                          const Text(
                                                            "Reviews",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                        )
                                                        ],
                                                      ),
                                                      const SizedBox(height: 15),
                                                      RatingBar.builder(
                                                        initialRating: 1,
                                                        minRating: 1,
                                                        direction: Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                                        itemBuilder: (context, _) => const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate: (rating) {
                                                          setState(() {
                                                            ratingState = rating;
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(height: 15),
                                                      Container(
                                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                                        child: TextField(
                                                          controller: controller,
                                                          decoration: const InputDecoration(
                                                            border: OutlineInputBorder(),
                                                            hintText: "Content"
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 30),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                          children: [
                                                            Container(
                                                              margin: const EdgeInsets.only(top: 20),
                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                              width: MediaQuery.of(context).size.width / 3,
                                                              height: 55,
                                                              child: ElevatedButton(
                                                                onPressed: (){
                                                                  createReview(data[index].idService, controller.text, ratingState.toString());
                                                                  updateStatusOrderItem("access_review", data[index].id);
                                                                  Navigator.pop(context);
                                                                  setState(() {
                                                                    controller.text = "";
                                                                    ratingState = 1;
                                                                  });
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(18),
                                                                  )
                                                                ),
                                                                child: const Text("Submit"),
                                                              )
                                                            ),
                                                            Container(
                                                              margin: const EdgeInsets.only(top: 20),
                                                              padding: const EdgeInsets.symmetric(horizontal: 20),
                                                              width: MediaQuery.of(context).size.width / 3,
                                                              height: 55,
                                                              child: ElevatedButton(
                                                                onPressed: (){
                                                                  Navigator.pop(context);
                                                                  setState(() {
                                                                    controller.text = "";
                                                                    ratingState = 1;
                                                                  });
                                                                },
                                                                style: ElevatedButton.styleFrom(
                                                                  primary: Colors.grey,
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(18),
                                                                  )
                                                                ),
                                                                child: const Text(
                                                                  "Cancel",
                                                                  style: TextStyle(
                                                                    color: Colors.black
                                                                  ),
                                                                ),
                                                              )
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: (){
                                          updateStatusOrderItem("cancel_review", data[index].id);
                                          setState(() {});
                                        },
                                      )
                                    ],
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  );
                } 
              ); 
            } else {
              return const LoadingWidget();
            }
          },
        )
      )
    );   
  }

  Future<List<ProductByStatusModel>> getListOrderByStatus(String status) async {
    Api api = Api();
    var response = await api.getRequestAuth(Api.url, "orderitem/$status");
    if (response is Response) {
      return (response.data as List).map((e) => ProductByStatusModel.fromJson(e)).toList();
    } else {
      return <ProductByStatusModel>[];
    }
  }

  Future<MessageModel> updateStatusOrderItem(String status, int idOrderItem) async {
    Api api = Api();
    return await api.updateStatusOrderItem(Api.url, "user/orderitem/update?status=$status&idOrderItem=$idOrderItem");
  }

  Future<MessageModel> createReview(int idService, String content, String point) async {
    Api api = Api();
    return await api.postReview(Api.url, "customer/review", idService, content, point);
  }

  String ticketAllType(List<TicketProductByStatus> items) {
    String temp = "";
    for (int i = 0; i < items.length; i++) {
      temp = "$temp${items[i].typeTicket} x ${items[i].amountTicket}, ";
    }
    return temp.substring(0, temp.length - 2);
  }
}