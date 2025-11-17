import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class PlantDesign extends StatefulWidget {
  const PlantDesign({super.key});

  @override
  State<PlantDesign> createState() => _PlantDesignState();
}

class _PlantDesignState extends State<PlantDesign> {
  int currentIndex = 0;

  final List<String> images = [
    "assets/images/a.jpeg",
    "assets/images/b.jpeg",
    "assets/images/c.jpeg",
  ];

 final Map<String, dynamic> plant = {
  "name": "النعناع",
  "difficulty": "متوسط",
  "water": "كل 5 أيام ",
  "light": "إشعاع قوي إلى متوسط",
  "temperature": "22–30°C",
  "careSections": {
    "معلومات النبتة":
        "النعناع نبات عطري شهير بأوراقه الخضراء العطرية ويستخدم في الطهي والمشروبات والعلاجات العشبية. ينمو بسرعة ويحتاج إلى عناية معتدلة ليبقى صحيًا ونضرًا.",
    "الزراعة":
        "يمكن زراعة النعناع من البذور أو العقل (قصاصات من النبات الأم). يفضل الزراعة في أصص أو في التربة مباشرة مع تباعد مناسب بين النباتات. ينمو النعناع بسرعة وينتشر، لذا ضع له مساحة كافية.",
    "الضوء":
        "يحتاج إلى ضوء قوي إلى متوسط. يمكن وضعه بالقرب من نافذة مشمسة أو في مكان يتلقى ضوء النهار المباشر لبضع ساعات. يمكن أن يتحمل الظل الجزئي، لكنه سينمو بشكل أبطأ.",
    "المياه":
        "يحب التربة الرطبة ولكن لا يتحمل التشبع بالمياه. اسقِه بانتظام بحيث تظل التربة رطبة، مع تقليل الري في فصل الشتاء.",
    "التربة":
        "يفضل تربة جيدة التصريف وغنية بالمواد العضوية مثل السماد العضوي أو الكمبوست. يمكن إضافة الرمل أو البيرلايت لتحسين تصريف التربة.",
    "الحرارة":
        "ينمو النعناع بشكل أفضل في درجات حرارة بين 22–30°C مع رطوبة معتدلة. يمكنه التحمل المؤقت لدرجات الحرارة المنخفضة، لكنه لا يحب الصقيع.",
    "التقليم والحصاد":
        "يمكن تقليم النعناع بانتظام لتحفيز نمو أوراق جديدة ومنع النبات من التمدد الزائد. اجمع الأوراق عند الحاجة، ويفضل قبل تفتح الأزهار للحصول على أفضل نكهة."
  }
};


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 248, 253, 255),
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 5,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Stack(
                children: [

              CarouselSlider(
              items: images.map((url) {
                return ClipRRect(
                  borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60)),
                  child: Image.asset(
                    url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                );
              }).toList(),
             
              options: CarouselOptions(
                height: screenHeight * .35,
                autoPlay: false,
                viewportFraction: 1.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              ),
              
              
              Positioned(
              bottom: 10,
              right: 0,
              left: 0,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              images.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () { 
              
                 setState(() {
                  currentIndex = entry.key;
                });},
              
                child: Container(
                  width: currentIndex == entry.key ? 20.0 : 10.0,
                  height: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: currentIndex == entry.key ? const Color.fromARGB(255, 47, 20, 86) : const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              );
                        }).toList(),
                      ),
              ),
                        
                ],
            ),



            // contant 
            const SizedBox(height: 12),
            Text(
              plant['name'],style: const TextStyle(
                    fontSize: 35, 
                    fontWeight: FontWeight.bold,
                     color:Color.fromARGB(255, 0, 0, 0), )),
            
            
            Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(25),
            
              boxShadow: [
                BoxShadow(
                  color: Colors.pink.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: Color.fromARGB(255, 243, 230, 50),
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  'مستوى العناية: ${plant['difficulty']}',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton.icon(
          onPressed: () {
            ////////////
          },
          icon: const Icon(
            Icons.add_circle_outline,
            color: Color.fromARGB(255, 36, 200, 21),
            size: 26,
          ),
          label: const Text(
            'أضف إلى حديقتي',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            shadowColor: const Color.fromARGB(255, 219, 116, 150).withOpacity(0.4),
            
          ),
        ),



 
            const SizedBox(height: 16),
            Padding(
            padding: const EdgeInsets.only(left: 12 , right: 15),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Expanded(
            child: infoCard(
              Icons.water_drop_rounded,
              'المياه',
              plant['water'],
              const Color.fromARGB(255, 105, 159, 214),
              const Color.fromARGB(255, 13, 140, 237),
            ),
            ),
            const SizedBox(width: 12),
            Expanded(
            child: infoCard(
              Icons.wb_sunny_rounded,
              'الضوء',
              plant['light'],
              const Color.fromARGB(255, 255, 217, 81),
              const Color.fromARGB(255, 228, 174, 10),
            ),
            ),
            const SizedBox(width: 12),
            Expanded(
            child: infoCard(
              Icons.thermostat_rounded,
              'الحرارة',
              plant['temperature'],
              const Color(0xFFFF7675),
              const Color.fromARGB(255, 218, 12, 12),
            ),
            ),
            ],
            ),
            ),

            const SizedBox(height: 20),
            ///////////////////////////////////
            Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              " محتوى تعليمي",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 64, 38, 80),
              ),
            ),
            const SizedBox(height: 10),
        
            SizedBox(
              height: 190,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [


                ]
              ),
            ),
          ],
        ),


            ///////////////////////////////////
            ///
             const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  expandableCard(
                    title: "معلومات النبتة",content: plant['careSections']["معلومات النبتة"],
                    accentColor: const Color.fromARGB(255, 15, 98, 181),
                    icon: Icons.info_outline, 
                  ),
                  expandableCard(
                    title: "الزراعة",content: plant['careSections']["الزراعة"],
                    accentColor: const Color.fromARGB(255, 94, 236, 78),
                    icon: Icons.grass, 
                  ),
                  expandableCard(
                    title: "الضوء",content: plant['careSections']["الضوء"],
                    accentColor: const Color.fromARGB(255, 228, 230, 90),
                    icon: Icons.wb_sunny_rounded,
                  ),
                  expandableCard(
                    title: "المياه",
                    content: plant['careSections']["المياه"],
                    accentColor: const Color.fromARGB(255, 74, 165, 255),
                    icon: Icons.water_drop_rounded,
                  ),
                  expandableCard(
                    title: "التربة",
                    content: plant['careSections']["التربة"],
                    accentColor: const Color.fromARGB(255, 128, 84, 13),
                    icon: Icons.terrain,
                  ),
                  expandableCard(
                    title: "الحرارة",
                    content: plant['careSections']["الحرارة"],
                    accentColor: const Color(0xFFFF7675),
                    icon: Icons.thermostat_rounded,
                  ),
                  expandableCard(
                    title: "التقليم والحصاد",
                    content: plant['careSections']["التقليم والحصاد"],
                    accentColor: const Color(0xFF9B59B6),
                    icon: Icons.content_cut,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  
  Widget infoCard(
    IconData icon,
    String label,
    String value,
    Color bgColor,
    Color iconColor,
  ) {
    return Container(
      width: 300,
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(

         gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
                bgColor.withOpacity(0.22),
                iconColor.withOpacity(0.3),
                bgColor.withOpacity(0.22),
            ],
          ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
         /* BoxShadow(
            color: bgColor.withOpacity(0.3),
            blurRadius: 7,
            offset: const Offset(0, 2),
          ),*/
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: bgColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 27,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color.fromARGB(255, 88, 27, 94),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 0, 0, 0),
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }


Widget expandableCard({
  required String title,
  required String content,
  Color? accentColor,
  IconData? icon, // new
}) {
  accentColor ??= const Color(0xFFB253B7);

  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: accentColor.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ExpansionTile(
        leading: icon != null
            ? Container(
                padding: const EdgeInsets.all(6),
                
                child: Icon(
                  icon,
                  color: accentColor,
                  size: 30,
                ),
              )
            : null,
        tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        children: [
          Text(
            content,
            style: const TextStyle(fontSize: 15, height: 1.8, color: Colors.black87),
          ),
        ],
      ),
    ),
  );
}
  



}
