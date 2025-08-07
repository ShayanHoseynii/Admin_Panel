import 'package:admin_panel/features/media/screens/media/media.dart';
import 'package:admin_panel/features/shop/screens/banner/all_banners/banners_screen.dart';
import 'package:admin_panel/features/shop/screens/banner/create_banner/create_banners_screen.dart';
import 'package:admin_panel/features/shop/screens/banner/edit_banner/edit_banners_screen.dart';
import 'package:admin_panel/features/shop/screens/brand/all_brands/brands.dart';
import 'package:admin_panel/features/shop/screens/brand/create_brand/create_brand.dart';
import 'package:admin_panel/features/shop/screens/brand/edit_brand/edit_brand.dart';
import 'package:admin_panel/features/shop/screens/category/all_categories/categories.dart';
import 'package:admin_panel/features/shop/screens/category/create_category/create_category.dart';
import 'package:admin_panel/features/shop/screens/category/edit_category/edit_category.dart';
import 'package:admin_panel/features/shop/screens/costumer/all_costumers/customers_screen.dart';
import 'package:admin_panel/features/shop/screens/costumer/costumer_details/customer_details_screen.dart';
import 'package:admin_panel/features/shop/screens/dashboard/dashboard_screen.dart';
import 'package:admin_panel/features/authentication/screens/forget_password/forget_password.dart';
import 'package:admin_panel/features/authentication/screens/login/login.dart';
import 'package:admin_panel/features/authentication/screens/reset_password/reset_password_screen.dart';
import 'package:admin_panel/features/shop/screens/order/all_orders/order_screen.dart';
import 'package:admin_panel/features/shop/screens/order/oder_details/order_datails.dart';
import 'package:admin_panel/features/shop/screens/product/all_products/product_screen.dart';
import 'package:admin_panel/features/shop/screens/product/create_product/create_product_screen.dart';
import 'package:admin_panel/features/shop/screens/product/edit_product/edit_product_screen.dart';
import 'package:admin_panel/routes/routes.dart';
import 'package:admin_panel/routes/routes_middleware.dart';
import 'package:get/get.dart';

class TAppRoutes {
  static final List<GetPage> pages = [
    // Login
    GetPage(name: TRoutes.login, page: () => const LoginScreen()),
    GetPage(
        name: TRoutes.forgetPassword, page: () => const ForgetPasswordScreen()),
    GetPage(
        name: TRoutes.resetPassword, page: () => const ResetPasswordScreen()),

    // Dashboard
    GetPage(
        name: TRoutes.dashboard,
        page: () => const DashboardScreen(),
        middlewares: [TRouteMiddleware()]),

    // Media
    GetPage(
        name: TRoutes.media,
        page: () => const MediaScreen(),
        middlewares: [TRouteMiddleware()]),

    // Categories
    GetPage(
        name: TRoutes.categories,
        page: () => const CategoriesScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.createCategory,
        page: () => const CreateCategoryScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.editCategory,
        page: () => const EditCategoryScreen(),
        middlewares: [TRouteMiddleware()]),

    // Brands
    GetPage(
        name: TRoutes.brands,
        page: () => const BrandsScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.createBrand,
        page: () => const CreateBrandScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.editBrand,
        page: () => const EditBrandScreen(),
        middlewares: [TRouteMiddleware()]),

    // Banners
    GetPage(
        name: TRoutes.banners,
        page: () => const BannersScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.editBanner,
        page: () => const EditBannersScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.createBanner,
        page: () => const CreateBannersScreen(),
        middlewares: [TRouteMiddleware()]),

    // Products
    GetPage(
        name: TRoutes.products,
        page: () => const ProductsScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.editProduct,
        page: () => const EditProductScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.createProduct,
        page: () => const CreateProductScreen(),
        middlewares: [TRouteMiddleware()]),

    // Customers
    GetPage(
        name: TRoutes.customers,
        page: () => const CustomersScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.customerDetails,
        page: () => const CustomerDetailsScreen(),
        middlewares: [TRouteMiddleware()]),

    // Orders
    GetPage(
        name: TRoutes.orders,
        page: () => const OrderScreen(),
        middlewares: [TRouteMiddleware()]),
    GetPage(
        name: TRoutes.orderDetails,
        page: () => const OrderDatailsScreen(),
        middlewares: [TRouteMiddleware()]),
  ];
}
