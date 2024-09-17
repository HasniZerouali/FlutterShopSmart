import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:shopsmart_users/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  // with mixin ChangeNotifier lazam tzidha min tasta3mal provider bach tatsama3 3la changes
// bach tnajam tasama3 bl provider 3la widget lazam tkon hiya l parent ta3hom lidalik tzidha fal main wdirha parent"fal main dirha fal MultiProvider kima dert m3a theme

//di nbayno broduct fal serch  bal " strims" bach tkon real time ri ydir reflech yatal3olah jdod
  final List<ProductModel> _product = [];

  List<ProductModel> get getProducts {
    List<ProductModel> sortedProducts = List.from(_product);
    // Create a copy of the list
    sortedProducts
        .sort((a, b) => a.productCategory.compareTo(b.productCategory));
    // Sort by productCategory
    return sortedProducts;
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

  List<ProductModel> findByCategory({required String ctgName}) {
    List<ProductModel> ctgList = _product
        .where((element) => element.productCategory
            .toLowerCase()
            .contains(ctgName.toLowerCase()))
        .toList();
    return ctgList;
  }

  List<ProductModel> searchQuery(
      {required String searchText, required List<ProductModel> list}) {
    List<ProductModel> searchList = list
        .where((element) => element.productTitle
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
    return searchList;
  }

  final productDB = FirebaseFirestore.instance.collection("products");
  //hadi tarika lawla bach nakra product mawjouda fal firestore
  Future<List<ProductModel>> fetchProducts() async {
    try {
      //haka bla uid bach njib ga3 products li kaynin fal fireStore
      // then() t9ara3 hata tkaml li 9balh bach tbda li moraha
      await productDB.get().then((productSnapshot) {
        _product.clear();
        for (var element in productSnapshot.docs) {
          // nfoto 3la ga3 element ta3 list product"productSnapshot"
          _product.insert(0, ProductModel.fromFirestore(element));

          //ndiro factory constactur khir (from json to json) , najmnir kima dart m3a userProvider
        }
      });
      notifyListeners();
      return _product;
    } catch (error) {
      rethrow;
    }
  }

//kayan tarika taniya tkon real time (bal strem) , screen tatraya id zadt product wla modifit fih fal firebase bla madir reflech , liana firebase realtime DB
  Stream<List<ProductModel>> fetchProductsStream() {
    try {
      return productDB
          .orderBy("createdAt", descending: false)// hadi zadtha bach yratabhom matali hasb w9T "createdAt" , bach ndirha fal latesAraival
          .snapshots()
          .map((snapshot) {
        _product.clear();
        // ndir fiblasat if  , clear
        for (var element in snapshot.docs) {
          // nfoto 3la ga3 element ta3 list product"productSnapshot"
          // if (findByProdId(element.data()['productId']) == null) {
          //   // if() ,bach mayog3od kon madir run yzid nafs product khtrch rani dayar insert
          //   _product.insert(0, ProductModel.fromFirestore(element));
          // }
          _product.insert(0, ProductModel.fromFirestore(element));
          //ndiro factory constactur khir (from json to json) , najmnir kima dart m3a userProvider
        }
        return _product; //list hadi walat Stream
      });
    } catch (e) {
      rethrow;
    }
  }

//   final List<ProductModel> _product = [
//     ProductModel(
//       //1
//       productId: 'iphone14-128gb-black',
//       productTitle: "Apple iPhone 14 Pro (128GB) - Black",
//       productPrice: "1399.99",
//       productCategory: "Phones",
//       productDescription:
//           "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island, a new and magical way to interact with your iPhone. 48MP main camera for up to 4x higher resolution. Cinematic mode, now in 4K Dolby Vision up to 30 fps. Action mode, for stable and smooth videos when you're on the move. Accident detection, vital safety technology that calls for help for you. All-day battery life and up to 23 hours of video playback.",
//       productImage: "https://i.ibb.co/BtMBSgK/1-iphone14-128gb-black.webp",
//       productQuantity: "10",
//     ),
//     ProductModel(
//       //2
//       productId: 'iphone13-mini-256gb-midnight',
//       productTitle:
//           "iPhone 13 Mini, 256GB, Midnight - Unlocked (Renewed Premium)",
//       productPrice: "659.99",
//       productCategory: "Phones",
//       productDescription:
//           "5.4 Super Retina XDR display. 5G Superfast downloads, high quality streaming. Cinematic mode in 1080p at 30 fps. Dolby Vision HDR video recording up to 4K at 60 fps. 2X Optical zoom range. A15 Bionic chip. New 6-core CPU with 2 performance and 4 efficiency cores. New 4-core GPU. New 16-core Neural Engine. Up to 17 hours video playback. Face ID. Ceramic Shield front. Aerospace-grade aluminum. Water resistant to a depth of 6 meters for up to 30 minutes. Compatible with MagSafe accessories and wireless chargers.",
//       productImage:
//           "https://i.ibb.co/nbwTvXQ/2-iphone13-mini-256gb-midnight.webp",
//       productQuantity: "15",
//     ),

//     ProductModel(
//       //5
//       productId: const Uuid().v4(),
//       productTitle:
//           "Samsung Galaxy S21 Ultra 5G | Factory Unlocked Android Cell Phone | US Version 5G Smartphone",
//       productPrice: "1199.99",
//       productCategory: "Phones",
//       productDescription:
//           "About this item\nPro Grade Camera: Zoom in close with 100X Space Zoom, and take photos and videos like a pro with our easy-to-use, multi-lens camera.\n100x Zoom: Get amazing clarity with a dual lens combo of 3x and 10x optical zoom, or go even further with our revolutionary 100x Space Zoom.\nHighest Smartphone Resolution: Crystal clear 108MP allows you to pinch, crop and zoom in on your photos to see tiny, unexpected details, while lightning-fast Laser Focus keeps your focal point clear\nAll Day Intelligent Battery: Intuitively manages your cellphone’s usage, so you can go all day without charging (based on average battery life under typical usage conditions).\nPower of 5G: Get next-level power for everything you love to do with Samsung Galaxy 5G; More sharing, more gaming, more experiences and never miss a beat",
//       productImage:
//           "https://i.ibb.co/ww5WjkV/5-Samsung-Galaxy-S21-Ultra-5-G.png",
//       productQuantity: "3625",
//     ),
//     ProductModel(
//       //6
//       productId: const Uuid().v4(),
//       productTitle:
//           "OnePlus 9 Pro 5G LE2120 256GB 12GB RAM Factory Unlocked (GSM Only | No CDMA - not Compatible with Verizon/Sprint) International Version - Morning Mist",
//       productPrice: "1099.99",
//       productCategory: "Phones",
//       productDescription:
//           "About this item\n6.7 inch LTPO Fluid2 AMOLED, 1B colors, 120Hz, HDR10+, 1300 nits (peak)\n256GB internal storage, 12GB RAM\nQuad rear camera: 48MP, 50MP, 8MP, 2MP\n16MP front-facing camera\n4500mAh battery with Warp Charge 65T (10V/6.5A) and 50W Wireless Charging\n5G capable for lightning fast download and streaming",
//       productImage:
//           "https://i.ibb.co/0yhgKVv/6-One-Plus-9-Pro-5-G-LE2120-256-GB-12-GB-RAM.png",
//       productQuantity: "3636",
//     ),

//     ProductModel(
//       //7
//       productId: const Uuid().v4(),
//       productTitle: "Samsung Galaxy Z Flip3 5G",
//       productPrice: "999.99",
//       productCategory: "Phones",
//       productDescription:
//           "About this item\nGet the latest Galaxy experience on your phone.\nFOLDING DISPLAY - Transform the way you capture, share and experience content.\nCAPTURE EVERYTHING - With the wide-angle camera and the front camera, take stunning photos and videos from every angle.\nWATER RESISTANT - Use your Galaxy Z Flip3 5G even when it rains.\nONE UI 3.1 - Enjoy the Galaxy Z Flip3 5G’s sleek, premium design and all the features you love from the latest One UI 3.1. ",
//       productImage: "https://i.ibb.co/NstFstg/7-Samsung-Galaxy-Z-Flip3-5-G.png",
//       productQuantity: "525",
//     ),

//     ProductModel(
//       //9
//       productId: const Uuid().v4(),
//       productTitle: "Xiaomi Redmi Note 10 Pro",
//       productPrice: "249.99",
//       productCategory: "Phones",
//       productDescription:
//           "About this item\n6.67-inch 120Hz AMOLED display with TrueColor\n108MP quad rear camera system with 8K video support\nQualcomm Snapdragon 732G processor\n5020mAh (typ) high-capacity battery\n33W fast charging support and 33W fast charger included in the box",
//       productImage: "https://i.ibb.co/W3QcVMv/9-Xiaomi-Redmi-Note-10-Pro.png",
//       productQuantity: "353",
//     ),
//     ProductModel(
//       //10
//       productId: const Uuid().v4(),
//       productTitle: "OnePlus 10 Pro 5G",
//       productPrice: "899.99",
//       productCategory: "Phones",
//       productDescription:
//           "About this item\n6.7 inch Fluid AMOLED Display with LTPO, 120 Hz refresh rate, 10-bit color, HDR10+, and adaptive refresh rate\nQualcomm Snapdragon 8 Gen 1 with Adreno 730 GPU\n4500 mAh battery with Warp Charge 65T (10V/6.5A) + Wireless Warp Charge 50\n256GB Internal Storage | 12GB RAM\nOxygenOS 12 based on Android 12 with Play Store",
//       productImage: "https://i.ibb.co/9vGVHQk/10-One-Plus-10-Pro-5-G.png",
//       productQuantity: "3873",
//     ),
//     ProductModel(
//       //11
//       productId: const Uuid().v4(),
//       productTitle: "Google Pixel 6",
//       productPrice: "799.99",
//       productCategory: "Phones",
//       productDescription:
//           "About this item\nPowered by Google Tensor chip, designed for mobile, the Google Pixel 6 delivers exceptional AI-powered experiences.\n6.4-inch Full HD+ display with 90Hz refresh rate and HDR10+.\n50MP + 12MP dual rear camera system, 4K/60fps video recording.\n8MP front camera with Night Sight, portrait mode and more.\nBuilt-in Titan M2 security chip for advanced security.\nAndroid 12 OS with three years of updates and monthly security patches.",
//       productImage: "https://i.ibb.co/0K8ZxZj/11-Google-Pixel-6.png",
//       productQuantity: "62332",
//     ),
//     // Laptops
//     // https://i.ibb.co/MDcGHsb/12-ASUS-ROG-Zephyrus-G15.jpg

//     ProductModel(
//       //13
//       productId: const Uuid().v4(),
//       productTitle: "Acer Predator Helios 300",
//       productPrice: "1199.99",
//       productCategory: "Laptops",
//       productDescription:
//           "About this item\n10th Generation Intel Core i7-10750H 6-Core Processor (Up to 5.0 GHz) with Windows 10 Home 64 Bit\nOverclockable NVIDIA GeForce RTX 3060 Laptop GPU with 6 GB of dedicated GDDR6 VRAM, NVIDIA DLSS, NVIDIA Dynamic Boost 2.0, NVIDIA GPU Boost\n15.6\" Full HD (1920 x 1080) Widescreen LED-backlit IPS Display (144Hz Refresh Rate, 3ms Overdrive Response Time & 300nit Brightness)",
//       productImage: "https://i.ibb.co/tcB3HXJ/13-Acer-Predator-Helios-300.webp",
//       productQuantity: "5353",
//     ),
//     ProductModel(
//       //14
//       productId: const Uuid().v4(),
//       productTitle: "Razer Blade 15 Base",
//       productPrice: "1599.99",
//       productCategory: "Laptops",
//       productDescription:
//           "About this item\nMore power: The 10th Gen Intel Core i7-10750H processor provides the ultimate level of performance with up to 5.0 GHz max turbo and 6 cores\nSupercharger: NVIDIA GeForce GTX 1660 Ti graphics delivers faster, smoother gameplay\nThin and compact: The CNC aluminum unibody frame houses incredible performance in the most compact footprint possible, while remaining remarkably durable and just 0.78\" thin",
//       productImage: "https://i.ibb.co/XDtWpXC/14-Razer-Blade-15-Base.png",
//       productQuantity: "5335",
//     ),
//     ProductModel(
//       //15
//       productId: const Uuid().v4(),
//       productTitle: "MSI GS66 Stealth",
//       productPrice: "1999.99",
//       productCategory: "Laptops",
//       productDescription:
//           "About this item\n15.6\" FHD, Anti-Glare Wide View Angle 240Hz 3ms | NVIDIA GeForce RTX 2070 Max-Q 8G GDDR6\nIntel Core i7-10750H 2.6 - 5.0GHz | Intel Wi-Fi 6 AX201(22 ax)\n16GB (8G2) DDR4 3200MHz | 2 Sockets | Max Memory 64GB\nUSB 3.2 Gen2 3 | Thunderbolt 31 PD charge",
//       productImage: "https://i.ibb.co/0Q4xHVn/15-MSI-GS66-Stealth.png",
//       productQuantity: "2599",
//     ),

//     // WATCHES
//     ProductModel(
//       //16
//       productId: const Uuid().v4(),
//       productTitle: "Apple Watch Series 7",
//       productPrice: "399.99",
//       productCategory: "Watches",
//       productDescription:
//           "About this item\nAlways-On Retina display has been redesigned to be larger, yet still always on, so you can easily see the time and your watch face.\nAdvanced workout features let you measure your blood oxygen level, sleep, and heart rate, and there are cycling, yoga, and dance workouts to choose from.\nChoose from new watch faces, new colors, and new bands, including the Hermès Fastener, which is inspired by the buckle on the straps of Hermès horse harnesses.\nApple Watch Series 7 has a water resistance rating of 50 meters under ISO standard 22810:2010.",
//       productImage: "https://i.ibb.co/8cNwrbJ/16-Apple-Watch-Series-7.png",
//       productQuantity: "535352",
//     ),
//     ProductModel(
//       //17
//       productId: const Uuid().v4(),
//       productTitle: "Samsung Galaxy Watch 4",
//       productPrice: "249.99",
//       productCategory: "Watches",
//       productDescription:
//           "About this item\nTake your fitness to the next level with advanced sensors that track your body composition, heart rate, sleep quality, and more.\nThe watch automatically detects and tracks over 90 different exercises, from running and cycling to swimming and rowing.\nGalaxy Watch 4 lets you control your smart home devices right from your wrist, so you can turn off the lights, adjust the thermostat, and more.\nThe watch comes with a choice of watch faces, so you can customize it to match your style.",
//       productImage: "https://i.ibb.co/tsq0VD8/17-Samsung-Galaxy-Watch-4.png",
//       productQuantity: "252",
//     ),
//     ProductModel(
//       //18
//       productId: const Uuid().v4(),
//       productTitle: "Fitbit Sense Advanced Smartwatch",
//       productPrice: "299.95",
//       productCategory: "Watches",
//       productDescription:
//           "About this item\nThe Fitbit Sense is an advanced smartwatch that tracks your heart rate, skin temperature, and stress levels.\nIt also has built-in GPS and lets you control your Spotify music right from your wrist.\nThe watch comes with a choice of watch faces, and you can customize it with a variety of bands.\nThe battery lasts up to 6 days, so you can wear it all week without needing to recharge it.",
//       productImage:
//           "https://i.ibb.co/jrVQppF/18-Fitbit-Sense-Advanced-Smartwatch.png",
//       productQuantity: "526",
//     ),
//     ProductModel(
//       //19
//       productId: const Uuid().v4(),
//       productTitle: "Garmin Forerunner 945 LTE",
//       productPrice: "649.99",
//       productCategory: "Watches",
//       productDescription:
//           "About this item\nThe Garmin Forerunner 945 LTE is a high-end GPS running watch with LTE connectivity, so you can leave your phone at home.\nIt has built-in music storage and lets you pay for purchases with Garmin Pay.\nThe watch comes with a choice of watch faces, and you can customize it with a variety of bands.\nThe battery lasts up to 10 days in smartwatch mode and up to 36 hours in GPS mode with music.",
//       productImage: "https://i.ibb.co/xXhSfTh/19-Garmin-Forerunner-945-LTE.png",
//       productQuantity: "58385",
//     ),
//     // SHOES

//     ProductModel(
//       //21
//       productId: const Uuid().v4(),
//       productTitle: "Adidas Ultraboost 21",
//       productPrice: "180.53",
//       productCategory: "Shoes",
//       productDescription:
//           "About this item\nResponsive Boost midsole\n3D Heel Frame\nSock-like fit\nPrimeknit+ upper\nStretchweb outsole with Continental™ Rubber",
//       productImage: "https://i.ibb.co/QM1dLww/21-Adidas-Ultraboost-21.webp",
//       productQuantity: "7654",
//     ),
//     ProductModel(
//       //22
//       productId: const Uuid().v4(),
//       productTitle: "Converse Chuck Taylor All Star High Top",
//       productPrice: "55.12",
//       productCategory: "Shoes",
//       productDescription:
//           "About this item\n100% Synthetic\nImported\nRubber sole\nShaft measures approximately 4.5 from arch\nPlatform measures approximately 0.25\nLace-up, high-top sneaker\nOrthoLite insole for cushioning\nMedial eyelets for airflow\nCanvas upper",
//       productImage:
//           "https://i.ibb.co/TBQv7G6/22-Converse-Chuck-Taylor-All-Star-High-Top.png",
//       productQuantity: "36437",
//     ),

//     ProductModel(
//       //24
//       productId: const Uuid().v4(),
//       productTitle: "Vans Old Skool",
//       productPrice: "60.33",
//       productCategory: "Shoes",
//       productDescription:
//           "About this item\nCanvas and suede upper for durability\nReinforced toe cap for added durability\nPadded collar for support and flexibility\nVulcanized construction for durability and grip\nSignature rubber waffle outsole for traction",
//       productImage: "https://i.ibb.co/NNDk3pt/24-Vans-Old-Skool.png",
//       productQuantity: "3637",
//     ),
//     ProductModel(
//       //25
//       productId: const Uuid().v4(),
//       productTitle: "Adidas Ultraboost 21",
//       productPrice: "180.7",
//       productCategory: "Shoes",
//       productDescription:
//           "About this item\nBoost cushioning technology delivers comfort and energy return with every step\n3D Heel Frame cradles the heel for natural fit and optimal movement of the Achilles\nPrimeknit+ upper adapts to the changing shape of your foot through the gait cycle\nTorsion System provides a stable feel from heel strike to toe-off\nStretchweb outsole flexes naturally for an energized ride",
//       productImage: "https://i.ibb.co/VmvdBqC/25-Adidas-Ultraboost-21.webp",
//       productQuantity: "8565",
//     ),
//     ProductModel(
//       //26
//       productId: const Uuid().v4(),
//       productTitle: "Nike Air Max 270",
//       productPrice: "150.78",
//       productCategory: "Shoes",
//       productDescription:
//           "About this item\nLarge Max Air unit delivers plush cushioning and all-day comfort\nNeoprene stretch bootie design delivers a snug fit\n3-piece midsole offers durability and a smooth transition\nMono-mesh window in the quarter and engineered mesh in the forefoot provide durability\nRubber toe tip provides durability and grip during training movements such as planks and push-ups",
//       productImage: "https://i.ibb.co/Tk3WDX1/26-Nike-Air-Max-270.png",
//       productQuantity: "6437",
//     ),
//     ProductModel(
//       //27
//       productId: const Uuid().v4(),
//       productTitle: "New Balance Fresh Foam 1080v11",
//       productPrice: "149.99",
//       productCategory: "Shoes",
//       productDescription:
//           "About this item\nFresh Foam midsole cushioning is precision engineered to deliver an ultra-cushioned, lightweight ride\nSynthetic/mesh upper\nOrtholite sockliner for comfort\nBlown rubber outsole provides durability\nUltra Heel design hugs the back of the foot for a snug, supportive fit",
//       productImage:
//           "https://i.ibb.co/5rxL1Ck/27-New-Balance-Fresh-Foam-1080v11.png",
//       productQuantity: "7853",
//     ),
//     ProductModel(
//       //28
//       productId: const Uuid().v4(),
//       productTitle: "Puma Future Z 1.1 FG/AG Soccer Cleats",
//       productPrice: "199.99",
//       productCategory: "Shoes",
//       productDescription:
//           "About this item\nAdaptive FUZIONFIT+ compression band for unparalleled fit and lockdown\nMATRYXEVO woven upper constructed with reactive Kevlar and Carbon yarns for support during fast-forward motion\nDynamic Motion System outsole provides grip and agility\nGripControl Pro coating for better ball control",
//       productImage: "https://i.ibb.co/8bMhmCj/28-Puma-Future-Z-1-1-FG.webp",
//       productQuantity: "474",
//     ),
//     // Clothes

//     ProductModel(
//       //31
//       productId: const Uuid().v4(),
//       productTitle: "Fitbit Charge 5 Advanced Fitness Tracker",
//       productPrice: "179.95",
//       productCategory: "Watches",
//       productDescription:
//           "About this item\nAdvanced sensors track daily activity, sleep, and stress levels\nUp to 7-day battery life\nEasily track heart rate and exercise metrics\nReceive notifications and control music from your wrist\nWater-resistant up to 50m\nConnect to your phone's GPS to track outdoor activities",
//       productImage:
//           "https://i.ibb.co/Wz2yzQ7/31-Fitbit-Charge-5-Advanced-Fitness-Tracker.png",
//       productQuantity: "347343",
//     ),

//     ProductModel(
//       //35
//       productId: const Uuid().v4(),
//       productTitle: "Converse Chuck Taylor All Star Low Top",
//       productPrice: "50.9",
//       productCategory: "Shoes",
//       productDescription:
//           "About this item\nLow-top sneaker with canvas upper\nIconic silhouette\nOrthoLite insole for comfort\nDiamond outsole tread\nUnisex Sizing",
//       productImage:
//           "https://i.ibb.co/TBQv7G6/22-Converse-Chuck-Taylor-All-Star-High-Top.png",
//       productQuantity: "47433",
//     ),
//     ProductModel(
//       //36
//       productId: const Uuid().v4(),
//       productTitle: "Vans Old Skool Classic Skate Shoes",
//       productPrice: "65.99",
//       productCategory: "Shoes",
//       productDescription:
//           "About this item\nSuede and Canvas Upper\nRe-enforced toecaps\nPadded collars\nSignature rubber waffle outsole",
//       productImage: "https://i.ibb.co/NNDk3pt/24-Vans-Old-Skool.png",
//       productQuantity: "383",
//     ),
// // ///////////////////////////////////////////////////////////////////////

//     // Phones
//     ProductModel(
//       productId: const Uuid()
//           .v4(), // uuid  (creat) Cryptographically strong random number (id)
//       productTitle: "Apple iPhone 14 Pro (128GB) - Black",
//       productPrice: "1399.99",
//       productCategory: "Phones",
//       productDescription:
//           "6.1-inch Super Retina XDR display with ProMotion and always-on display. Dynamic Island.",
//       productImage:
//           "https://media.croma.com/image/upload/v1662655585/Croma%20Assets/Communication/Mobiles/Images/261976_j6acr4.png",
//       productQuantity: "10",
//     ),
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "Samsung Galaxy S21 Ultra - Phantom Black",
//       productPrice: "1199.99",
//       productCategory: "Phones",
//       productDescription:
//           "6.8-inch AMOLED display, 108MP camera, 5000mAh battery, 12GB RAM.",
//       productImage:
//           "https://shop.samsung.com/ie/images/products/27511/14946/600x600/SM-G998BZKDEUA.png",
//       productQuantity: "15",
//     ),
//     // Laptops
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "MacBook Pro 16-inch - M1 Pro Chip",
//       productPrice: "2499.99",
//       productCategory: "Laptops",
//       productDescription:
//           "16-inch Retina display, M1 Pro chip, 16GB RAM, 512GB SSD.",
//       productImage:
//           "https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111901_mbp16-gray.png",
//       productQuantity: "8",
//     ),
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "Dell XPS 13 - Intel i7",
//       productPrice: "1499.99",
//       productCategory: "Laptops",
//       productDescription:
//           "13.4-inch FHD display, Intel i7, 16GB RAM, 512GB SSD, Windows 11.",
//       productImage:
//           "https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/xps-notebooks/xps-13-9320/media-gallery/xs9320nt-xnb-shot-5-1-sl.psd?fmt=png-alpha&pscan=auto&scl=1&wid=3782&hei=2988&qlt=100,1&resMode=sharp2&size=3782,2988&chrss=full&imwidth=5000",
//       productQuantity: "5",
//     ),
//     // Electronics
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "Sony WH-1000XM4 Noise Cancelling Headphones",
//       productPrice: "349.99",
//       productCategory: "Electronics",
//       productDescription:
//           "Industry-leading noise canceling with Dual Noise Sensor technology.",
//       productImage:
//           "https://store.sony.co.nz/dw/image/v2/ABBC_PRD/on/demandware.static/-/Sites-sony-master-catalog/default/dw72e2d384/images/WH1000XM4S/WH1000XM4S.png",
//       productQuantity: "25",
//     ),
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "GoPro HERO9 Black",
//       productPrice: "399.99",
//       productCategory: "Electronics",
//       productDescription:
//           "5K video, 20MP photos, front and rear LCD displays, 30% more battery life.",
//       productImage:
//           "https://de42lpjv8o9m4.cloudfront.net/products/PRO00-00324/images/proframe_location_camera_action_gopro_hero9_black_2.png",
//       productQuantity: "12",
//     ),
//     // Watches
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "Apple Watch Series 7 - 45mm",
//       productPrice: "499.99",
//       productCategory: "Watches",
//       productDescription:
//           "Always-On Retina display, Blood Oxygen app, ECG app, 50m water resistant.",
//       productImage:
//           "https://cdsassets.apple.com/live/SZLF0YNV/images/sp/111909_series7-480.png",
//       productQuantity: "20",
//     ),

//     // Clothes
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "Nike Air Max 90",
//       productPrice: "129.99",
//       productCategory: "Shoes",
//       productDescription:
//           "Classic Nike Air Max sneakers with a comfortable fit and stylish design.",
//       productImage:
//           "https://static.nike.com/a/images/t_default/6503c132-2b17-477a-a526-b395b01d9497/custom-air-max-90-shoes-by-you.png",
//       productQuantity: "30",
//     ),
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "Levi's 501 Original Fit Jeans",
//       productPrice: "59.99",
//       productCategory: "Clothes",
//       productDescription:
//           "Iconic straight fit jeans with a button fly and durable construction.",
//       productImage: "https://content.stylitics.com/images/items/1115936",
//       productQuantity: "40",
//     ),
//     // Shoes
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "Adidas Ultraboost 21",
//       productPrice: "180.00",
//       productCategory: "Shoes",
//       productDescription:
//           "Responsive running shoes with a supportive feel and cushioned ride.",
//       productImage:
//           "https://static.runnea.com/images/202012/adidas-ultraboost-21-amarillas-840xXx90.png?0",
//       productQuantity: "35",
//     ),

//     // Books
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "Atomic Habits by James Clear",
//       productPrice: "16.99",
//       productCategory: "Books",
//       productDescription:
//           "An easy & proven way to build good habits & break bad ones.",
//       productImage:
//           "https://m.media-amazon.com/images/I/51-nXsSRfZL._SX329_BO1,204,203,200_.jpg",
//       productQuantity: "50",
//     ),
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "The Lean Startup by Eric Ries",
//       productPrice: "14.99",
//       productCategory: "Books",
//       productDescription:
//           "How today's entrepreneurs use continuous innovation to create radically successful businesses.",
//       productImage:
//           "https://images-na.ssl-images-amazon.com/images/I/81-QB7nDh4L.jpg",
//       productQuantity: "40",
//     ),
//     // Cosmetics
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "Maybelline Fit Me Foundation",
//       productPrice: "7.99",
//       productCategory: "Cosmetics",
//       productDescription:
//           "Matte and poreless foundation for a natural, flawless look.",
//       productImage:
//           "https://media.ulta.com/i/ulta/2295394?w=1089&h=1089&fmt=auto",
//       productQuantity: "60",
//     ),
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "L'Oréal Paris Voluminous Mascara",
//       productPrice: "8.99",
//       productCategory: "Cosmetics",
//       productDescription: "Dramatic volume and definition for your lashes.",
//       productImage:
//           "https://media.ulta.com/i/ulta/2063643?w=1089&h=1089&fmt=auto",
//       productQuantity: "70",
//     ),
// //
//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "Apple iPhone 13 Pro (128GB) - Graphite",
//       productPrice: "999.00",
//       productCategory: "Phones",
//       productDescription:
//           "6.1-inch Super Retina XDR display with ProMotion. Cinematic mode in 1080p at 30 fps.",
//       productImage:
//           "https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/iphone-13-pro-family-hero?wid=940&hei=1112&fmt=png-alpha&.v=1631220221000",
//       productQuantity: "15",
//     ),

//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "The Alchemist by Paulo Coelho",
//       productPrice: "14.99",
//       productCategory: "Books",
//       productDescription:
//           "A philosophical novel about a young shepherd's journey to find his personal legend.",
//       productImage: "https://m.media-amazon.com/images/I/51Z0nLAfLmL.jpg",
//       productQuantity: "50",
//     ),

//     ProductModel(
//       productId: const Uuid().v4(),
//       productTitle: "The Alchemist by Paulo Coelho",
//       productPrice: "12.99",
//       productCategory: "Books",
//       productDescription:
//           "A philosophical novel about a young shepherd's journey to find his personal legend.",
//       productImage:
//           "https://m.media-amazon.com/images/I/51bVNTqHFlL._SX329_BO1,204,203,200_.jpg",
//       productQuantity: "100",
//     ),
//   ];
}
