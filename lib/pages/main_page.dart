import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:template/pages/cart_page.dart';
import 'package:template/pages/home_page.dart';
import 'package:template/widgets/bottom_bar_widget.dart';

class MainPage extends HookWidget {
  const MainPage({super.key});

  static const name = "main";
  static const path = "/";

  @override
  Widget build(BuildContext context) {
    final index = useState(0);

    return Scaffold(
      body: IndexedStack(
        index: index.value,
        children: const [
          HomePage(),
          CartPage(),
        ],
      ),
      bottomNavigationBar: AppBottomBar(
        index: index.value,
        onIndexChange: (value) => index.value = value,
      ),
    );
  }
}
