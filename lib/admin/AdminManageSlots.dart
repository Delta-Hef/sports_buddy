import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class Venue {
  final String name;
  final String location;
  final String imageUrl;

  const Venue({
    required this.name,
    required this.location,
    required this.imageUrl,
  });
}

class AdminManageSlotsWidget extends StatefulWidget {
  const AdminManageSlotsWidget({super.key});

  static const String routeName = 'AdminManageSlots';
  static const String routePath = '/adminManageSlots';

  @override
  State<AdminManageSlotsWidget> createState() => _AdminManageSlotsWidgetState();
}

class _AdminManageSlotsWidgetState extends State<AdminManageSlotsWidget> {
  final List<String> standardSlots = [
    '6:00 PM - 7:30 PM',
    '7:00 PM - 8:30 PM',
    '8:30 PM - 10:00 PM',
  ];

  final DateTime today = DateTime.now();

  final List<Venue> venues = const [
    Venue(
      name: 'Champions Stadium',
      location: 'Downtown, City Center',
      imageUrl: 'assets/images/download_(3).jpg',
    ),
    Venue(
      name: 'Indoor Arena',
      location: 'Westside Mall, 3rd Floor',
      imageUrl: 'assets/images/download_(7).jpg',
    ),
    Venue(
      name: 'Community Field',
      location: 'Parkside, East District',
      imageUrl: 'assets/images/download_(5).jpg',
    ),
  ];

  Map<String, String> selectedSports = {};

  Future<Map<String, dynamic>> _fetchAvailability(String venueName, String dateKey, String sport) async {
    final docId = '$sport-$venueName-$dateKey';
    final doc = await FirebaseFirestore.instance.collection('venue_slots').doc(docId).get();
    return doc.data() ?? {};
  }

  Future<void> _toggleSlot(String venueName, String dateKey, String slot, bool currentValue, String sport) async {
    final docId = '$sport-$venueName-$dateKey';
    await FirebaseFirestore.instance.collection('venue_slots').doc(docId).set(
      {slot: !currentValue},
      SetOptions(merge: true),
    );
    setState(() {});
  }

  void _changeSport(String venueName, String sport) {
    setState(() {
      selectedSports[venueName] = sport;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Slot Availability'),
        backgroundColor: const Color(0xFFFF6B3D),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (context.mounted) {
                context.goNamed('login');
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];
          final selectedSport = selectedSports[venue.name] ?? 'football';

          return ExpansionTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${venue.name} • ${venue.location}'),
                const SizedBox(height: 4),
                Row(
                  children: [
                    ChoiceChip(
                      label: const Text('Football'),
                      selected: selectedSport == 'football',
                      onSelected: (_) => _changeSport(venue.name, 'football'),
                      selectedColor: Colors.orange.shade200,
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Tennis'),
                      selected: selectedSport == 'tennis',
                      onSelected: (_) => _changeSport(venue.name, 'tennis'),
                      selectedColor: Colors.orange.shade200,
                    ),
                  ],
                ),
              ],
            ),
            children: List.generate(7, (dayOffset) {
              final date = today.add(Duration(days: dayOffset));
              final dateKey = DateFormat('yyyy-MM-dd').format(date);
              final dateLabel = DateFormat('EEE, MMM d').format(date);

              return FutureBuilder<Map<String, dynamic>>(
                future: _fetchAvailability(venue.name, dateKey, selectedSport),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Padding(
                      padding: EdgeInsets.all(8),
                      child: LinearProgressIndicator(),
                    );
                  }

                  final availability = snapshot.data!;
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dateLabel, style: const TextStyle(fontWeight: FontWeight.bold)),
                          ...standardSlots.map((slot) {
                            final isAvailable = !(availability[slot] == false);
                            return SwitchListTile(
                              value: isAvailable,
                              title: Text(slot),
                              subtitle: Text(isAvailable ? 'Available' : 'Unavailable'),
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.red,
                              onChanged: (_) => _toggleSlot(venue.name, dateKey, slot, isAvailable, selectedSport),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          );
        },
      ),
    );
  }
}
