import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nabtati/searchPage.dart';


class HomeContent extends StatelessWidget {
  final VoidCallback? onSearchPressed;

  const HomeContent({this.onSearchPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: GreetingWidget(),
        ),
        const PointsCard(totalPoints: 50, earnedPoints: 15),
        const SizedBox(height: 120),
        const Text(
          "نبتتي",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          "جميع نباتاتك جاهزة لهذا اليوم",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black54,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 120),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildBox(
                icon: Icons.bug_report,
                label: "تشخيص الأمراض",
                color: const Color(0xFF9FCF8C),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("تشخيص أمراض النباتات")),
                  );
                },
              ),
              const SizedBox(width: 15),
              buildBox(
                icon: Icons.camera_alt,
                label: "تعرّف على نبتة",
                color: const Color(0xFFA8C88A),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("فتح الكاميرا للتعرف على النبتة")),
                  );
                },
              ),
              const SizedBox(width: 15),
              buildBox(
                icon: Icons.search,
                label: "بحث عن نبتة",
                color: const Color(0xFFB8D8B0),
                onTap: (){
                   Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchPage(),
                              ),
                            );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
// المربعات الثلاثة (تشخيص – تعرّف – بحث)
Widget buildBox({
  required IconData icon,
  required String label,
  required Color color,
  required VoidCallback? onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 115,
      height: 110,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 35),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}
//ويدجت الترحيب 
class GreetingWidget extends StatelessWidget {
  const GreetingWidget({super.key});

  String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 0 && hour < 12) {
      return "صباحك أخضر كأوراق نبتتك 🌿";
    } else {
      return "أتمنى لك مساءً هادئًا، ونماء دائم لنبتتك 🌙";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Align(
        alignment: Alignment.topRight,
        child: Text(
          getGreeting(),
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

// كرت النقاط
class PointsCard extends StatelessWidget {
  final int totalPoints;
  final int earnedPoints;

  const PointsCard({
    super.key,
    required this.totalPoints,
    required this.earnedPoints,
  });

  @override
  Widget build(BuildContext context) {
    double progress = earnedPoints / totalPoints;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 35),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.green.shade200, width: 2),
        ),
        child: Row(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 25,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: progress,
                    child: Container(
                      height: 25,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "$earnedPoints / $totalPoints نقاطك",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
