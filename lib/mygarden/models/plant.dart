class Plant {
  String name;
  String image;
  String? light;
  String? temperature;
  bool isOutdoor;
  DateTime? lastWateringDate;

  Plant({
    required this.name,
    required this.image,
    this.light,
    this.temperature,
    this.isOutdoor = true,
    this.lastWateringDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'light': light,
      'temperature': temperature,
      'isOutdoor': isOutdoor,
    };
  }

  factory Plant.fromMap(Map<String, dynamic> map) {
    return Plant(
      name: map['name'],
      image: map['image'],
      light: map['light'],
      temperature: map['temperature'],
      isOutdoor: map['isOutdoor'] ?? true,
    );
  }
}
