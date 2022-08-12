import 'package:flutter/material.dart';
import 'package:flutter_sample/widgets/top_bar_widget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  static const name = "cart";
  static const path = "/cart";

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppTopBar(title: "Cart"),
      body: Text("Cart page"),
    );
  }
}
