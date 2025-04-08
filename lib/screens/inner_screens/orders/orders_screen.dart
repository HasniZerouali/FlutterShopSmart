import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users/models/order_model.dart';
import 'package:shopsmart_users/providers/order_provider.dart';
import 'package:shopsmart_users/screens/inner_screens/orders/orders_widget.dart';
import 'package:shopsmart_users/services/assets_manager.dart';
import 'package:shopsmart_users/widgets/empty_bag.dart';
import 'package:shopsmart_users/widgets/rotating_Indicator_widget.dart';
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
    final ordersProvider = Provider.of<OrdersProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const TitlesTextWidget(
          label: 'Placed orders',
        ),
      ),
      body: FutureBuilder<List<OrdersModelAdvanced>>(
        //hna hadadt typ "<List<OrdersModelAdvanced>>" bach min tkon taktb fal snapshot ya3tik i9tirahat lal 9iyam l mawjoda fa list
        future: ordersProvider.fetchOrder(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            //hadi lawla fi halat waiting rah 3ad ydir initialisation la firebase
            return const Center(
              child: RotatingProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            //whadi ida sra error atnaa initialisation ta3 firebase
            return Center(
              child:
                  SelectableText("An error has been occured ${snapshot.error}"),
            );

            //w ida masra hata error fal initaialisation ta3 firebase t return app ta3na nrml
          } else if (!snapshot.hasData || ordersProvider.getOrders.isEmpty) {
            return EmptyBagWidget(
                imagePath: AssetsManager.orderBag,
                title: "No orders has been placed yet",
                subtitle: "",
                buttonText: "Shop now");
          }
          return ListView.separated(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                  child: OrdersWidgetFree(
                    //kont najam fi blassat constructor ndir hadi widget fi changeNotifierProvider.value 
                      ordersModelAdvanced: ordersProvider.getOrders[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            ); ;
        }),
      ),
    );
  }
}
