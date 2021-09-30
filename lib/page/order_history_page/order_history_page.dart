import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/crud_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/orders_bloc/orders_bloc.dart';
import 'package:flutter_ecommerce_sample/domain/model/order/order.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, CrudState<Order>>(builder: (_, state) {
      var itemCount = state is DataLoadSuccess<Order> ? state.data.length : 0;

      return Scaffold(
        appBar: AppBar(title: const Text('История заказов')),
        body: ListView.builder(
          itemCount: itemCount,
          itemBuilder: (_, index) {
            var item = (state as DataLoadSuccess<Order>).data[index];

            return ListTile(
              title: Text(item.date.toString()),
              subtitle: Text(item.status.stringValue),
            );
          },
        ),
      );
    });
  }
}
