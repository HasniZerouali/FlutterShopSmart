import 'package:flutter/material.dart';
import 'package:shopsmart_users/screens/inner_screens/orders/orders_widget.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/title_text.dart';

class OrdersScreenFree extends StatefulWidget {
  const OrdersScreenFree({super.key});
  static const routeName = '/OrderScreen';

  @override
  State<OrdersScreenFree> createState() => _OrdersScreenFreeState();
}

class _OrdersScreenFreeState extends State<OrdersScreenFree> {
  bool isEmptyOrders = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(
          label: 'Placed orders',
        ),
      ),
      body: isEmptyOrders
          ? EmptyBagWidget(
              imagePath: AssetsManager.orderBag,
              title: "No orders has been placed yet",
              subtitle: "",
              buttonText: "Shop now")
          : ListView.separated(
              itemBuilder: (ctx, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrdersWidgetFree(),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  thickness: 0.3,
                );
              },
              itemCount: 15,
            ),
    );
  }
}
