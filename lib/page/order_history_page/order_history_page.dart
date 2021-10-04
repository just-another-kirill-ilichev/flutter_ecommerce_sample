import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/crud_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/orders_bloc/orders_bloc.dart';
import 'package:flutter_ecommerce_sample/config/app_router.dart';
import 'package:flutter_ecommerce_sample/domain/model/order/order.dart';
import 'package:flutter_ecommerce_sample/domain/service/intl_service.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';

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
              title: _buildTitle(context, item),
              subtitle: Text(item.status.stringValue),
              onTap: () => Navigator.pushNamed(
                context,
                AppRouter.orderDetails,
                arguments: item,
              ),
            );
          },
        ),
      );
    });
  }

  Widget _buildTitle(BuildContext context, Order order) {
    var service = RepositoryProvider.of<ServiceProvider>(context);

    return FutureBuilder<IntlService>(
      future: service.intlService,
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        }

        var text = snapshot.data!.defaultDateFormatter.format(order.date);

        return Text(text);
      },
    );
  }
}
