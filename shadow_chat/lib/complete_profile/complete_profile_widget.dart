import '../auth/auth_util.dart';
import '../backend/backend.dart';
import '../backend/firebase_storage/storage.dart';
import '../themes/theme.dart';
import '../themes/util.dart';
import '../themes/widgets.dart';
import '../themes/upload_media.dart';
import '../main.dart';
import 'package:flutter/material.dart';


class CompleteProfileWidget extends StatefulWidget {
  const CompleteProfileWidget({Key key}) : super(key: key);

  @override
  _CompleteProfileWidgetState createState() => _CompleteProfileWidgetState();
}

class _CompleteProfileWidgetState extends State<CompleteProfileWidget> {
  String uploadedFileUrl = '';
  TextEditingController displayNameController;
  TextEditingController yourTitleController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    displayNameController = TextEditingController();
    yourTitleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: AppTheme.of(context).primaryBackground,
        automaticallyImplyLeading: false,
        title: Text(
          'Complete Profile',
          style: AppTheme.of(context).subtitle1,
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: Column(
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
                      selectedMedia.every(
                          (m) => validateFileFormat(m.storagePath, context))) {
                    showUploadMessage(
                      context,
                      'Uploading file...',
                      showLoading: true,
                    );
                    final downloadUrls = (await Future.wait(selectedMedia.map(
                            (m) async =>
                                await uploadData(m.storagePath, m.bytes))))
                        .where((u) => u != null)
                        .toList();
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    if (downloadUrls != null &&
                        downloadUrls.length == selectedMedia.length) {
                      setState(() => uploadedFileUrl = downloadUrls.first);
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
                      uploadedFileUrl,
                      'https://media.discordapp.net/attachments/889953520718073907/990100461132582942/profile-icon-9.png',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: TextFormField(
              controller: displayNameController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Your Name',
                hintText: 'What name do you go by?',
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
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              style: AppTheme.of(context).bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: AppTheme.of(context).tertiaryColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
              keyboardType: TextInputType.name,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: TextFormField(
              controller: yourTitleController,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Your Title',
                hintText: 'What do you do?',
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
                contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 20, 24),
              ),
              style: AppTheme.of(context).bodyText1.override(
                    fontFamily: 'Lexend Deca',
                    color: AppTheme.of(context).primaryText,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 24, 0, 0),
            child: AppButtonWidget(
              onPressed: () async {
                final usersUpdateData = createUsersRecordData(
                  photoUrl: valueOrDefault<String>(
                    uploadedFileUrl,
                    'https://image.flaticon.com/icons/png/512/3135/3135715.png',
                  ),
                  displayName: displayNameController.text,
                  userRole: yourTitleController.text,
                );
                await currentUserReference.update(usersUpdateData);
                await Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    duration: Duration(milliseconds: 300),
                    reverseDuration: Duration(milliseconds: 300),
                    child: NavBarPage(initialPage: 'chatMain'),
                  ),
                );
              },
              text: 'Save Profile',
              options: AppButtonOptions(
                width: 230,
                height: 45,
                color: AppTheme.of(context).secondaryBackground,
                textStyle: AppTheme.of(context).subtitle2,
                elevation: 1,
                borderSide: BorderSide(
                  color: AppTheme.of(context).primaryText,
                  width: 1,
                ),
                borderRadius: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
