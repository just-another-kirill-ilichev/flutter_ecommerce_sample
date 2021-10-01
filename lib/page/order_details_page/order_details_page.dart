import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/crud_bloc.dart';
import 'package:flutter_ecommerce_sample/bloc/generic/crud_bloc/data_filter.dart';
import 'package:flutter_ecommerce_sample/bloc/products_bloc/products_bloc.dart';
import 'package:flutter_ecommerce_sample/domain/model/order/order.dart';
import 'package:flutter_ecommerce_sample/domain/model/product.dart';
import 'package:flutter_ecommerce_sample/domain/service/service_provider.dart';

class OrderDetailsPage extends StatefulWidget {
  final Order? order;

  const OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  late ProductsBloc _bloc;

  @override
  void initState() {
    var servicesProvider = RepositoryProvider.of<ServiceProvider>(context);
    var products = widget.order?.items.map((e) => e.productId).toList();

    var filter =
        products != null ? WithIdDataFilter<Product, String>(products) : null;

    // TODO?: Add another bloc
    _bloc = ProductsBloc.started(servicesProvider, filter);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<ProductsBloc, CrudState<Product>>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is DataLoadSuccess<Product>) {
            return _buildData(state.data);
          }

          // TODO: Error layout

          return _buildLoading();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator.adaptive());
  }

  Widget _buildData(List<Product> products) {
    return ListView.builder(
      itemCount: widget.order?.items.length ?? 0,
      itemBuilder: (_, index) {
        return ListTile(
          title: Text(products[index].title),
          trailing: Text(widget.order!.items[index].amount.toString()),
        );
      },
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
