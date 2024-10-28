import 'package:badges/badges.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelservices/api/api.dart';
import 'package:travelservices/blocs/cart_bloc/cart_bloc.dart';
import 'package:travelservices/blocs/cart_bloc/cart_event.dart';
import 'package:travelservices/blocs/cart_bloc/cart_state.dart';
import 'package:travelservices/blocs/category_bloc/category_bloc.dart';
import 'package:travelservices/blocs/category_bloc/category_event.dart';
import 'package:travelservices/blocs/category_bloc/category_state.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_event.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_state.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_bloc.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_event.dart';
import 'package:travelservices/blocs/navbar_bloc/navbar_state.dart';
import 'package:travelservices/blocs/search_bloc/search_bloc.dart';
import 'package:travelservices/blocs/search_bloc/search_event.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/area_model.dart';
import 'package:travelservices/models/category_model.dart';
import 'package:travelservices/models/product_model.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/current_user_arguments.dart';
import 'package:travelservices/screens/arguments/idarguments.dart';
import 'package:travelservices/screens/arguments/way_cart_arguments.dart';
import 'package:travelservices/utils/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  int currentIndex = 0;

  late int idAuth;
  late String username;
  
  @override
  void initState() {
    getValueShared();  
    super.initState();
  }

  void getValueShared() async {
    idAuth = await SharedPreferencesCustom.getIntCustom('idAuth');
    username = await SharedPreferencesCustom.getStringCustom('username');
  }

  @override
  Widget build(BuildContext context) {

    CartBloc cartBloc = context.read<CartBloc>();
    cartBloc.add(CartReadEvent());

    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            snap: true,
            floating: true,
            pinned: true,
            bottom: AppBar(
              toolbarHeight: 90,
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: false,
              title: Container(
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.symmetric(horizontal: paddingWidth/2),
                height: 50,
                child: BlocBuilder<NavbarBloc, NavbarState>(
                  builder:(context, state) {
                    return GestureDetector(
                      onTap: (){
                        context.read<NavbarBloc>().add(NavbarSearchStatusEvent());
                        context.read<NavbarBloc>().add(NavbarSearchPageEvent());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                          color: searchbar,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search_outlined,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Search where to go or what to do",
                              style: TextStyle(
                                color: hintText,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                              ),
                            )
                          ],
                        ),
                      )
                    );
                  },
                )          
              ),
            ),  
            title: Text(
              "FTService",
              style: TextStyle(
                color: Colors.blue.shade600
              ),
            ),
            actions: [
              IconButton(
                onPressed: (){
                  Navigator.pushNamed(context, Routes.chatPage, arguments: CurrentArguments(id: idAuth));
                }, 
                icon: Icon(
                  Icons.sms_outlined,
                  color: Colors.blue.shade600,
                )
              ),
              BlocBuilder<CartBloc, CartState>(
                bloc: cartBloc,
                builder:(context, state) {
                  return Badge(
                    badgeContent: Text(state.items.length.toString()),
                    position: BadgePosition.bottomEnd(bottom: 4, end: 5),
                    child: IconButton(
                      onPressed: (){
                        Navigator.pushNamed(context, Routes.cartPage, arguments: WayCartArguments(way: true));
                      }, 
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: Colors.blue.shade600,
                      )
                    ),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: paddingWidth, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  categoriesOption(),
                  title("The most popular city"),
                  areaFavorite(context),
                  title("The most popular tourism services"),
                  serviceTravelHot(context)
                ],
              ),
            ),
          ), 
        ],
      ),
    );
  }

  Widget categoriesOption() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder:(context, state) {
        if (state.getLoading) {
          return const SizedBox.shrink();
        } else {
          List<CategoryData> listItemsCate = state.categories;
          return SizedBox(
            child: Column(
              children: [
                SizedBox(
                  height: listItemsCate.length > 4 ? 200 : 100,
                  child: PageView(
                    onPageChanged: (value) {
                      setState(() {
                        currentIndex = value;
                      });
                    },
                    scrollDirection: Axis.horizontal,
                    children: List.generate(listItemsCate.length > 8 ? 2 : 1, (index) {
                      return SizedBox(
                        child: GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 4,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          children: List.generate(listItemsCate.length, (index) {
                            return InkWell(    
                              onTap: (){
                                context.read<NavbarBloc>().add(NavbarSearchPageEvent());
                                context.read<SearchBloc>().add(SearchByClickCategoryIconEvent(listItemsCate[index].id));
                                context.read<CategoryBloc>().add(CategoryClickEvent(category: listItemsCate[index]));
                              },
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Image.network(
                                        listItemsCate[index].icon.toString(), 
                                        color: Colors.blue.shade600,
                                        height: 40,
                                        width: 40,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        listItemsCate[index].name.toString(),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold
                                        ),
                                      )
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                        ),
                      );
                    })
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    width: listItemsCate.length > 8 ? 30 : 15,
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.grey,
                    ),
                    child: AnimatedAlign(
                      alignment: currentIndex == 0 ? Alignment.centerLeft : Alignment.centerRight, 
                      curve: Curves.fastOutSlowIn,
                      duration: const Duration(milliseconds: 400),
                      child: Container(
                        width: 15,
                        height: 4,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(2),
                        color: Colors.blue.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }
    ); 
  }

  Widget areaFavorite(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      clipBehavior: Clip.none,
      scrollDirection: Axis.horizontal,
      child: FutureBuilder(
        future: getAreaFavorite(),
        builder:(context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data as List<AreaFavorite>;
            return Row(
              children: List.generate(data.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Card(
                    color: Colors.black,
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.width*0.4,
                      width: MediaQuery.of(context).size.width/3.2,
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(data[index].url ?? areaImgDefault),
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          data[index].nameArea ?? "",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),
                        ),
                      )
                    )
                  ),
                );
              })
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      )
    );
  }

  Widget title(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Container(
        width: double.infinity,
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: titleTextSize,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }

  Widget serviceTravelHot(BuildContext context){

    FavoriteBloc favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(FavoriteReadEvent());

    return SizedBox(
      child: FutureBuilder(
          future: getServiceHot(),
          builder:(context, snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data as List<ProductData>;
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: List.generate(data.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, Routes.productDetails, arguments: IdArguments(data[index].id, true));     
                        },
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
                                          image: NetworkImage(data[index].image ?? productImgDefault),
                                          fit: BoxFit.fitWidth,
                                          opacity: 0.9
                                        )
                                      ),
                                    ),
                                    Positioned(
                                      top: 5,
                                      left: 5,
                                      right: 5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          BlocBuilder<FavoriteBloc, FavoriteState>(
                                            bloc: favoriteBloc,
                                            buildWhen: (previous, current) {
                                              return previous.statusAdd != current.statusAdd || previous.statusDelete != current.statusDelete;
                                            },
                                            builder:(context, state) {
                                              var contain = state.favorites.where((element) => element.idService == data[index].id);
                                              return IconButton(
                                                onPressed: (){
                                                  if (contain.isEmpty) {
                                                    favoriteBloc.add(FavoriteAddEvent(idProduct: data[index].id));
                                                  } else {
                                                    favoriteBloc.add(FavoriteDeleteEvent(idProduct: data[index].id));
                                                  }
                                                },
                                                icon: Icon(
                                                  contain.isEmpty ? Icons.favorite_outline : Icons.favorite,
                                                  color: Colors.blue.shade600,
                                                  size: 30,
                                                ),
                                              );
                                            }
                                          )
                                        ],
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
                                          data[index].name ?? productNameDefault,
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
                                              "${data[index].point} (${data[index].reviews}) | ${data[index].orders} Booked",
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
                                        "${data[index].ticket.first.value.toString()} VND",
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
                      )
                    );
                  })
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }, 
        )
    );
  }

  Future<List<AreaFavorite>> getAreaFavorite() async {
    Api api = Api();
    Response response;
    response = await api.getRequest(Api.url, "public/favoriteArea");
    return (response.data as List).map((e) => AreaFavorite.fromJson(e)).toList();
  }

  Future<List<ProductData>> getServiceHot() async {
    Api api = Api();
    Response response;
    response = await api.getRequest(Api.url, "public/favoriteService");
    return (response.data as List).map((e) => ProductData.fromJson(e)).toList();
  }
}