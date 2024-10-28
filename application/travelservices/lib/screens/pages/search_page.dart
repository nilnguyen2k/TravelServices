import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travelservices/blocs/area_bloc/area_bloc.dart';
import 'package:travelservices/blocs/area_bloc/area_event.dart';
import 'package:travelservices/blocs/area_bloc/area_state.dart';
import 'package:travelservices/blocs/category_bloc/category_bloc.dart';
import 'package:travelservices/blocs/category_bloc/category_event.dart';
import 'package:travelservices/blocs/category_bloc/category_state.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_bloc.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_event.dart';
import 'package:travelservices/blocs/favorite_bloc/favorite_state.dart';
import 'package:travelservices/blocs/search_bloc/search_bloc.dart';
import 'package:travelservices/blocs/search_bloc/search_event.dart';
import 'package:travelservices/blocs/search_bloc/search_state.dart';
import 'package:travelservices/configs/colors.dart';
import 'package:travelservices/configs/constants.dart';
import 'package:travelservices/models/area_model.dart';
import 'package:travelservices/models/category_model.dart';
import 'package:travelservices/models/product_model.dart';
import 'package:travelservices/routes.dart';
import 'package:travelservices/screens/arguments/idarguments.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  
  FocusNode searchClick = FocusNode();
  TextEditingController searchController = TextEditingController();


  Widget searchBar(bool statusShow, VoidCallback onClick) {
    if (statusShow) {
      return Row(
        children: [
          IconButton(
            onPressed: onClick,
            icon: const Icon(
              Icons.arrow_back_ios
            )
          ),
          Flexible(
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                filled: true,
                fillColor: searchbar,
                prefixIcon: const Icon(
                  Icons.search_outlined,
                  color: Colors.black,
                ),
                hintText: "Search where to go or what to do",
                hintStyle: const TextStyle(
                  color: hintText
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none
                )
              ),
            ),
          )
        ],
      );
    } else {
      return TextField(
        controller: searchController,
        decoration: InputDecoration(
          filled: true,
          fillColor: searchbar,
          prefixIcon: const Icon(
            Icons.search_outlined,
            color: Colors.black,
          ),
          hintText: "Search where to go or what to do",
          hintStyle: const TextStyle(
            color: hintText
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none
          )
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
          child: Column(
            children: [
              const SizedBox(height: paddingWidth),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  return Focus(
                    autofocus: false,
                    onFocusChange: (hasFocus) {
                      context.read<SearchBloc>().add(SearchFocusEvent(hasFocus));
                    },
                    child: !state.statusBar ? searchBar(state.statusSearch, () {
                      context.read<SearchBloc>().add(SearchResetEvent());
                      context.read<AreaBloc>().add(const AreaResetEvent());
                      context.read<CategoryBloc>().add(const CategoryResetEvent());
                      searchController.clear();
                    }) : Row(
                      children: [
                        Flexible(
                          child: TextField(
                            autofocus: true,
                            controller: searchController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: searchbar,
                              prefixIcon: const Icon(
                                Icons.search_outlined,
                                color: Colors.black,
                              ),
                              suffixIcon: null,
                              hintText: "Search where to go or what to do",
                              hintStyle: const TextStyle(
                                color: hintText
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide.none
                              )
                            ),
                            onSubmitted: (value) {
                              context.read<SearchBloc>().add(SearchStringEvent(value));
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: (){
                            context.read<SearchBloc>().add(SearchFocusEvent(false));
                            searchController.clear();
                          },
                          child: const Text("Cancel")
                        )
                      ],
                    )
                  );
                }
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder:(context, state) {
                  if (state.statusSearch) {
                    if (state.areaIsvisible) {
                      if (state.categoryIsvisible) {
                        return optionSearch(area: true, category: true);
                      } else {
                        return optionSearch(area: true, category: false);
                      }
                    } else {
                      if (state.categoryIsvisible) {
                        return optionSearch(area: false, category: true);
                      } else {
                        return optionSearch(area: false, category: false);
                      }
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
              BlocBuilder<SearchBloc, SearchState>(
                builder:(context, state) {
                  if (state.statusSearch) {
                    return Column(
                      children: [     
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${state.products.length} results",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                            IconButton(
                              onPressed: (){
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  context: context, 
                                  builder: (context) {
                                    return SizedBox(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  alignment: Alignment.centerLeft,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },                                                   
                                                    icon: const Icon(
                                                      Icons.close,
                                                      size: 20,
                                                    )
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 1,
                                                child: SizedBox(
                                                  child: Text(
                                                    "Sort by",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 23,
                                                      color: Colors.black
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              const Expanded(
                                                flex: 1,
                                                child: SizedBox.shrink()
                                              )  
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 50),
                                            child: BlocBuilder<SearchBloc, SearchState>(
                                              builder:(context, state) {
                                                return Column(
                                                  children: [
                                                    CheckboxListTile(
                                                      title: const Text('Order ascending'),
                                                      value: state.optionSort[0], 
                                                      onChanged: (value) {
                                                        context.read<SearchBloc>().add(SearchSortEvent("AscOrders"));
                                                        Navigator.pop(context);
                                                      }
                                                    ),
                                                    CheckboxListTile(
                                                      title: const Text('Order descending'),
                                                      value: state.optionSort[1], 
                                                      onChanged: (value) {
                                                        context.read<SearchBloc>().add(SearchSortEvent("DescOrders"));
                                                        Navigator.pop(context);
                                                      }
                                                    ),
                                                    CheckboxListTile(
                                                      title: const Text('Review ascending'),
                                                      value: state.optionSort[2], 
                                                      onChanged: (value) {
                                                        context.read<SearchBloc>().add(SearchSortEvent("AscReviews"));
                                                        Navigator.pop(context);
                                                      }
                                                    ),
                                                    CheckboxListTile(
                                                      title: const Text('Review descending'),
                                                      value: state.optionSort[3], 
                                                      onChanged: (value) {
                                                        context.read<SearchBloc>().add(SearchSortEvent("DescReviews"));
                                                        Navigator.pop(context);
                                                      }
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          )
                                        ],
                                      )
                                    );
                                  }
                                );
                              },
                              icon: const Icon(Icons.sort)
                            )
                          ],
                        ),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }  
                }, 
              ),
              const SizedBox(height: paddingWidth - 10),
              BlocBuilder<SearchBloc, SearchState>(
                builder:(context, state) {
                  if (!state.statusSearch) {
                    return searchArea();
                  } else {
                    return resultSearch(state.products);
                  }
                },
              )
            ],
          ),
        )       
      ),
    );
  }

  Widget optionSearch({required bool area, required bool category}) {
    if (area) {
      if (category) {
        return Row(
          children: [
            optionArea(),
            optionCategory()
          ],
        );
      } else {
        return Row(
          children: [
            optionArea(),
          ],
        );
      }
    } else {
      if (category) {
        return Row(
          children: [
            optionCategory()
          ],
        );
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Widget optionArea() {
    return BlocBuilder<AreaBloc, AreaState>(
      builder: (context, state) {
        List<AreaData> listItems = state.areas;
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade600),
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(10),
            width: 150,      
            child: DropdownButton<AreaData>(
              isDense: true,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              value: state.clickArea,
              hint: const Text("Area"),
              onChanged: (value) {
                context.read<AreaBloc>().add(AreaClickEvent(area: value!));
                context.read<SearchBloc>().add(SearchAreaEvent(value.id));
              },
              items: listItems.map<DropdownMenuItem<AreaData>>((value) {
                return DropdownMenuItem<AreaData>(
                  value: value,
                  child: SizedBox(
                    width: 500,
                    child: Text(
                      value.name!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget optionCategory() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        final List<CategoryData> listItems = state.categories;
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade600),
              borderRadius: BorderRadius.circular(10)
            ),
            padding: const EdgeInsets.all(10),
            width: 150,      
            child: DropdownButton<CategoryData>(
              isDense: true,
              isExpanded: true,
              underline: const SizedBox.shrink(),
              value: state.clickCategory,
              hint: const Text("Category"),
              onChanged: (value) {
                context.read<CategoryBloc>().add(CategoryClickEvent(category: value!));
                context.read<SearchBloc>().add(SearchCategoryEvent(value.id));
              },
              items: listItems.map<DropdownMenuItem<CategoryData>>((value) {
                return DropdownMenuItem<CategoryData>(
                  value: value,
                  child: SizedBox(
                    width: 500,
                    child: Text(
                      value.name!,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget resultSearch(List<ProductData> data) {
    FavoriteBloc favoriteBloc = context.read<FavoriteBloc>();
    favoriteBloc.add(FavoriteReadEvent());
    return Expanded(
      child: SingleChildScrollView(
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.blue.shade600,
                                        size: 30,
                                      ),
                                      Container(
                                        width: 290,
                                        padding: const EdgeInsets.only(left: 10),
                                        child: Text(
                                          getAddress(data, index),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
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
                                      "${data[index].point} (${data[index].reviews}) | ${data[index].orders} booked",
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
      ),
    );
  }

  Widget searchArea() {
    return Expanded(
      child: BlocBuilder<AreaBloc, AreaState>(
        builder: (context, state) {
          if (state.getLoading) {
            return const SizedBox.shrink();
          } else {
            List<AreaData> listItems = state.areas;
            return StaggeredGridView.countBuilder(
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              itemCount: listItems.length,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  context.read<SearchBloc>().add(SearchByClickAreaIconEvent(listItems[index].id));
                  context.read<AreaBloc>().add(AreaClickEvent(area: listItems[index]));
                },
                child: Card(
                  color: Colors.black,
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(listItems[index].url ?? areaImgDefault),
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        listItems[index].name ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18
                        ),
                      ),
                    )
                  )
                ),
              ), 
              staggeredTileBuilder: (index) => StaggeredTile.count(1, index == 0 ? 1.2 : 1)
            );
          }
        }
      )
    );   
  }


  String getAddress(List<ProductData> data, int index) {
    if (data[index].address.isEmpty) {
      if (data[index].area.name == null) {
        return "Viet Nam";
      } else {
        return data[index].area.name!;
      }
    } else {
      return data[index].address;
    }
  }

}
