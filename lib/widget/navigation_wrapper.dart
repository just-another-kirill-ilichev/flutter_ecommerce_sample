import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_sample/page/cart_page/cart_page.dart';
import 'package:flutter_ecommerce_sample/page/catalog_page/catalog_page.dart';
import 'package:flutter_ecommerce_sample/widget/animated_indexed_stack.dart';

class NavigationWrapper extends StatefulWidget {
  final int index;

  const NavigationWrapper({Key? key, required this.index}) : super(key: key);

  @override
  State<NavigationWrapper> createState() => _NavigationWrapperState();
}

class _NavigationWrapperState extends State<NavigationWrapper> {
  late int _index;

  @override
  void initState() {
    _index = widget.index;
    super.initState();
  }

  void _changePage(int newIndex) {
    setState(() {
      _index = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedIndexedStack(
        duration: const Duration(milliseconds: 200),
        index: _index,
        children: const [
          CatalogPage(),
          CartPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _changePage,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'Каталог',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'Корзина',
          ),
        ],
      ),
    );
  }
}
