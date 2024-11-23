class Store {
  final String storeImage;
  final String name;
  final String address;
  final String message; // タイポ修正
  final String days;
  final int goods;

  Store({
    required this.storeImage,
    required this.name,
    required this.address,
    required this.message,
    required this.days,
    required this.goods,
  });
}
