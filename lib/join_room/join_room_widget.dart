import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class JoinRoomWidget extends StatefulWidget {
  const JoinRoomWidget({Key? key}) : super(key: key);

  static String routeName = 'JoinRoom';
  static String routePath = '/joinRoom';

  @override
  State<JoinRoomWidget> createState() => _JoinRoomWidgetState();
}

class _JoinRoomWidgetState extends State<JoinRoomWidget> {
  List<DocumentSnapshot> availableRooms = [];

  @override
  void initState() {
    super.initState();
    fetchAvailableRooms();
  }

  Future<void> fetchAvailableRooms() async {
    final query = await FirebaseFirestore.instance
        .collection('rooms') // ✅ Changed to football_rooms
        .where('status', isEqualTo: 'pending')
        .get();

    final filtered = query.docs.where((doc) {
      final players = List<String>.from(doc['players'] ?? []);
      final maxPlayers = doc['maxPlayers'] ?? 0;
      return players.length < maxPlayers;
    }).toList();

    setState(() => availableRooms = filtered);
  }

  Future<void> joinRoom(DocumentSnapshot roomDoc) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final players = List<String>.from(roomDoc['players']);
    if (players.contains(user.uid)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You already joined this room.")),
      );
      return;
    }

    players.add(user.uid);
    await FirebaseFirestore.instance
        .collection('rooms') // ✅ Changed to football_rooms
        .doc(roomDoc.id)
        .update({'players': players});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Joined room successfully.")),
    );
    fetchAvailableRooms();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Rooms'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF83B46), Color(0xFFFF8A65)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF2F2F2),
      body: ListView.builder(
        itemCount: availableRooms.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final room = availableRooms[index];
          final players = List<String>.from(room['players']);

          return AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeOut,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
              border: Border.all(color: Color(0xFFF83B46).withOpacity(0.2)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.sports_soccer, color: Color(0xFFF83B46)),
                      SizedBox(width: 8),
                      Text(
                        room['venueName'],
                        style: theme.headlineSmall.override(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 18, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text("Location: ${room['venueLocation']}"),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.group, size: 18, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text("Players: ${players.length}/${room['maxPlayers']}"),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 18, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text("Time: ${room['timeRange']}"),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FFButtonWidget(
                      onPressed: () => joinRoom(room),
                      text: 'Join Room',
                      options: FFButtonOptions(
                        width: 140,
                        height: 44,
                        color: const Color(0xFFF83B46),
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        elevation: 6,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}
