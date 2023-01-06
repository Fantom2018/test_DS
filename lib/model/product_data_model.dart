class ProductDataModel {
  int? id;
  String? name;
  String? category;
  String? imageUrl;
  String? oldPrice;
  String? price;
  String? residue;

  ProductDataModel(
      {this.id,
        this.name,
        this.category,
        this.imageUrl,
        this.oldPrice,
        this.price,
        this.residue
      });

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    imageUrl = json['imageUrl'];
    oldPrice = json['oldPrice'];
    price = json['price'];
    residue = json['residue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category'] = this.category;
    data['imageUrl'] = this.imageUrl;
    data['oldPrice'] = this.oldPrice;
    data['price'] = this.price;
    data['residue'] = this.residue;
    return data;
  }
}
