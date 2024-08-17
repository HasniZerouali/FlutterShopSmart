import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:shopsmart_users/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  // with mixin ChangeNotifier lazam tzidha min tasta3mal provider bach tatsama3 3la changes
// bach tnajam tasama3 bl provider 3la widget lazam tkon hiya l parent ta3hom lidalik tzidha fal main wdirha parent"fal main dirha fal MultiProvider kima dert m3a theme

  List<ProductModel> get getProducts {
    return _product;
  }

  ProductModel? findByProdId(String productId) {
    // nzido had fun bach tsa3adna tawali tmacha f ga3 screen wishlis , search 
    if (_product
        .where(
          (element) => element.productId == productId,
        )
        .isEmpty) {
      return null;
    }
    return _product.firstWhere(
      (element) => element.productId == productId,
    );
    // firstWhere awal wahda ylakiha yraja3ha ,(element fiha l9iyam ta3 list _product)
  }

  final List<ProductModel> _product = [
    // Phones
    ProductModel(
      productId: const Uuid()
          .v4(), // uuid  (creat) Cryptographically strong random number (id)
      productTitle: "Apple iPhone 14 Pro (128GB) - Black",
      productPrice: "1399.99",
      productCategory: "Phones",
      productDescription:
          "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island.",
      productImage:
          "https://media.croma.com/image/upload/v1662655585/Croma%20Assets/Communication/Mobiles/Images/261976_j6acr4.png",
      productQuantity: "10",
    ),
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Samsung Galaxy S21 Ultra - Phantom Black",
      productPrice: "1199.99",
      productCategory: "Phones",
      productDescription:
          "6.8-inch AMOLED display, 108MP camera, 5000mAh battery, 12GB RAM.",
      productImage:
          "https://shop.samsung.com/ie/images/products/27511/14946/600x600/SM-G998BZKDEUA.png",
      productQuantity: "15",
    ),
    // Laptops
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "MacBook Pro 16-inch - M1 Pro Chip",
      productPrice: "2499.99",
      productCategory: "Laptops",
      productDescription:
          "16-inch Retina display, M1 Pro chip, 16GB RAM, 512GB SSD.",
      productImage:
          "https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111901_mbp16-gray.png",
      productQuantity: "8",
    ),
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Dell XPS 13 - Intel i7",
      productPrice: "1499.99",
      productCategory: "Laptops",
      productDescription:
          "13.4-inch FHD display, Intel i7, 16GB RAM, 512GB SSD, Windows 11.",
      productImage:
          "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/xps-notebooks/xps-13-9320/media-gallery/xs9320nt-xnb-shot-5-1-sl.psd?fmt=png-alpha&pscan=auto&scl=1&wid=3782&hei=2988&qlt=100,1&resMode=sharp2&size=3782,2988&chrss=full&imwidth=5000",
      productQuantity: "5",
    ),
    // Electronics
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Sony WH-1000XM4 Noise Cancelling Headphones",
      productPrice: "349.99",
      productCategory: "Electronics",
      productDescription:
          "Industry-leading noise canceling with Dual Noise Sensor technology.",
      productImage:
          "https://store.sony.co.nz/dw/image/v2/ABBC_PRD/on/demandware.static/-/Sites-sony-master-catalog/default/dw72e2d384/images/WH1000XM4S/WH1000XM4S.png",
      productQuantity: "25",
    ),
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "GoPro HERO9 Black",
      productPrice: "399.99",
      productCategory: "Electronics",
      productDescription:
          "5K video, 20MP photos, front and rear LCD displays, 30% more battery life.",
      productImage:
          "https://de42lpjv8o9m4.cloudfront.net/products/PRO00-00324/images/proframe_location_camera_action_gopro_hero9_black_2.png",
      productQuantity: "12",
    ),
    // Watches
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Apple Watch Series 7 - 45mm",
      productPrice: "499.99",
      productCategory: "Watches",
      productDescription:
          "Always-On Retina display, Blood Oxygen app, ECG app, 50m water resistant.",
      productImage:
          "https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111909_series7-480.png",
      productQuantity: "20",
    ),

    ///////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    ///////////////////////////////////////////////////////////////////////////////////
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Samsung Galaxy Watch 4 - 44mm",
      productPrice: "249.99",
      productCategory: "Watches",
      productDescription:
          "Track your fitness, sleep, and heart rate with this powerful smartwatch.",
      productImage:
          "https://image-us.samsung.com/us/smartphones/galaxy-z-fold3-5g/wise-fresh-berry/watch4-classic-fresh/gallery/bluetooth/44mm/black/Gallery-Watch4-44MM-BT-R-Perspective-Black-1600x1200.jpg?\$product-details-jpg\$",
      productQuantity: "22",
    ),
    // Clothes
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Nike Air Max 90",
      productPrice: "129.99",
      productCategory: "Shoes",
      productDescription:
          "Classic Nike Air Max sneakers with a comfortable fit and stylish design.",
      productImage:
          "https://static.nike.com/a/images/t_default/6503c132-2b17-477a-a526-b395b01d9497/custom-air-max-90-shoes-by-you.png",
      productQuantity: "30",
    ),
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Levi's 501 Original Fit Jeans",
      productPrice: "59.99",
      productCategory: "Clothes",
      productDescription:
          "Iconic straight fit jeans with a button fly and durable construction.",
      productImage: "https://content.stylitics.com/images/items/1115936",
      productQuantity: "40",
    ),
    // Shoes
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Adidas Ultraboost 21",
      productPrice: "180.00",
      productCategory: "Shoes",
      productDescription:
          "Responsive running shoes with a supportive feel and cushioned ride.",
      productImage:
          "https://static.runnea.com/images/202012/adidas-ultraboost-21-amarillas-840xXx90.png?0",
      productQuantity: "35",
    ),
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Puma RS-X3 Puzzle",
      productPrice: "110.00",
      productCategory: "Shoes",
      productDescription:
          "Chunky retro sneakers with bold colorways and a comfortable fit.",
      productImage:
          "https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_450,h_450/global/372884/01/sv01/fnd/PNA/fmt/png/RS-X3-Puzzle-Men's-Sneakers",
      productQuantity: "20",
    ),
    // Books
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Atomic Habits by James Clear",
      productPrice: "16.99",
      productCategory: "Books",
      productDescription:
          "An easy & proven way to build good habits & break bad ones.",
      productImage:
          "https://m.media-amazon.com/images/I/51-nXsSRfZL._SX329_BO1,204,203,200_.jpg",
      productQuantity: "50",
    ),
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "The Lean Startup by Eric Ries",
      productPrice: "14.99",
      productCategory: "Books",
      productDescription:
          "How today's entrepreneurs use continuous innovation to create radically successful businesses.",
      productImage:
          "https://images-na.ssl-images-amazon.com/images/I/81-QB7nDh4L.jpg",
      productQuantity: "40",
    ),
    // Cosmetics
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "Maybelline Fit Me Foundation",
      productPrice: "7.99",
      productCategory: "Cosmetics",
      productDescription:
          "Matte and poreless foundation for a natural, flawless look.",
      productImage:
          "https://media.ulta.com/i/ulta/2295394?w=1089&h=1089&fmt=auto",
      productQuantity: "60",
    ),
    ProductModel(
      productId: const Uuid().v4(),
      productTitle: "L'Oréal Paris Voluminous Mascara",
      productPrice: "8.99",
      productCategory: "Cosmetics",
      productDescription: "Dramatic volume and definition for your lashes.",
      productImage:
          "https://media.ulta.com/i/ulta/2063643?w=1089&h=1089&fmt=auto",
      productQuantity: "70",
    ),
  ];
}
