import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  final List<String> sportOptions = [
    'Football',
    'Tennis',
    'Swimming',
    'Martial Arts',
    'Basketball',
    'Gymnastics'
  ];

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    ratingController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _addAcademy() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('academies').add({
        'name': nameController.text.trim(),
        'description': descriptionController.text.trim(),
        'location': locationController.text.trim(),
        'rating': double.tryParse(ratingController.text.trim()) ?? 0.0,
        'imageUrl': imageUrlController.text.trim(),
        'sportType': selectedSport,
        'createdBy': FirebaseAuth.instance.currentUser?.email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Academy added successfully')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Academy')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Academy Name'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: 'Location'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: ratingController,
                decoration: InputDecoration(labelText: 'Rating (0-5)'),
                keyboardType: TextInputType.number,
                validator: (val) {
                  final num = double.tryParse(val!);
                  if (num == null || num < 0 || num > 5) return 'Enter valid rating';
                  return null;
                },
              ),
              TextFormField(
                controller: imageUrlController,
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (val) => val!.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedSport,
                items: sportOptions
                    .map((sport) => DropdownMenuItem(
                  value: sport,
                  child: Text(sport),
                ))
                    .toList(),
                onChanged: (val) => setState(() => selectedSport = val!),
                decoration: InputDecoration(labelText: 'Sport Type'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _addAcademy,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
