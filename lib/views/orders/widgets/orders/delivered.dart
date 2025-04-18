import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:zapizza/common/shimmers/foodlist_shimmer.dart';
import 'package:zapizza/constants/constants.dart';
import 'package:zapizza/hooks/fetch_orders.dart';
import 'package:zapizza/models/client_orders.dart';
import 'package:zapizza/views/orders/widgets/client_order_tile.dart';

class Delivered extends HookWidget {
  const Delivered({super.key});

  @override
  Widget build(BuildContext context) {
    final hookResults = useFetchOrders('Delivered', 'Completed');

    List<ClientOrders> orders = hookResults.data;
    final isLoading = hookResults.isLoading;

    if (isLoading) {
      return const FoodsListShimmer();
    }

    return SizedBox(
      height: height * 0.8,
      child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, i) {
            return ClientOrderTile(food: orders[i].orderItems[0]);
          }),
    );
  }
}
