import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../models/venue.dart';
import '../create_tennis_room_details/create_tennis_room_details_widget.dart';
import 'create_tennis_model.dart';


class CreateTennisWidget extends StatefulWidget {
  const CreateTennisWidget({super.key});

  static String routeName = 'CreateTennis';
  static String routePath = '/createTennis';

  @override
  State<CreateTennisWidget> createState() => _CreateTennisWidgetState();
}

class _CreateTennisWidgetState extends State<CreateTennisWidget> {
  late CreateTennisModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

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

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateTennisModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
            'Create Tennis Match',
            style: FlutterFlowTheme.of(context).headlineLarge.override(
              font: GoogleFonts.interTight(
                fontWeight: FontWeight.bold,
                fontStyle:
                FlutterFlowTheme.of(context).headlineLarge.fontStyle,
              ),
              letterSpacing: 0.0,
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
                        builder: (context) =>
                            CreateTennisRoomDetailsWidget(venue: venue),
                      ),
                    );
                  },
                  child: Container(
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                venue.location,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
