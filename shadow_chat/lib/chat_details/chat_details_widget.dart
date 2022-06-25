import '../add_member/add_member_widget.dart';
import '../chat/index.dart';
import '../themes/icon_button.dart';
import '../themes/theme.dart';
import '../themes/util.dart';
import '../main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatDetailsWidget extends StatefulWidget {
  const ChatDetailsWidget({
    Key key,
    this.chatUser,
    this.chatRef,
  }) : super(key: key);

  final UsersRecord chatUser;
  final DocumentReference chatRef;

  @override
  _ChatDetailsWidgetState createState() => _ChatDetailsWidgetState();
}

class _ChatDetailsWidgetState extends State<ChatDetailsWidget> {
  AppChatInfo _chatInfo;
  bool isGroupChat() {
    if (widget.chatUser == null) {
      return true;
    }
    if (widget.chatRef == null) {
      return false;
    }
    return _chatInfo?.isGroupChat ?? false;
  }

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    AppChatManager.instance
        .getChatInfo(
      otherUserRecord: widget.chatUser,
      chatReference: widget.chatRef,
    )
        .listen((info) {
      if (mounted) {
        setState(() => _chatInfo = info);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            await Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                duration: Duration(milliseconds: 200),
                reverseDuration: Duration(milliseconds: 200),
                child: NavBarPage(initialPage: 'chatMain'),
              ),
            );
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: AppTheme.of(context).tertiaryColor,
            size: 24,
          ),
        ),
        title: Text(
          widget.chatUser.displayName,
          style: AppTheme.of(context).subtitle1,
        ),
        actions: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
            child: InkWell(
              onTap: () async {
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                    child: AddMemberWidget(
                      chat: _chatInfo.chatRecord,
                    ),
                  ),
                );
              },
              child: Icon(
                Icons.group_add_sharp,
                color: AppTheme.of(context).tertiaryColor,
                size: 24,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
            child: InkWell(
              onTap: () async {
                scaffoldKey.currentState.openEndDrawer();
              },
              child: Icon(
                Icons.more_vert,
                color: AppTheme.of(context).tertiaryColor,
                size: 24,
              ),
            ),
          ),
        ],
        centerTitle: true,
        elevation: 3,
      ),
      backgroundColor: AppTheme.of(context).primaryBackground,
      endDrawer: Drawer(
        elevation: 16,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppTheme.of(context).dark900,
          ),
          child: StreamBuilder<UsersRecord>(
            stream: UsersRecord.getDocument(widget.chatUser.reference),
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
              final columnUsersRecord = snapshot.data;
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 36, 0, 0),
                        child: AppIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 30,
                          buttonSize: 48,
                          icon: Icon(
                            Icons.close_rounded,
                            color: AppTheme.of(context).alternate,
                            size: 30,
                          ),
                          onPressed: () async {
                            if (scaffoldKey.currentState.isDrawerOpen ||
                                scaffoldKey.currentState.isEndDrawerOpen) {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: AppTheme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(2, 2, 2, 2),
                            child: Container(
                              width: 90,
                              height: 90,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl: valueOrDefault<String>(
                                  columnUsersRecord.photoUrl,
                                  'https://cdn.discordapp.com/attachments/889953520718073907/990100461132582942/profile-icon-9.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        columnUsersRecord.displayName,
                        textAlign: TextAlign.center,
                        style: AppTheme.of(context).title3.override(
                              fontFamily: 'Mukta',
                              color: AppTheme.of(context).tertiaryColor,
                            ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                        child: Text(
                          columnUsersRecord.email,
                          style: AppTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mukta',
                                color:
                                    AppTheme.of(context).primaryColor,
                              ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 24, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Job Title',
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Mukta',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Text(
                                  columnUsersRecord.userRole,
                                  style: AppTheme.of(context).subtitle2,
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
                      Expanded(
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 16, 16, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Employed Since',
                                style: AppTheme.of(context)
                                    .bodyText1
                                    .override(
                                      fontFamily: 'Mukta',
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                child: Text(
                                  dateTimeFormat(
                                      'MMMEd', columnUsersRecord.createdTime),
                                  style: AppTheme.of(context).subtitle2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<AppChatInfo>(
          stream: AppChatManager.instance.getChatInfo(
            otherUserRecord: widget.chatUser,
            chatReference: widget.chatRef,
          ),
          builder: (context, snapshot) => snapshot.hasData
              ? AppChatPage(
                  chatInfo: snapshot.data,
                  allowImages: true,
                  backgroundColor:
                      AppTheme.of(context).primaryBackground,
                  timeDisplaySetting: TimeDisplaySetting.visibleOnTap,
                  currentUserBoxDecoration: BoxDecoration(
                    color: AppTheme.of(context).dark900,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  otherUsersBoxDecoration: BoxDecoration(
                    color: AppTheme.of(context).alternate,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  currentUserTextStyle: GoogleFonts.getFont(
                    'Lexend Deca',
                    color: AppTheme.of(context).tertiaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    fontStyle: FontStyle.normal,
                  ),
                  otherUsersTextStyle: GoogleFonts.getFont(
                    'Lexend Deca',
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  inputHintTextStyle: GoogleFonts.getFont(
                    'DM Sans',
                    color: Color(0xFF95A1AC),
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                  inputTextStyle: GoogleFonts.getFont(
                    'DM Sans',
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                )
              : Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: SpinKitRing(
                      color: AppTheme.of(context).secondaryColor,
                      size: 50,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
