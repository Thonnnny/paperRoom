class RestApis {
  //En este archivo se encuentran las rutas de la API
  //////////////////GET/////////////////////
  static String getRefresh = 'https://thepaperoom.com/api/refreshToken';
  static String getCart = 'https://thepaperoom.com/api/cart';
  static String getProducts = 'https://thepaperoom.com/api/products';
  static String getLogOut = 'https://thepaperoom.com/api/logout';
  static String getSingleProduct =
      'https://thepaperoom.com/api/products/'; //+id
  static String getProductInOffer =
      'https://thepaperoom.com/api/products/offers';
  static String getCountry = 'https://thepaperoom.com/api/getCountries';
  static String getSubdivision =
      'https://thepaperoom.com/api/getSubdivisionsByCountry/'; //+idCountry
  static String getCities =
      'https://thepaperoom.com/api/getCitiesBySubdivision/';
  static String getActiveOrders =
      'https://thepaperoom.com/api/getActivesOrders';
  static String getHistoryOrders = 'https://thepaperoom.com/api/ordersHistory';
  static String getOrderDetails =
      'https://thepaperoom.com/api/orderDetails/'; //+idOrder

  //////////////////POST/////////////////////
  static String apiLogin = 'https://thepaperoom.com/api/login';
  static String apiRegister = 'https://thepaperoom.com/api/register';
  static String apiAddProductToOrder =
      'https://thepaperoom.com/api/addProductToOrder';
  static String apiRemoveProductFromOrder =
      'https://thepaperoom.com/api/removeProductFromOrder';
  static String apiCreateOrder = 'https://thepaperoom.com/api/confirmOrder';
}
