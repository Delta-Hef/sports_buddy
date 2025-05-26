import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({super.key});

  static String routeName = 'Admin';
  static String routePath = '/admin';

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final ratingController = TextEditingController();
  final imageUrlController = TextEditingController();
  String selectedSport = 'Football';

  final timeController = TextEditingController();
  final priceController = TextEditingController();

  final List<String> sportOptions = [
    'Football',
    'Tennis',
    'Swimming',
    'Martial Arts',
    'Basketball',
    'Gymnastics'
  ];

  String? role;
  String? editingAcademyId;

  @override
  void initState() {
    super.initState();
    _checkAdminAccess();
  }

  Future<void> _checkAdminAccess() async {
    final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
    role = doc.data()?['role'];

    if (role != 'admin' && role != 'superadmin') {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/unauthorized');
      }
    } else {
      setState(() {});
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    ratingController.dispose();
    imageUrlController.dispose();
    timeController.dispose();
    priceController.dispose();
    super.dispose();
  }

  Future<void> _addOrUpdateAcademy() async {
    if (_formKey.currentState!.validate()) {
      final data = {
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'location': locationController.text.trim(),
        'rating': double.tryParse(ratingController.text.trim()) ?? 0.0,
        'imageUrl': imageUrlController.text.trim().isEmpty
            ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmg4woGTDJXXDaZFDz-m6AX5TqUirAVkF-0Q&s'
            : imageUrlController.text.trim(),
        'sportType': selectedSport,
        'createdBy': FirebaseAuth.instance.currentUser?.email,
        'createdAt': FieldValue.serverTimestamp(),
      };

      if (editingAcademyId != null) {
        await FirebaseFirestore.instance
            .collection('academies')
            .doc(editingAcademyId)
            .update(data);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Academy updated successfully')),
        );
      } else {
        final docRef = await FirebaseFirestore.instance.collection('academies').add(data);

        await FirebaseFirestore.instance
            .collection('academies')
            .doc(docRef.id)
            .collection('timeSlots')
            .add({
          'time': timeController.text.trim(),
          'price': double.tryParse(priceController.text.trim()) ?? 0.0,
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Academy and time slot added successfully')),
        );
      }

      setState(() => editingAcademyId = null);
      _clearForm();
    }
  }

  void _clearForm() {
    nameController.clear();
    descriptionController.clear();
    locationController.clear();
    ratingController.clear();
    imageUrlController.clear();
    timeController.clear();
    priceController.clear();
    selectedSport = 'Football';
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      GoRouter.of(context).go('/login');
    }
  }

  Future<void> _confirmDeleteAcademy(String academyId, String? academyName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Academy'),
        content: Text('Are you sure you want to delete "$academyName"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await FirebaseFirestore.instance.collection('academies').doc(academyId).delete();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Deleted "$academyName" successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academy Management'),
        backgroundColor: const Color(0xFFFF6B3D),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: role == null
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: ListView(
            children: [
              if (role == 'superadmin' || role == 'admin') ...[
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Academy Name'),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(labelText: 'Location'),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: ratingController,
                  decoration: const InputDecoration(labelText: 'Rating (0-5)'),
                  keyboardType: TextInputType.number,
                  validator: (val) {
                    final num = double.tryParse(val!);
                    if (num == null || num < 0 || num > 5) return 'Enter valid rating';
                    return null;
                  },
                ),
                TextFormField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedSport,
                  items: sportOptions
                      .map((sport) => DropdownMenuItem(
                    value: sport,
                    child: Text(sport),
                  ))
                      .toList(),
                  onChanged: (val) => setState(() => selectedSport = val!),
                  decoration: const InputDecoration(labelText: 'Sport Type'),
                ),
                const Divider(height: 40),
                const Text('Initial Time Slot & Price'),
                TextFormField(
                  controller: timeController,
                  decoration: const InputDecoration(labelText: 'Time (e.g. 5:00 PM - 6:00 PM)'),
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(labelText: 'Price (EGP)'),
                  keyboardType: TextInputType.number,
                  validator: (val) => val!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _addOrUpdateAcademy,
                  child: Text(editingAcademyId == null ? 'Submit' : 'Update'),
                ),
                const SizedBox(height: 32),
              ],
              const Divider(height: 1),
              const SizedBox(height: 16),
              const Text('Academies',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              StreamBuilder<QuerySnapshot>(
                stream: (role == 'superadmin')
                    ? FirebaseFirestore.instance.collection('academies').snapshots()
                    : FirebaseFirestore.instance
                    .collection('academies')
                    .where('createdBy', isEqualTo: FirebaseAuth.instance.currentUser?.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final docs = snapshot.data!.docs;

                  if (docs.isEmpty) {
                    return const Text('No academies added yet.');
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      final doc = docs[index];
                      final data = doc.data() as Map<String, dynamic>;
                      return ListTile(
                        title: Text(data['name'] ?? 'Unnamed'),
                        subtitle: Text(data['sportType'] ?? ''),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                nameController.text = data['name'] ?? '';
                                descriptionController.text = data['description'] ?? '';
                                locationController.text = data['location'] ?? '';
                                ratingController.text = (data['rating'] ?? '').toString();
                                imageUrlController.text = data['imageUrl'] ?? '';
                                selectedSport = data['sportType'] ?? 'Football';
                                editingAcademyId = doc.id;
                                setState(() {});
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _confirmDeleteAcademy(doc.id, data['name']),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
