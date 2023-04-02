import 'dart:core';

class Category {
  final String name;
  late int sumOfItemsInCategory;
  late int sumOfItemsInInventory;
  final String? thumbnail;

  Category({
    required this.name,
    required this.sumOfItemsInCategory,
    required this.sumOfItemsInInventory,
    required this.thumbnail,
  });

  void setNumberOfItemsInCategory(int num) {
    sumOfItemsInCategory = num;
  }

  void setNumberOfItemsInInventory(int num) {
    sumOfItemsInInventory = num;
  }
}
