import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_event.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/idarguments.dart';
import 'package:travelservices/screens/widgets/loading_widget.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  Widget build(BuildContext context) {
    
    FavoriteBloc favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(FavoriteReadEvent());

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              "Favorites",
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
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          bloc: favoriteBloc,
          builder:(context, state) {
            if (state.getLoading) {
              return const LoadingWidget();
            } else {
              return Padding(
              padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(state.favorites.length, (index) {
                    return InkWell(
                      onTap: () {
                        // back 1 Bước thì true, 2 thì false
                        Navigator.pushNamed(context, Routes.productDetails, arguments: IdArguments(state.favorites[index].idService, true)); 
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Card(
                          color: Colors.transparent,
                          elevation: 0,
                          child: SizedBox(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.width*2/2.5,
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 230,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        image: DecorationImage(
                                          image: NetworkImage(state.favorites[index].image),
                                          fit: BoxFit.fitWidth
                                        )
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      right: 5,
                                      child: IconButton(
                                        onPressed: (){
                                          favoriteBloc.add(FavoriteDeleteEvent(idProduct: state.favorites[index].idService));
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.blue.shade600,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    ConstrainedBox(
                                      constraints: const BoxConstraints(minHeight: 60),
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                                        child: Text(
                                          state.favorites[index].name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: titleTextSize),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.blue.shade600,
                                            size: 18,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(left: 2),
                                            child: Text(
                                              "${state.favorites[index].pointReviews.toString()} (${state.favorites[index].reviews}) | ${state.favorites[index].orders} Booked",
                                              style: const TextStyle(
                                                fontSize: 14
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${state.favorites[index].minPrice} VND",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: titleTextSize
                                        ),
                                      ),
                                    )           
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                ),  
              ),
            );
            }
          },
        )
      )
    );  
  }
}