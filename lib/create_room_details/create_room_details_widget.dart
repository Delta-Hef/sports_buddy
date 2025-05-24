import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import '../models/venue.dart';
import 'create_room_details_model.dart';
export 'create_room_details_model.dart';

class CreateRoomDetailsWidget extends StatefulWidget {
  final Venue venue;

  const CreateRoomDetailsWidget({super.key, required this.venue});

  static String routeName = 'CreateRoomDetails';
  static String routePath = '/createRoomDetails';

  @override
  State<CreateRoomDetailsWidget> createState() => _CreateRoomDetailsWidgetState();
}

class _CreateRoomDetailsWidgetState extends State<CreateRoomDetailsWidget> {
  late CreateRoomDetailsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int playerCount = 4;
  String selectedTime = '';
  DateTime selectedDate = DateTime.now();
  List<String> availableSlots = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateRoomDetailsModel());
    fetchAvailableSlots();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  Future<void> fetchAvailableSlots() async {
    final venueName = widget.venue.name;
    final dateKey = DateFormat('yyyy-MM-dd').format(selectedDate);
    final docId = 'football-${widget.venue.name}-$dateKey';


    final doc = await FirebaseFirestore.instance.collection('venue_slots').doc(docId).get();

    final allSlots = [
      '6:00 PM - 7:30 PM',
      '7:00 PM - 8:30 PM',
      '8:30 PM - 10:00 PM',
    ];

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        availableSlots = allSlots.where((slot) => data[slot] != false).toList();
        selectedTime = availableSlots.isNotEmpty ? availableSlots.first : '';
      });
    } else {
      setState(() {
        availableSlots = allSlots;
        selectedTime = allSlots.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 20.0,
            buttonSize: 40.0,
            icon: Icon(Icons.arrow_back_ios_new, color: FlutterFlowTheme.of(context).primaryText, size: 24.0),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Book Your Slot', style: FlutterFlowTheme.of(context).titleLarge.override(
            font: GoogleFonts.interTight(),
            letterSpacing: 0.0,
            fontWeight: FontWeight.bold,
          )),
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(widget.venue.imageUrl),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0x80000000), Color(0xD0000000)],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.venue.name, style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.interTight(),
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: Colors.white, size: 16.0),
                            SizedBox(width: 8),
                            Text(widget.venue.location, style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.0),

                Text('Select Date', style: FlutterFlowTheme.of(context).titleMedium),
                SizedBox(height: 8.0),
                InkWell(
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 7)),
                    );
                    if (picked != null) {
                      setState(() => selectedDate = picked);
                      await fetchAvailableSlots();
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey[200],
                    ),
                    child: Text(
                      DateFormat('EEE, MMM d').format(selectedDate),
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),

                Text('Select Time Slot', style: FlutterFlowTheme.of(context).titleMedium),
                SizedBox(height: 8.0),
                DropdownButton<String>(
                  value: selectedTime.isNotEmpty ? selectedTime : null,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => selectedTime = value);
                    }
                  },
                  items: availableSlots.map((slot) {
                    return DropdownMenuItem<String>(
                      value: slot,
                      child: Text(slot),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Players: $playerCount', style: FlutterFlowTheme.of(context).titleMedium),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () => setState(() => playerCount = (playerCount - 1).clamp(1, 8)),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle_outline),
                          onPressed: () => setState(() => playerCount = (playerCount + 1).clamp(1, 8)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 24.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total Price', style: FlutterFlowTheme.of(context).titleMedium),
                    Text('\$${playerCount * 15}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFFFC573C))),
                  ],
                ),
                SizedBox(height: 32.0),

                FFButtonWidget(
                  onPressed: () async {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user == null) return;

                    final roomData = {
                      'venueName': widget.venue.name,
                      'venueLocation': widget.venue.location,
                      'date': Timestamp.fromDate(selectedDate),
                      'timeRange': selectedTime,
                      'maxPlayers': playerCount,
                      'pricePerPlayer': 15,
                      'totalPrice': playerCount * 15,
                      'creatorId': user.uid,
                      'players': [user.uid],
                      'status': 'pending',
                      'createdAt': FieldValue.serverTimestamp(),
                    };

                    await FirebaseFirestore.instance.collection('rooms').add(roomData);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Room created successfully!')),
                    );

                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  text: 'Confirm Booking',
                  options: FFButtonOptions(
                    width: double.infinity,
                    height: 50.0,
                    color: Color(0xFFEF4A39),
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      font: GoogleFonts.interTight(),
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}