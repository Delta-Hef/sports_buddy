import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../flutter_flow/flutter_flow_icon_button.dart';
import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_util.dart';
import '../models/venue.dart';
import '../create_room_details/create_room_details_widget.dart'; // make sure this page exists and takes Venue

class CreateFootballWidget extends StatefulWidget {
  const CreateFootballWidget({super.key});

  static String routeName = 'CreateFootball';
  static String routePath = '/createFootball';

  @override
  State<CreateFootballWidget> createState() => _CreateFootballWidgetState();
}

class _CreateFootballWidgetState extends State<CreateFootballWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Venue> venues = const [
    Venue(
      name: 'Champions Stadium',
      location: 'Downtown, City Center',
      imageUrl: 'assets/images/download_(2).jpg',
    ),
    Venue(
      name: 'Indoor Arena',
      location: 'Westside Mall, 3rd Floor',
      imageUrl: 'assets/images/download_(6).jpg',
    ),
    Venue(
      name: 'Community Field',
      location: 'Parkside, East District',
      imageUrl: 'assets/images/images_(4).jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Create Match',
            style: FlutterFlowTheme.of(context).headlineLarge.override(
              font: GoogleFonts.interTight(),
              letterSpacing: 0,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: venues.length,
              itemBuilder: (context, index) {
                final venue = venues[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateRoomDetailsWidget(venue: venue),
                      ),
                    );
                  },
                  child: VenueCard(venue: venue),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class VenueCard extends StatelessWidget {
  final Venue venue;

  const VenueCard({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(venue.imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0x80000000), Color(0xCC000000)],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              venue.name,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                Text(venue.location, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
