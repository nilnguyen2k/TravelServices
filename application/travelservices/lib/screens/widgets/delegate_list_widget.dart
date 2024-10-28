import 'package:flutter/material.dart';
import 'package:travelservices/screens/widgets/list_widget.dart';

class DelegateListOption extends SliverPersistentHeaderDelegate {

  final List<Map<String, dynamic>> items;
  final double scrolled;
  
  DelegateListOption(this.items, this.scrolled);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 10,
            color: Colors.grey.shade50,
          ),
          ListOption(items: items, scrolled: scrolled,)
        ],
      ),
    );
  }

  @override
  double get maxExtent => 50;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}