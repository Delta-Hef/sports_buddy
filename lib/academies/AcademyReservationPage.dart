import 'package:flutter/material.dart';

class AcademyReservationPage extends StatelessWidget {
  final String academyId;
  final Map<String, dynamic> data;

  const AcademyReservationPage({
    super.key,
    required this.academyId,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reserve at ${data['name']}'), backgroundColor: Colors.red,),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(data['imageUrl'], height: 200, width: double.infinity, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text('Location: ${data['location']}', style: const TextStyle(fontSize: 16)),
            Text('Rating: ${data['rating']}', style: const TextStyle(fontSize: 16)),
            Text('Price:${data['price']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 24),
            const Text('Available Times (admin will add later)', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Reserved! (Booking system coming soon)')),
                );
              },
              child: const Text('Reserve Now'),
            ),
          ],
        ),
      ),
    );
  }
}
