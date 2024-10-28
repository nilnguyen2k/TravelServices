class WayCartArguments {
  //  True from home, False from add to cart
  final bool way;
  final int? idService;

  WayCartArguments({
    this.idService,
    required this.way
  });
}