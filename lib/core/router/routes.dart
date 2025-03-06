abstract class AppRoutes {
  static const authPaths = [
    '/login',
    '/signup',
    '/forget-password',
    '/reset-password',
    '/verify-account',
  ];

  static const String home = 'HOME';

  //* AUTH ROUTES
  static const String login = 'LOGIN';
  static const String signup = 'SIGNUP';
  static const String forgetPassword = 'FORGET_PASSWORD';
  static const String resetPassword = 'RESET_PASSWORD';
  static const String verifyAccount = 'VERIFY_ACCOUNT';

  //* AUCTION ROUTES
  static const String auctions = 'AUCTIONS';
  static const String auctionCreate = 'AUCTION_CREATE';
  static const String auctionUpdate = 'AUCTION_UPDATE';

  //* BANNER ROUTES
  static const String banners = 'BANNERS';
  static const String bannerCreate = 'BANNER_CREATE';
  static const String bannerUpdate = 'BANNER_UPDATE';

  //* Product ROUTES
  static const String products = 'PRODUCTS';
  static const String product = 'PRODUCT';
  static const String productCreate = 'PRODUCT_CREATE';
  static const String productUpdate = 'PRODUCT_UPDATE';

  //* BID ROUTES
  static const String bids = 'BIDS';
}
