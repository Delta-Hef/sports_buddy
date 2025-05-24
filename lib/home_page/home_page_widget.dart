import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'home_page_model.dart';
export 'home_page_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Create a Home Page UI for a Sports App called "Sport Buddy" with a
/// red-accented theme.
///
/// The page should include the following elements:
///
/// Header Section:
///
/// App title: Sport Buddy (centered, bold, white or light gray)
///
/// Subtitle: Enjoy a sport: (just below the title)
///
/// A colorful sports illustration/banner (optional, can show players or
/// action silhouettes)
///
/// Use a background color that complements red (e.g., light gray or soft
/// gradient with red).
///
/// Search Bar:
///
/// Placeholder text: Search Sports or Buddies
///
/// A rounded search button labeled Search beside it or below it
///
/// Styled with red borders or shadows
///
/// Sports Options Grid (2 buttons only):
///
/// Show Football and Tennis only
///
/// Each in a large rounded card or button with:
///
/// Sport icon (⚽ for Football, 🎾 for Tennis)
///
/// Label below the icon (e.g., “Football”, “Tennis”)
///
/// Use red for highlights, borders, or background accents
///
/// Bottom Section with Illustrations:
///
/// Add fun vector-style or cartoon-style images of players (one for football,
/// one for tennis)
///
/// Align them nicely under the sport buttons
///
/// Bottom Navigation Bar:
///
/// 3 tabs:
///
/// Sports (highlighted in red as the selected tab)
///
/// Academies
///
/// Profile
///
/// Use red icons or red text for the selected tab
///
/// Clean, minimal style
///
/// Use red as the primary accent color throughout the screen, combined with
/// clean fonts and a light modern UI style. Keep spacing and responsiveness
/// in mind.
class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  static String routeName = 'Home_Page';
  static String routePath = '/homePage';

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: AlignmentDirectional(1.0, -1.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0.0, 1.0),
                  child: Container(
                    width: double.infinity,
                    height: 150.0,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFFFF3333), Color(0xFFFFEE66)],
                        stops: [0.0, 1.0],
                        begin: AlignmentDirectional(1.0, 1.0),
                        end: AlignmentDirectional(-1.0, -1.0),
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
                      child: Container(
                        width: 1958.3,
                        child: Stack(
                          children: [
                            Align(
                              alignment: AlignmentDirectional(-0.45, 0.44),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.asset(
                                  'assets/images/LogoSportBuddyNewFinal.png',
                                  width: 152.27,
                                  height: 130.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // Align(
                            //   alignment: AlignmentDirectional(0.81, 0.63),
                            //   child: FFButtonWidget(
                            //     onPressed: () async {
                            //       context.pushNamed(LoginWidget.routeName);
                            //     },
                            //     text: 'Login',
                            //     options: FFButtonOptions(
                            //       width: 73.7,
                            //       height: 40.0,
                            //       padding: EdgeInsets.all(8.0),
                            //       iconPadding: EdgeInsetsDirectional.fromSTEB(
                            //           0.0, 0.0, 0.0, 0.0),
                            //       color: Color(0xFFFFD15E),
                            //       textStyle: FlutterFlowTheme.of(context)
                            //           .bodyMedium
                            //           .override(
                            //             font: GoogleFonts.inter(
                            //               fontWeight: FontWeight.w600,
                            //               fontStyle:
                            //                   FlutterFlowTheme.of(context)
                            //                       .bodyMedium
                            //                       .fontStyle,
                            //             ),
                            //             color: Color(0xFF040404),
                            //             letterSpacing: 0.0,
                            //             fontWeight: FontWeight.w600,
                            //             fontStyle: FlutterFlowTheme.of(context)
                            //                 .bodyMedium
                            //                 .fontStyle,
                            //           ),
                            //       elevation: 0.0,
                            //       borderRadius: BorderRadius.circular(20.0),
                            //     ),
                            //   ),
                            // ),
                            // Align(
                            //   alignment: AlignmentDirectional(0.8, -0.43),
                            //   child: FFButtonWidget(
                            //     onPressed: () async {
                            //       context.pushNamed(SignUpWidget.routeName);
                            //     },
                            //     text: 'Sign Up',
                            //     options: FFButtonOptions(
                            //       width: 69.0,
                            //       height: 40.0,
                            //       padding: EdgeInsets.all(8.0),
                            //       iconPadding: EdgeInsetsDirectional.fromSTEB(
                            //           0.0, 0.0, 0.0, 0.0),
                            //       color: Color(0xFFFFD15E),
                            //       textStyle: FlutterFlowTheme.of(context)
                            //           .bodyMedium
                            //           .override(
                            //             font: GoogleFonts.inter(
                            //               fontWeight: FontWeight.w600,
                            //               fontStyle:
                            //                   FlutterFlowTheme.of(context)
                            //                       .bodyMedium
                            //                       .fontStyle,
                            //             ),
                            //             color: Color(0xFF040404),
                            //             letterSpacing: 0.0,
                            //             fontWeight: FontWeight.w600,
                            //             fontStyle: FlutterFlowTheme.of(context)
                            //                 .bodyMedium
                            //                 .fontStyle,
                            //           ),
                            //       elevation: 0.0,
                            //       borderRadius: BorderRadius.circular(20.0),
                            //     ),
                            //   ),
                            // ),
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
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 30.0, 16.0, 0.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 10.0,
                            color: Color(0x15000000),
                            offset: Offset(
                              0.0,
                              4.0,
                            ),
                            spreadRadius: 0.0,
                          )
                        ],
                        gradient: LinearGradient(
                          colors: [Color(0xFFEA8042), Color(0xFFFF3333)],
                          stops: [0.0, 1.0],
                          begin: AlignmentDirectional(0.0, -1.0),
                          end: AlignmentDirectional(0, 1.0),
                        ),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            16.0, 16.0, 16.0, 16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: _model.textController,
                                    focusNode: _model.textFieldFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Search Buddies',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.inter(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: Color(0xFFFCFDFD),
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0xFF221616),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color(0x00000000),
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      suffixIcon: Icon(
                                        Icons.search,
                                      ),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    validator: _model.textControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                FFButtonWidget(
                                  onPressed: () {
                                    print('Button pressed ...');
                                  },
                                  text: 'Search',
                                  options: FFButtonOptions(
                                    height: 48.0,
                                    padding: EdgeInsets.all(8.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: Color(0xFFFF3333),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          font: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    elevation: 2.0,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                              ].divide(SizedBox(width: 12.0)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      child: Text(
                        'Choose a Sport',
                        style: FlutterFlowTheme.of(context).titleLarge.override(
                              font: GoogleFonts.interTight(
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleLarge
                                    .fontStyle,
                              ),
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .fontStyle,
                            ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
                  child: GridView(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 0.9,
                    ),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context
                              .pushNamed(FootballRoomOptionsWidget.routeName);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6.0,
                                color: Color(0x15000000),
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                                spreadRadius: 0.0,
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF3333), Color(0xFFF98B60)],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Color(0xFFF8F4F4),
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GradientText(
                                  '⚽',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .fontStyle,
                                        ),
                                        fontSize: 48.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .fontStyle,
                                      ),
                                  colors: [
                                    Color(0xFFF0F0F6),
                                    Color(0xFFF2510F)
                                  ],
                                  gradientDirection: GradientDirection.ltr,
                                  gradientType: GradientType.linear,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: Text(
                                    'Football',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.interTight(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(TennisRoomOptionsWidget.routeName);
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 6.0,
                                color: Color(0x15000000),
                                offset: Offset(
                                  0.0,
                                  3.0,
                                ),
                                spreadRadius: 0.0,
                              )
                            ],
                            gradient: LinearGradient(
                              colors: [Color(0xFFFF3333), Color(0xFFF99759)],
                              stops: [0.0, 1.0],
                              begin: AlignmentDirectional(0.0, -1.0),
                              end: AlignmentDirectional(0, 1.0),
                            ),
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GradientText(
                                  '🎾',
                                  textAlign: TextAlign.center,
                                  style: FlutterFlowTheme.of(context)
                                      .displaySmall
                                      .override(
                                        font: GoogleFonts.interTight(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .displaySmall
                                                  .fontStyle,
                                        ),
                                        color: Color(0xFF426DA7),
                                        fontSize: 48.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .displaySmall
                                            .fontStyle,
                                      ),
                                  colors: [
                                    Color(0xFFB9B6D0),
                                    Color(0xFFFBB19B)
                                  ],
                                  gradientDirection: GradientDirection.ltr,
                                  gradientType: GradientType.linear,
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 0.0, 0.0),
                                  child: Text(
                                    'Tennis',
                                    textAlign: TextAlign.center,
                                    style: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          font: GoogleFonts.interTight(
                                            fontWeight: FontWeight.w600,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleMedium
                                                    .fontStyle,
                                          ),
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 2.0, 16.0, 4.0),
                    child: Container(
                      width: 300.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: Image.asset(
                            'assets/images/BuddiesColored.png',
                          ).image,
                        ),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
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
