class Cart {
  final String productPhoto;
  final String productTitle;
  final String productPrice;
  final String delivery;
  Cart(
      {required this.productPhoto,
      required this.productTitle,
      required this.productPrice,
      required this.delivery});
      // this convert it to an object
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
      productPhoto: json['productPhoto'],
      productTitle: json['productTitle'],
      productPrice: json['productPrice'],
      delivery: json['delivery']);
  Map<String, dynamic> toJson() {
    return {
      'productPhoto': productPhoto,
      'productTitle': productTitle,
      'productPrice': productPrice,
      'delivery': delivery
    };
  }
}


// {
//   "status": "OK",
//   "request_id": "572867bb-aeb0-4086-a069-94a9cfc588f7",
//   "data": {
//     "total_products": 963235,
//     "country": "US",
//     "domain": "www.amazon.com",
//     "products": [
//       {
//         "asin": "B0D5FZGY8W",
//         "product_title": "URO Vaginal Probiotics for Women pH Balance with Prebiotics & Lactobacillus Probiotic Blend - Women's Vaginal Health Supplement - Promote Healthy Vaginal Odor & Vaginal Flora, 60 Count (Pack of 1)",
//         "product_price": "$28.79",
//         "unit_price": "$0.48",
//         "unit_count": 60,
//         "product_original_price": "$31.99",
//         "currency": "USD",
//         "product_star_rating": "4.2",
//         "product_num_ratings": 17,
//         "product_url": "https://www.amazon.com/dp/B0D5FZGY8W",
//         "product_photo": "https://m.media-amazon.com/images/I/51gWW6a+5uL._AC_SX444_SY639_QL65_.jpg",
//         "product_num_offers": 1,
//         "product_minimum_offer_price": "$28.79",
//         "is_best_seller": true,
//         "is_amazon_choice": false,
//         "is_prime": true,
//         "climate_pledge_friendly": true,
//         "sales_volume": "30K+ bought in past month",
//         "delivery": "FREE delivery Wed, Jun 12 on $35 of items shipped by AmazonOr fastest delivery Tomorrow, Jun 7"
//       },