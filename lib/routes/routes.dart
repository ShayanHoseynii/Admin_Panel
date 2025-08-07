class TRoutes {
  static const firstScreen = '/';
  static const secondScreen = '/second-screen/';
  static const secondScreenWithUId = '/second-screen/:userid';
  static const responsiveDesignTutorialScreen = '/responsive-widget';
  static const login = '/login';
  static const forgetPassword = '/forgetPassword/';
  static const resetPassword = '/resetPassword';
  static const dashboard = '/dashboard';
  static const media = '/media';

  static const banners = '/banners';
  static const createBanner = '/createBanner';
  static const editBanner = '/editBanner';

  static const products = '/products';
  static const createProduct = '/createProducts';
  static const editProduct = '/editProduct';
  static const categories = '/categories';
  static const createCategory = '/createCategory';
  static const editCategory = '/editCategory';
  static const brands = '/brands';
  static const createBrand = '/createBrand';
  static const editBrand = '/editBrand';
  static const customers = '/customers';
  static const createCustomer = '/createCustomer';
  static const customerDetails = '/customerDetails';
  static const orders = '/orders';
  static const orderDetails = '/orderDetails';
  static List sidBarMenuItems = [
    orderDetails,
    firstScreen,
    responsiveDesignTutorialScreen,
    secondScreen,
    secondScreenWithUId,
    login,
    forgetPassword,
    resetPassword,
    dashboard,
    media,
    banners,
    createBanner,
    editBanner,
    products,
    createProduct,
    editProduct,
    categories,
    createCategory,
    editCategory,
    brands,
    createBrand,
    editBrand,
    customers,
    createCustomer,
    customerDetails,
    orders,
  ];
}
