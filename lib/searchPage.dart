import 'package:flutter/material.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String searchText = "";
  String selectedType = "الكل";

  final List<String> plantTypes = [
    "الكل",
    "زهور",
    "صبار",
    "أخضر",
    "شجيرات",
    "أشجار",
    "أعشاب",
    "فواكه",
    "نباتات زينة"
  ];

  final List<Map<String, String>> plants = [
    {
      "name": "صبار",
      "type": "صبار",
      "image": "https://upload.wikimedia.org/wikipedia/commons/2/2f/Aloe_vera_1.JPG"
    },
    {
      "name": "ورد",
      "type": "زهور",
      "image": "https://upload.wikimedia.org/wikipedia/commons/4/45/Rose_flower_in_Greece.jpg"
    },
    {
      "name": "فل",
      "type": "أخضر",
      "image": "https://upload.wikimedia.org/wikipedia/commons/4/44/Jasmine_flower.jpg"
    },
    {
      "name": "ليمون",
      "type": "فواكه",
      "image": "https://upload.wikimedia.org/wikipedia/commons/3/32/Lemon.jpg"
    },
    {
      "name": "ورد",
      "type": "زهور",
      "image": "https://upload.wikimedia.org/wikipedia/commons/4/45/Rose_flower_in_Greece.jpg"
    },
    {
      "name": "فل",
      "type": "أخضر",
      "image": "https://upload.wikimedia.org/wikipedia/commons/4/44/Jasmine_flower.jpg"
    },
    {
      "name": "ليمون",
      "type": "فواكه",
      "image": "https://upload.wikimedia.org/wikipedia/commons/3/32/Lemon.jpg"
    },
    {
      "name": "ورد",
      "type": "زهور",
      "image": "https://upload.wikimedia.org/wikipedia/commons/4/45/Rose_flower_in_Greece.jpg"
    },
    {
      "name": "فل",
      "type": "أخضر",
      "image": "https://upload.wikimedia.org/wikipedia/commons/4/44/Jasmine_flower.jpg"
    },
    {
      "name": "ليمون",
      "type": "فواكه",
      "image": "https://upload.wikimedia.org/wikipedia/commons/3/32/Lemon.jpg"
    }
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredPlants = plants.where((plant) {
      String query = searchText.toLowerCase();
      bool matchesText = plant["name"]!.toLowerCase().contains(query) ||
          plant["type"]!.toLowerCase().contains(query) ||
          query.isEmpty;

      bool matchesType =
      selectedType == "الكل" ? true : plant["type"] == selectedType;

      return matchesText && matchesType;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 40),
          // شريط البحث
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              textDirection: TextDirection.rtl,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF4B8A75)),
                  iconSize: 34,
                  onPressed: () {},
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      textAlign: TextAlign.right,
                      decoration: const InputDecoration(
                        hintText: "البحث",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchText = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),
          // فلتر أنواع النباتات
          Container(
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: ListView.builder(
              
              scrollDirection: Axis.horizontal,
              itemCount: plantTypes.length,
              itemBuilder: (context, index) {
                String type = plantTypes[index];
                bool isSelected = selectedType == type;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedType = type;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF4B8A75) : Colors.grey[300],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        type,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 10),
          // شبكة عرض النباتات
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: filteredPlants.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final plant = filteredPlants[index];
                return InkWell(
                  onTap: () {
                   ///////////////
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.network(
                            plant["image"]!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "الاسم: ${plant["name"]!}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "النوع: ${plant["type"]!}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}