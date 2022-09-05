import 'package:go_router/go_router.dart';
import 'package:template/pages/cart_page.dart';
import 'package:template/pages/main_page.dart';
import 'package:template/pages/product_detail_page.dart';
import 'package:template/pages/sign_in_page.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: MainPage.name,
      path: MainPage.path,
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      name: SignInPage.name,
      path: SignInPage.path,
      builder: (context, state) => SignInPage(),
    ),
    GoRoute(
      name: CartPage.name,
      path: CartPage.path,
      builder: (context, state) => const CartPage(),
    ),
    GoRoute(
      name: ProductDetailPage.name,
      path: ProductDetailPage.path,
      builder: (context, state) {
        final id = state.params["id"]!;

        return ProductDetailPage(id: id);
      },
    ),
  ],
);
