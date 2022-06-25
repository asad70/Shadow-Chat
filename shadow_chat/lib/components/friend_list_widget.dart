import '../themes/theme.dart';
import '../themes/util.dart';
import 'package:flutter/material.dart';


class FriendListWidget extends StatefulWidget {
  const FriendListWidget({
    Key key,
    this.image,
    this.name,
    this.email,
  }) : super(key: key);

  final String image;
  final String name;
  final String email;

  @override
  _FriendListWidgetState createState() => _FriendListWidgetState();
}

class _FriendListWidgetState extends State<FriendListWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Material(
            color: Colors.transparent,
            elevation: 2,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.of(context).primaryBackground,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.of(context).dark900,
                    offset: Offset(0, 1),
                  )
                ],
                border: Border.all(
                  color: Colors.transparent,
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          color: AppTheme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Container(
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              valueOrDefault<String>(
                                widget.image,
                                'https://cdn.discordapp.com/attachments/889953520718073907/990100461132582942/profile-icon-9.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              widget.name,
                              style: AppTheme.of(context)
                                  .subtitle1
                                  .override(
                                    fontFamily: 'Mukta',
                                    color: AppTheme.of(context)
                                        .tertiaryColor,
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
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 4, 0),
                                child: Text(
                                  widget.email,
                                  style: AppTheme.of(context)
                                      .bodyText2
                                      .override(
                                        fontFamily: 'Mukta',
                                        color: AppTheme.of(context)
                                            .primaryColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chevron_right_rounded,
                          color: AppTheme.of(context).alternate,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
