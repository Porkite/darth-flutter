class Potion {
  final String name;
  final String description;
  final List<String> effects;
  final String img;
  final int price;

  Potion(
      {required this.name,
      required this.description,
      required this.effects,
      required this.img,
      required this.price});

  factory Potion.fromJson(Map<String, dynamic> json) {
    return Potion(
      name: json['name'],
      description: json['description'],
      effects: List<String>.from(json['effects']),
      img: json['img'],
      price: json['price'],
    );
  }
}
