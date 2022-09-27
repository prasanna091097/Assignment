class Product {
  String? p_name;
  int? p_id;
  String? imageURL;
  int? p_cost;
  int? p_availability;
  String? p_details;
  String? p_category;

  Product({
    required this.p_name,
    required this.p_id,
    required this.imageURL,
    required this.p_availability,
    required this.p_category,
    required this.p_cost,
    required this.p_details,
  });

  Product.fromjson(Map<String, dynamic> json) {
    imageURL = json['imageURL'];
    p_name = json['p_name'];
    p_id = json["p_id"];
    p_availability = json["p_availability"];
    p_category = json["p_category"];
    p_details = json["p_details"];
    p_cost = json["p_cost"];
  }
}
