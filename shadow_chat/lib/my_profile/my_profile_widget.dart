import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../change_password/change_password_widget.dart';
import '../edit_profile/edit_profile_widget.dart';
import '../themes/theme.dart';
import '../themes/util.dart';
import '../themes/widgets.dart';
import '../login/login_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyProfileWidget extends StatefulWidget {
  const MyProfileWidget({Key key}) : super(key: key);

  @override
  _MyProfileWidgetState createState() => _MyProfileWidgetState();
}

class _MyProfileWidgetState extends State<MyProfileWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UsersRecord>(
      stream: UsersRecord.getDocument(currentUserReference),
      builder: (context, snapshot) {
        // Loading widget
        if (!snapshot.hasData) {
          return Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: SpinKitRing(
                color: AppTheme.of(context).secondaryColor,
                size: 50,
              ),
            ),
          );
        }
        final myProfileUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          backgroundColor: AppTheme.of(context).primaryBackground,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Container(
                          width: 80,
                          height: 80,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CachedNetworkImage(
                            imageUrl: valueOrDefault<String>(
                              myProfileUsersRecord.photoUrl,
                              'https://cdn.discordapp.com/attachments/889953520718073907/990100461132582942/profile-icon-9.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                          child: Text(
                            myProfileUsersRecord.displayName,
                            style: AppTheme.of(context).title3,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                          child: Text(
                            myProfileUsersRecord.userRole,
                            style: AppTheme.of(context).bodyText1,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                      child: Text(
                        myProfileUsersRecord.email,
                        style: AppTheme.of(context).bodyText1,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(24, 16, 0, 16),
                          child: Text(
                            'Account Settings',
                            style:
                                AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Mukta',
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context)
                                  .primaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.of(context).dark900,
                                  offset: Offset(0, 1),
                                )
                              ],
                              shape: BoxShape.rectangle,
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: EditProfileWidget(
                                      userEmail: myProfileUsersRecord,
                                      userDisplay: myProfileUsersRecord,
                                      userPhoto: myProfileUsersRecord.reference,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 0, 0),
                                    child: Text(
                                      'Edit Profile',
                                      style: AppTheme.of(context)
                                          .subtitle2,
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(0.9, 0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppTheme.of(context)
                                            .alternate,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppTheme.of(context)
                                  .primaryBackground,
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppTheme.of(context).background,
                                  offset: Offset(0, 1),
                                )
                              ],
                              shape: BoxShape.rectangle,
                            ),
                            child: InkWell(
                              onTap: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: ChangePasswordWidget(
                                      email: myProfileUsersRecord.email,
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 0, 0),
                                    child: Text(
                                      'Change Password',
                                      style: AppTheme.of(context)
                                          .subtitle2,
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: AlignmentDirectional(0.9, 0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: AppTheme.of(context)
                                            .alternate,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppButtonWidget(
                              onPressed: () async {
                                await signOut();
                                await Navigator.pushAndRemoveUntil(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: LoginWidget(),
                                  ),
                                  (r) => false,
                                );
                              },
                              text: 'Log Out',
                              options: AppButtonOptions(
                                width: 90,
                                height: 45,
                                color: Colors.white,
                                textStyle:
                                    AppTheme.of(context).bodyText1,
                                elevation: 1,
                                borderSide: BorderSide(
                                  color:
                                      AppTheme.of(context).primaryText,
                                  width: 1,
                                ),
                                borderRadius: 4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
