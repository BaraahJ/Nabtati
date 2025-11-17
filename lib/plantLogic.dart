class Plant {
  final String id;
  final String name;
  final String scientificName;
  final String description;
  final List<String> images;
  final String difficulty;
  final String water;
  final String light;
  final String temperature;
  final String petFriendly;
  final Map<String, String> careSections;

  Plant({
    required this.id,
    required this.name,
    required this.scientificName,
    required this.description,
    required this.images,
    required this.difficulty,
    required this.water,
    required this.light,
    required this.temperature,
    required this.petFriendly,
    required this.careSections,
  });

  factory Plant.fromMap(Map<String, dynamic> data, String documentId) {
    return Plant(
      id: documentId,
      name: data['name'] ?? '',
      scientificName: data['scientificName'] ?? '',
      description: data['description'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      difficulty: data['difficulty'] ?? '',
      water: data['water'] ?? '',
      light: data['light'] ?? '',
      temperature: data['temperature'] ?? '',
      petFriendly: data['petFriendly'] ?? '',
      careSections: Map<String, String>.from(data['careSections'] ?? {}),
    );
  }
}
