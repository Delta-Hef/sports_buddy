import 'package:cloud_firestore/cloud_firestore.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import '/auth/base_auth_user_provider.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});
  static String routeName = 'profile';
  static String routePath = '/profile';

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  Map<String, dynamic>? userData;
  String? photoUrl;
  bool isEditing = false;
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final sportController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (currentUser == null) return;
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
    if (doc.exists) {
      userData = doc.data();
      photoUrl = userData?['photoUrl'];
      nameController.text = userData?['fullName'] ?? '';
      ageController.text = userData?['age'] ?? '';
      sportController.text = userData?['favoriteSport'] ?? '';
      descController.text = userData?['description'] ?? '';
      setState(() {});
    }
  }

  Future<void> saveProfile() async {
    if (currentUser == null || userData == null) return;
    final updates = <String, dynamic>{};
    // only update if changed
    if (nameController.text.trim().isNotEmpty &&
        nameController.text != userData!['fullName']) {
      updates['fullName'] = nameController.text;
    }
    if (ageController.text.trim().isNotEmpty &&
        ageController.text != userData!['age']) {
      updates['age'] = ageController.text;
    }
    if (sportController.text.trim().isNotEmpty &&
        sportController.text != userData!['favoriteSport']) {
      updates['favoriteSport'] = sportController.text;
    }
    if (descController.text.trim().isNotEmpty &&
        descController.text != userData!['description']) {
      updates['description'] = descController.text;
    }
    if (photoUrl != null && photoUrl != userData!['photoUrl']) {
      updates['photoUrl'] = photoUrl;
    }
    if (updates.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update(updates);
    }
    setState(() => isEditing = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEAE4E2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAE1E1),
        elevation: 0,
        leading: Icon(Icons.sports_soccer, color: Colors.black,),
        actions: [
          TextButton(
            onPressed: () => isEditing ? saveProfile() : setState(() => isEditing = true),
            child: Text(isEditing ? 'Save' : 'Edit'),
            style: TextButton.styleFrom(
              foregroundColor: FlutterFlowTheme.of(context).primary,
            ),
          ),
        ],
      ),
      body: userData == null
          ? const Center(child: CircularProgressIndicator())
          : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: photoUrl != null && photoUrl!.isNotEmpty
                        ? NetworkImage(photoUrl!)
                        : AssetImage('assets/images/LogoSportBuddyNewFinal.png') as ImageProvider,
                  ),

                ),
              ),
              const SizedBox(height: 16),
              if (isEditing) ...[
                _buildField('Full Name', nameController),
                _buildField('Age', ageController, keyboard: TextInputType.number),
                _buildField('Favorite Sport', sportController),
                _buildField('Description', descController, maxLines: 3),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: saveProfile, child: const Text('Save Changes')),
              ] else ...[
                Text(userData?['fullName'] ?? '', style: FlutterFlowTheme.of(context).displaySmall),
                const SizedBox(height: 4),
                Text(userData?['email'] ?? '', style: FlutterFlowTheme.of(context).labelLarge),
                const SizedBox(height: 12),
                _infoRow('Age', userData?['age'] ?? ''),
                _infoRow('Favorite Sport', userData?['favoriteSport'] ?? ''),
                _infoRow('Description', userData?['description'] ?? ''),
                const Divider(height: 32),
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  _statBox(context, 'Matches', '0'),
                  _statBox(context, 'Rate', 'N/A'),
                  _statBox(context, 'EPD', '0'),
                ]),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController c, {TextInputType keyboard = TextInputType.text, int maxLines = 1}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: TextField(
          controller: c,
          keyboardType: keyboard,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      );

  Widget _statBox(BuildContext context, String label, String value) => Column(
    children: [
      Text(value, style: FlutterFlowTheme.of(context).headlineMedium),
      const SizedBox(height: 8),
      Text(label, style: FlutterFlowTheme.of(context).labelMedium),
    ],
  );

  Widget _infoRow(String title, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(children: [
      Text('$title: ', style: FlutterFlowTheme.of(context).bodyLarge),
      Expanded(child: Text(value, style: FlutterFlowTheme.of(context).bodyMedium)),
    ]),
  );
  }