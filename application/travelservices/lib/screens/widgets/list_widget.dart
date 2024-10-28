import 'package:flutter/material.dart';
import 'package:travelservices/configs/constants.dart';

class ListOption extends StatefulWidget {
  
  final List<Map<String, dynamic>> items;
  final double scrolled;

  const ListOption({
    Key? key,
    required this.items,
    required this.scrolled,
  }) : super(key: key);

  @override
  State<ListOption> createState() => _ListOptionState();
}

class _ListOptionState extends State<ListOption> {
  
  int currentIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: paddingWidth),
      height: 40,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.items[index]['name'].toString(),
                  style: TextStyle(
                    fontSize: 19,
                    color: changeColor(index, widget.scrolled)
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }


  Color changeColor(int index, double scrolled) {
    if (scrolled + 530 >= widget.items[index]['position'] && scrolled + 530 < widget.items[index+1]['position']) {
      return Colors.blue.shade600;
    } else {
      return Colors.grey.shade300;
    }
  }
}