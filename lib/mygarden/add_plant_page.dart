import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../colors.dart';
import 'models/plant.dart';
import 'data/plant_data.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({super.key});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  void _savePlant() {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("أدخل اسم النبتة أولاً")));
      return;
    }

    final newPlant = Plant(
      name: _nameController.text.trim(),
      image: 'assets/images/default_plant.jpg',
    );

    PlantData.plants.add(newPlant);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("تمت إضافة النبتة بنجاح")));
    context.pop(); // يرجع للصفحة السابقة
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: const Color(0xFFEFF6EF),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'إضافة نبتة جديدة ',
            style: GoogleFonts.tajawal(
              fontWeight: FontWeight.w700,
              color: const Color(0xFF3E7045),
            ),
          ),
          iconTheme: const IconThemeData(color: Color(0xFF3E7045)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: const Color(0xFFC8E6C9),
                  child: Icon(Icons.local_florist,
                      size: 50, color: const Color(0xFF3E7045)),
                ),
              ),
              const SizedBox(height: 30),

              // اسم النبتة
              TextField(
                controller: _nameController,
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  labelText: 'اسم النبتة',
                  labelStyle: GoogleFonts.tajawal(color: Colors.grey[700]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ملاحظات
              TextField(
                controller: _noteController,
                textAlign: TextAlign.right,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'اضف ملاحظاتك',
                  labelStyle: GoogleFonts.tajawal(color: Colors.grey[700]),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // زر الحفظ
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  onPressed: _savePlant,
                  icon: const Icon(Icons.check, color: Colors.white),
                  label: Text(
                    'حفظ النبتة',
                    style: GoogleFonts.tajawal(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
