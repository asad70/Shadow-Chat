import '../backend/backend.dart';
import '../chat_details/chat_details_widget.dart';
import '../components/friend_list_widget.dart';
import '../themes/theme.dart';
import '../themes/util.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:text_search/text_search.dart';

class SearchUserWidget extends StatefulWidget {
  const SearchUserWidget({Key key}) : super(key: key);

  @override
  _SearchUserWidgetState createState() => _SearchUserWidgetState();
}

class _SearchUserWidgetState extends State<SearchUserWidget> {
  List<UsersRecord> simpleSearchResults = [];
  TextEditingController textController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).primaryBackground,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 0),
              child: Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                color: AppTheme.of(context).dark900,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: TextFormField(
                            controller: textController,
                            onChanged: (_) => EasyDebounce.debounce(
                              'textController',
                              Duration(milliseconds: 900),
                              () => setState(() {}),
                            ),
                            onFieldSubmitted: (_) async {
                              await queryUsersRecordOnce()
                                  .then(
                                    (records) => simpleSearchResults =
                                        TextSearch(
                                      records
                                          .map(
                                            (record) => TextSearchItem(record, [
                                              record.email,
                                              record.displayName,
                                              record.userRole
                                            ]),
                                          )
                                          .toList(),
                                    )
                                            .search(textController.text)
                                            .map((r) => r.object)
                                            .toList(),
                                  )
                                  .onError((_, __) => simpleSearchResults = [])
                                  .whenComplete(() => setState(() {}));
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Search for teammates...',
                              hintText: 'Find your teammates',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x004B39EF),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0x004B39EF),
                                  width: 1,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: AppTheme.of(context).alternate,
                              ),
                              suffixIcon: textController.text.isNotEmpty
                                  ? InkWell(
                                      onTap: () => setState(
                                        () => textController?.clear(),
                                      ),
                                      child: Icon(
                                        Icons.clear,
                                        color: AppTheme.of(context)
                                            .alternate,
                                        size: 16,
                                      ),
                                    )
                                  : null,
                            ),
                            style:
                                AppTheme.of(context).bodyText1.override(
                                      fontFamily: 'Mukta',
                                      color: Color(0xFF151B1E),
                                    ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
              child: Builder(
                builder: (context) {
                  final searchResults = simpleSearchResults?.toList() ?? [];
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: searchResults.length,
                    itemBuilder: (context, searchResultsIndex) {
                      final searchResultsItem =
                          searchResults[searchResultsIndex];
                      return Container(
                        decoration: BoxDecoration(),
                        child: InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                duration: Duration(milliseconds: 300),
                                reverseDuration: Duration(milliseconds: 300),
                                child: ChatDetailsWidget(
                                  chatUser: searchResultsItem,
                                ),
                              ),
                            );
                          },
                          child: FriendListWidget(
                            image: valueOrDefault<String>(
                              searchResultsItem.photoUrl,
                              'https://cdn.discordapp.com/attachments/889953520718073907/990100461132582942/profile-icon-9.png',
                            ),
                            name: searchResultsItem.displayName,
                            email: searchResultsItem.userRole,
                          ),
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
    );
  }
}
