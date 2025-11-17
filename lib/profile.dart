
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "سوزان";
  File? profileImage;
  final adminEmail = "admin@example.com";

  Future<void> _changeProfileImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        profileImage = File(pickedFile.path);
      });
    }
  }

  void _changeUsername() {
    final controller = TextEditingController(text: username);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("تغيير الاسم"),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "ادخل الاسم الجديد"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("إلغاء")),
          TextButton(
            onPressed: () {
              setState(() {
                username = controller.text;
              });
              Navigator.pop(context);
            },
            child: const Text("حفظ"),
          ),
        ],
      ),
    );
  }

  // فتح إعدادات التطبيق للإشعارات
  Future<void> _openAppSettings() async {
    bool opened = await openAppSettings();
    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تعذر فتح إعدادات التطبيق")),
      );
    }
  }

  // إرسال بريد للفيدباك
  Future<void> _sendFeedback() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: adminEmail,
      queryParameters: {'subject': 'Feedback من التطبيق'},
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("لا يمكن فتح البريد الإلكتروني")),
      );
    }
  }


  void _openPrivacyPage() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => const PrivacyPage()));
  }


  void _shareApp() {
    Share.share('جرب هذا التطبيق الرائع: [ضع رابط التطبيق هنا]');
  }

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
          height: 260,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.grey, size: 32),
                title: const Text("الإشعارات", style: TextStyle(fontSize: 18)),
                onTap: _openAppSettings,
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip, color: Colors.grey, size: 32),
                title: const Text("الخصوصية", style: TextStyle(fontSize: 18)),
                onTap: _openPrivacyPage,
              ),
              ListTile(
                leading: const Icon(Icons.feedback_outlined, color: Colors.grey, size: 32),
                title: const Text("فيدباك", style: TextStyle(fontSize: 18)),
                onTap: _sendFeedback,
              ),
              ListTile(
                leading: const Icon(Icons.share, color: Colors.grey, size: 32),
                title: const Text("أخبر أصدقائك", style: TextStyle(fontSize: 18)),
                onTap: _shareApp,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String selectedSection = "بوستاتي";

  final List<Map<String, dynamic>> posts = [
    {"title": "منشور 1", "content": "هذا نص المنشور الأول.", "likes": 5, "image": "images/bas.jpeg"},
    {"title": "منشور 2", "content": "هذا نص المنشور الثاني.", "likes": 8, "image": "images/bas.jpeg"},
    {"title": "منشور 3", "content": "هذا نص المنشور الثالث.", "likes": 3, "image": "images/bas.jpeg"},
  ];

  final List<Map<String, dynamic>> marketPosts = [
    {"title": "منتج 1", "price": "10 \$", "image": "images/bas.jpeg"},
    {"title": "منتج 2", "price": "15 \$", "image": "images/bas.jpeg"},
  ];

 /* void _showPostDetail(Map<String, dynamic> post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PostDetailPage(post: post, username: username)),
    );
  }*/

  Widget _buildPostThumbnail(Map<String, dynamic> post) {
    return GestureDetector(
      //onTap: () => _showPostDetail(post),
      child: Container(
        width: 120,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage(post['image']),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTab(String title, String section) {
    bool isSelected = selectedSection == section;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedSection = section;
          });
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.03),
            border: Border(
              top: BorderSide(
                color: isSelected ? Colors.green[700]! : Colors.transparent,
                width: 3,
              ),
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.green[700] : Colors.black.withOpacity(0.6),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> currentPosts = selectedSection == "بوستاتي" ? posts : marketPosts;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: Stack(
          children: [
            Positioned(
              top: 50,
              right: 10,
              child: IconButton(
                icon: const Icon(Icons.settings, color: Colors.green, size: 32),
                onPressed: _showSettings,
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 110),
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _changeProfileImage,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: profileImage != null ? FileImage(profileImage!) : null,
                          child: profileImage == null ? const Icon(Icons.camera_alt, size: 40) : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: _changeUsername,
                        child: Text(
                          username,
                          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
                Row(
                  children: [
                    _buildSectionTab("بوستاتي", "بوستاتي"),
                    _buildSectionTab("الماركت", "الماركت"),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    children: currentPosts.map((post) => _buildPostThumbnail(post)).toList(),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/*class PostDetailPage extends StatelessWidget {
  final Map<String, dynamic> post;
  final String username;

  const PostDetailPage({super.key, required this.post, required this.username});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: Text(post['title']), backgroundColor: const Color(0xFF4B8A75)),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("الاسم: $username", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: AssetImage(post['image']),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(post['content'], style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.thumb_up, color: Colors.grey[700]),
                  const SizedBox(width: 5),
                  Text(post['likes'].toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}*/

class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("سياسة الخصوصية"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "نحن نحترم خصوصيتك ولا نقوم بجمع أي بيانات شخصية بدون إذنك. "
                "المعلومات تستخدم فقط لتحسين تجربة المستخدم داخل التطبيق.",
            style: TextStyle(fontSize: 16, height: 1.6),
          ),
        ),
      ),
    );
  }
}
