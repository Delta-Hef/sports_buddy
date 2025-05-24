import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';

class JoinTennisRoomWidget extends StatefulWidget {
  const JoinTennisRoomWidget({Key? key}) : super(key: key);

  static String routeName = 'JoinTennisRoom';
  static String routePath = '/joinTennisRoom';

  @override
  State<JoinTennisRoomWidget> createState() => _JoinTennisRoomWidgetState();
}

class _JoinTennisRoomWidgetState extends State<JoinTennisRoomWidget> {
  List<DocumentSnapshot> availableRooms = [];

  @override
  void initState() {
    super.initState();
    fetchAvailableRooms();
  }

  Future<void> fetchAvailableRooms() async {
    final query = await FirebaseFirestore.instance
        .collection('tennis_rooms') // ← Make sure to change this to football_rooms in the football version
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
        .collection('tennis_rooms') // ← Same, adjust in football version
        .doc(roomDoc.id)
        .update({'players': players});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Joined room successfully.")),
    );
    fetchAvailableRooms();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Rooms'),
        backgroundColor: Color(0xFFF83B46),
        elevation: 0,
      ),
      backgroundColor: theme.primaryBackground,
      body: ListView.builder(
        itemCount: availableRooms.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final room = availableRooms[index];
          final players = List<String>.from(room['players']);

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room['venueName'],
                    style: theme.headlineSmall.override(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text("Location: ${room['venueLocation']}"),
                  Text("Players: ${players.length}/${room['maxPlayers']}"),
                  Text("Time: ${room['timeRange']}"),
                  SizedBox(height: 12),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FFButtonWidget(
                      onPressed: () => joinRoom(room),
                      text: 'Join Room',
                      options: FFButtonOptions(
                        width: 140,
                        height: 44,
                        color: Color(0xFFFB5636),
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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
