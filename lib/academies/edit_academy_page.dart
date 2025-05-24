import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditAcademyPage extends StatefulWidget {
  final String academyId;

  const EditAcademyPage({super.key, required this.academyId});

  @override
  State<EditAcademyPage> createState() => _EditAcademyPageState();
}

class _EditAcademyPageState extends State<EditAcademyPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final locationController = TextEditingController();
  final ratingController = TextEditingController();
  final imageUrlController = TextEditingController();
  String selectedSport = 'Football';

  final List<String> sportOptions = [
    'Football', 'Tennis', 'Swimming', 'Martial Arts', 'Basketball', 'Gymnastics'
  ];

  @override
  void initState() {
    super.initState();
    _loadAcademyData();
  }

  Future<void> _loadAcademyData() async {
    final doc = await FirebaseFirestore.instance
        .collection('academies')
        .doc(widget.academyId)
        .get();

    if (doc.exists) {
      final data = doc.data()!;
      nameController.text = data['name'] ?? '';
      descriptionController.text = data['description'] ?? '';
      locationController.text = data['location'] ?? '';
      ratingController.text = data['rating']?.toString() ?? '';
      imageUrlController.text = data['imageUrl'] ?? '';
      selectedSport = data['sportType'] ?? 'Football';
      setState(() {});
    }
  }

  Future<void> _updateAcademy() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance
          .collection('academies')
          .doc(widget.academyId)
          .update({
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'location': locationController.text.trim(),
        'rating': double.tryParse(ratingController.text.trim()) ?? 0.0,
        'imageUrl': imageUrlController.text.trim(),
        'sportType': selectedSport,
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Academy updated')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Academy')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
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
                  if (num == null || num < 0 || num > 5) return 'Invalid rating';
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
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _updateAcademy,
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
