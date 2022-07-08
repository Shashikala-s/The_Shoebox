class ShoesModel {
  String id, SKU, name, brandName, mainImage, stockStatus, colour, description;
  PriceModel price;
  int qty;
  List<String> sizes;

  ShoesModel({
    required this.id,
    required this.SKU,
    required this.qty,
    required this.name,
    required this.brandName,
    required this.mainImage,
    required this.price,
    required this.sizes,
    required this.stockStatus,
    required this.colour,
    required this.description,
  });

  factory ShoesModel.fromJson(Map<String, dynamic> json) {
    return ShoesModel(
      qty: 0,
      id: json['id'] ?? 'N/A',
      SKU: json['SKU'] ?? 'N/A',
      name: json['name'] ?? 'N/A',
      brandName: json['brandName'] ?? 'N/A',
      mainImage: json['mainImage'] ?? 'N/A',
      price: PriceModel.fromJson(json['price']),
      sizes: List<String>.from(json['sizes']),
      stockStatus: json['stockStatus'] ?? 'N/A',
      colour: json['colour'] ?? 'N/A',
      description: json['description'] ?? 'N/A',
    );
  }
}

class PriceModel {
  String amount, currency;
  double total;

  PriceModel(
      {required this.amount, required this.currency, required this.total});

  factory PriceModel.fromJson(Map<String, dynamic> json) {
    return PriceModel(
      amount: json['amount'] ?? 'N/A',
      currency: json['currency'] ?? 'N/A',
      total: double.parse(json['amount'] ?? 'N/A'),
    );
  }
}
