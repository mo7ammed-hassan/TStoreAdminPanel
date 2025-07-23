enum ProductType { single, variable }

enum TextSizes { small, medium, large }

enum OrderStatus { processing, shipped, delivered, pending, cancelled }

enum PaymentMethods {
  paypal,
  googlePay,
  applePay,
  visa,
  masterCard,
  creditCard,
  paystack,
  razorPay,
  paytm,
}

enum MediaCategory { folders, banners, brands, categories, products, users }

enum ImageType { network, memory, file, asset }

enum AppRole { admin, user }

enum ProductVisibility { pubblished, hidden }

enum SidebarRoutes {
  dashboard,
  products,
  orders,
  orderDetails,
  media,
  settings,
  profile,
  categories,
  brands,
  customers,
  customerDetails,
  banners,
  logout,
  createCategory,
  editCategory,
  createBrand,
  editBrand,
  createBanner,
  editBanner,
  createProduct,
  editProduct
}
