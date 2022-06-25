import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../themes/theme.dart';
import '../themes/util.dart';
import '../themes/widgets.dart';
import '../themes/upload_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EditProfileWidget extends StatefulWidget {
  const EditProfileWidget({
    Key key,
    this.userEmail,
    this.userDisplay,
    this.userPhoto,
  }) : super(key: key);

  final UsersRecord userEmail;
  final UsersRecord userDisplay;
  final DocumentReference userPhoto;

  @override
  _EditProfileWidgetState createState() => _EditProfileWidgetState();
}

class _EditProfileWidgetState extends State<EditProfileWidget> {
  String uploadedFileUrl = '';
  TextEditingController textController1;
  TextEditingController textController2;
  TextEditingController textController3;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: currentUserEmail);
  }

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
        final editProfileUsersRecord = snapshot.data;
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            backgroundColor: AppTheme.of(context).primaryBackground,
            automaticallyImplyLeading: false,
            leading: InkWell(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: AppTheme.of(context).alternate,
                size: 24,
              ),
            ),
            title: Text(
              'Edit Profile',
              style: AppTheme.of(context).subtitle1,
            ),
            actions: [],
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: AppTheme.of(context).primaryBackground,
          body: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: InkWell(
                      onTap: () async {
                        final selectedMedia = await selectMedia(
                          maxWidth: 1000.00,
                          maxHeight: 1000.00,
                          mediaSource: MediaSource.photoGallery,
                          multiImage: false,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          showUploadMessage(
                            context,
                            'Uploading file...',
                            showLoading: true,
                          );
                          final downloadUrls = (await Future.wait(selectedMedia
                                  .map((m) async => await uploadData(
                                      m.storagePath, m.bytes))))
                              .where((u) => u != null)
                              .toList();
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          if (downloadUrls != null &&
                              downloadUrls.length == selectedMedia.length) {
                            setState(
                                () => uploadedFileUrl = downloadUrls.first);
                            showUploadMessage(
                              context,
                              'Success!',
                            );
                          } else {
                            showUploadMessage(
                              context,
                              'Failed to upload media',
                            );
                            return;
                          }
                        }
                      },
                      child: Container(
                        width: 80,
                        height: 80,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          valueOrDefault<String>(
                            editProfileUsersRecord.photoUrl,
                            'https://cdn.discordapp.com/attachments/889953520718073907/990100461132582942/profile-icon-9.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                        child: TextFormField(
                          controller: textController1,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                          ),
                          style: AppTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mukta',
                                color:
                                    AppTheme.of(context).tertiaryColor,
                              ),
                          keyboardType: TextInputType.emailAddress,
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
                        padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                        child: TextFormField(
                          controller: textController2 ??= TextEditingController(
                            text: editProfileUsersRecord.displayName,
                          ),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Full Name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                          ),
                          style: AppTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mukta',
                                color:
                                    AppTheme.of(context).tertiaryColor,
                              ),
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
                        padding: EdgeInsetsDirectional.fromSTEB(20, 12, 20, 0),
                        child: TextFormField(
                          controller: textController3 ??= TextEditingController(
                            text: editProfileUsersRecord.userRole,
                          ),
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Job Title',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: AppTheme.of(context).primaryText,
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                          ),
                          style: AppTheme.of(context)
                              .bodyText1
                              .override(
                                fontFamily: 'Mukta',
                                color:
                                    AppTheme.of(context).tertiaryColor,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: AppButtonWidget(
                    onPressed: () async {
                      final usersUpdateData = createUsersRecordData(
                        email: textController1.text,
                        displayName: textController2?.text ?? '',
                        photoUrl: uploadedFileUrl,
                        userRole: textController3?.text ?? '',
                      );
                      await editProfileUsersRecord.reference
                          .update(usersUpdateData);
                      Navigator.pop(context);
                    },
                    text: 'Save Changes',
                    options: AppButtonOptions(
                      width: 200,
                      height: 45,
                      color: AppTheme.of(context).secondaryBackground,
                      textStyle: AppTheme.of(context).subtitle2,
                      elevation: 1,
                      borderSide: BorderSide(
                        color: AppTheme.of(context).primaryText,
                        width: 1,
                      ),
                      borderRadius: 6,
                    ),
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
