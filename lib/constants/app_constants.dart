import 'package:shopsmart_users/models/categories_model.dart';
import 'package:shopsmart_users/services/assets_manager.dart';

class AppConstants {
  static List<String> bannersImages = [
    AssetsManager.banner1,
    AssetsManager.banner2,
  ];
  static const String productImageUrl =
      "https://img.freepik.com/free-photo/white-vintage-view-new-shoes_1203-6515.jpg?w=900&t=st=1720618109~exp=1720618709~hmac=02955eb1ee0ebe58b97470a8019a1e03b2b91c5c3d494bed721cbb47f9a698ef";

  static List<CategoryModel> categoriesList = [
    CategoryModel(
      id: "Phones",
      image: AssetsManager.mobiles,
      name: "Phones",
    ),
    CategoryModel(
      id: "Laptops",
      image: AssetsManager.pc,
      name: "Laptops",
    ),
    CategoryModel(
      id: "Electronics",
      image: AssetsManager.electronics,
      name: "Electronics",
    ),
    CategoryModel(
      id: "Watches",
      image: AssetsManager.watch,
      name: "Watches",
    ),
    CategoryModel(
      id: "Clothes",
      image: AssetsManager.fashion,
      name: "Clothes",
    ),
    CategoryModel(
      id: "Shoes",
      image: AssetsManager.shoes,
      name: "Shoes",
    ),
    CategoryModel(
      id: "",
      image: AssetsManager.book,
      name: "Books",
    ),
    CategoryModel(
      id: "Cosmetics",
      image: AssetsManager.cosmetics,
      name: "Cosmetics",
    ),
  ];

  // static List<Map> categoriesList = [
  //   {"namee": "mobiles", "imagee": AssetsManager.mobiles,"id":AssetsManager.mobiles},
  //   {"namee": "mobiles", "imagee": AssetsManager.mobiles},
  //   {"namee": "mobiles", "imagee": AssetsManager.mobiles},
  //   {"namee": "mobiles", "imagee": AssetsManager.mobiles},
  // ];
}
