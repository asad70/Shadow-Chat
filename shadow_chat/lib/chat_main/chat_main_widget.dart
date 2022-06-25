
import '../chat_details/chat_details_widget.dart';
import '../chat/index.dart';
import '../themes/icon_button.dart';
import '../themes/theme.dart';
import '../themes/util.dart';
import '../group_chat/group_chat_widget.dart';
import '../search_user/search_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMainWidget extends StatefulWidget {
  const ChatMainWidget({Key key}) : super(key: key);

  @override
  _ChatMainWidgetState createState() => _ChatMainWidgetState();
}

class _ChatMainWidgetState extends State<ChatMainWidget> {
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
        final chatMainUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: AppTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            title: Text(
              'All Chats',
              style: AppTheme.of(context).subtitle1,
            ),
            actions: [
              AppIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.add_sharp,
                  color: AppTheme.of(context).alternate,
                  size: 30,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 300),
                      reverseDuration: Duration(milliseconds: 300),
                      child: SearchUserWidget(),
                    ),
                  );
                },
              ),
              AppIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.group_add_sharp,
                  color: AppTheme.of(context).alternate,
                  size: 30,
                ),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      duration: Duration(milliseconds: 300),
                      reverseDuration: Duration(milliseconds: 300),
                      child: GroupChatWidget(),
                    ),
                  );
                },
              ),
            ],
            centerTitle: false,
            elevation: 4,
          ),
          backgroundColor: AppTheme.of(context).primaryBackground,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                    child: StreamBuilder<List<ChatsRecord>>(
                      stream: queryChatsRecord(
                        queryBuilder: (chatsRecord) => chatsRecord
                            .where('users', arrayContains: currentUserReference)
                            .orderBy('last_message_time', descending: true),
                      ),
                      builder: (context, snapshot) {
                        // Loading widget
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: SpinKitRing(
                                color:
                                    AppTheme.of(context).secondaryColor,
                                size: 50,
                              ),
                            ),
                          );
                        }
                        List<ChatsRecord> listViewChatsRecordList =
                            snapshot.data;
                        if (listViewChatsRecordList.isEmpty) {
                          return Image.asset(
                            'assets/images/chatsEmpty.png',
                            width: MediaQuery.of(context).size.width,
                            height: 450,
                          );
                        }
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewChatsRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewChatsRecord =
                                listViewChatsRecordList[listViewIndex];
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
                              child: StreamBuilder<AppChatInfo>(
                                stream: AppChatManager.instance.getChatInfo(
                                    chatRecord: listViewChatsRecord),
                                builder: (context, snapshot) {
                                  final chatInfo = snapshot.data ??
                                      AppChatInfo(listViewChatsRecord);
                                  return AppChatPreview(
                                    onTap: () => Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        duration: Duration(milliseconds: 300),
                                        reverseDuration:
                                            Duration(milliseconds: 300),
                                        child: ChatDetailsWidget(
                                          chatUser:
                                              chatInfo.otherUsers.length == 1
                                                  ? chatInfo
                                                      .otherUsersList.first
                                                  : null,
                                          chatRef:
                                              chatInfo.chatRecord.reference,
                                        ),
                                      ),
                                    ),
                                    lastChatText: chatInfo.chatPreviewMessage(),
                                    lastChatTime:
                                        listViewChatsRecord.lastMessageTime,
                                    seen: listViewChatsRecord.lastMessageSeenBy
                                        .contains(currentUserReference),
                                    title: chatInfo.chatPreviewTitle(),
                                    userProfilePic: chatInfo.chatPreviewPic(),
                                    color: AppTheme.of(context).dark900,
                                    unreadColor:
                                        AppTheme.of(context).tertiary,
                                    titleTextStyle: GoogleFonts.getFont(
                                      'Mukta',
                                      color: AppTheme.of(context)
                                          .tertiaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                    dateTextStyle: GoogleFonts.getFont(
                                      'Mukta',
                                      color:
                                          AppTheme.of(context).grayIcon,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                    previewTextStyle: GoogleFonts.getFont(
                                      'Mukta',
                                      color:
                                          AppTheme.of(context).grayIcon,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                    ),
                                    contentPadding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            8, 3, 8, 3),
                                    borderRadius: BorderRadius.circular(0),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
