import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/main.dart';
import 'variables.dart';

class All extends StatefulWidget {
  const All({super.key});

  @override
  State<All> createState() => _AllState();
}

class _AllState extends State<All> {
  List<dynamic> notes = [];
  var box = Hive.box('database');
  List<dynamic> todolist = [];
  final TextEditingController _newtitle = TextEditingController();
  final TextEditingController _newnotes = TextEditingController();
  final TextEditingController _search = TextEditingController();
  String search_note = "";
  DateTime now = DateTime.now();
  String created = DateFormat('M/d/yy').format(DateTime.now());

  @override
  void initState() {
    setState(() {
      try {
        notes = box.get('note');
        todolist = box.get('todo');
      } catch (e) {
        notes = [];
        todolist = [];
      }
    });

    print(notes);
    print(todolist);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Row(
            children: [
              Icon(
                CupertinoIcons.chevron_back,
                color: CupertinoColors.systemYellow,
              ),
              SizedBox(width: 5),
              Text(
                "Folders",
                style: TextStyle(
                  color: CupertinoColors.systemYellow,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          onPressed: () {
            setState(() {
              foldertitle = "";
            });
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
      ),

      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        foldertitle,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  CupertinoTextField(
                    controller: _search,
                    prefix: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                      child: Icon(
                        CupertinoIcons.search,
                        color: CupertinoColors.inactiveGray,
                        size: 20,
                      ),
                    ),
                    suffix: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(
                        CupertinoIcons.mic_fill,
                        color: CupertinoColors.inactiveGray,
                        size: 20,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemFill,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    placeholder: "Search",
                    placeholderStyle: TextStyle(
                      color: CupertinoColors.inactiveGray,
                    ),
                    onChanged: (text) {
                      setState(() {
                        search_note = _search.text;
                        print("User typed: $search_note");
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount:
                      search_note == ""
                          ? notes
                              .where(
                                (item) => item['folder'] != 'Recently Deleted',
                              )
                              .length
                          : notes
                              .where(
                                (item) =>
                                    item['folder'] != 'Recently Deleted' &&
                                        item['title'].toLowerCase().contains(
                                          search_note.toLowerCase(),
                                        ) ||
                                    item['notes'].toLowerCase().contains(
                                      search_note.toLowerCase(),
                                    ),
                              )
                              .length,

                  itemBuilder: (context, int index) {
                    final filteredNotes =
                        search_note == ""
                            ? notes
                                .where(
                                  (item) =>
                                      item['folder'] != 'Recently Deleted',
                                )
                                .toList()
                            : notes
                                .where(
                                  (item) =>
                                      item['folder'] != 'Recently Deleted' &&
                                          item['title'].toLowerCase().contains(
                                            search_note.toLowerCase(),
                                          ) ||
                                      item['notes'].toLowerCase().contains(
                                        search_note.toLowerCase(),
                                      ),
                                )
                                .toList();

                    final items = filteredNotes[index];

                    int lastIndex =
                        (search_note == ""
                            ? notes
                                .where(
                                  (item) =>
                                      item['folder'] != 'Recently Deleted',
                                )
                                .length
                            : notes
                                .where(
                                  (item) =>
                                      item['folder'] != 'Recently Deleted' &&
                                      (item['title'].toLowerCase().contains(
                                            search_note.toLowerCase(),
                                          ) ||
                                          item['notes'].toLowerCase().contains(
                                            search_note.toLowerCase(),
                                          )),
                                )
                                .length) -
                        1;

                    TextEditingController title = TextEditingController(
                      text: items['title'],
                    );
                    TextEditingController notes = TextEditingController(
                      text: items['notes'],
                    );

                    String trimNote(String text, int wordLimit) {
                      List<String> words = text.split(' ');
                      if (words.length <= wordLimit) {
                        return text;
                      }
                      return '${words.take(wordLimit).join(' ')}...';
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder:
                                (context) => CupertinoPageScaffold(
                                  navigationBar: CupertinoNavigationBar(

                                    leading: Row(
                                      children: [
                                        CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          child: Icon(
                                            CupertinoIcons.chevron_back,
                                            color: CupertinoColors.systemYellow,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                        Text(
                                          'Notes',
                                          style: TextStyle(
                                            color:
                                            CupertinoColors.systemYellow,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ],
                                    ),

                                    trailing: CupertinoButton(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        'Done',
                                        style: TextStyle(color: Colors.yellow),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          items['title'] = title.text;
                                          items['notes'] = notes.text;

                                          box.put('note', items);

                                          Navigator.pop(context);
                                        });
                                      },
                                    ),
                                  ),
                                  child: SafeArea(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                        20,
                                        5,
                                        20,
                                        5,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: CupertinoColors.black,
                                        ),
                                        child: Column(
                                          children: [
                                            CupertinoTextField(
                                              controller: title,
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textInputAction:
                                                  TextInputAction.next,
                                              decoration: BoxDecoration(
                                                color: CupertinoColors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),

                                            Expanded(
                                              child: CupertinoTextField(
                                                controller: notes,
                                                style: TextStyle(fontSize: 16),
                                                maxLines: null,
                                                expands: true,
                                                textAlignVertical:
                                                    TextAlignVertical.top,
                                                decoration: BoxDecoration(
                                                  color: CupertinoColors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                        );
                      },

                      onLongPress: () { },

                      child: Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemFill,
                          borderRadius: BorderRadius.only(
                            topLeft:
                                index == 0 ? Radius.circular(10) : Radius.zero,
                            topRight:
                                index == 0 ? Radius.circular(10) : Radius.zero,
                            bottomLeft:
                                index == lastIndex
                                    ? Radius.circular(10)
                                    : Radius.zero,
                            bottomRight:
                                index == lastIndex
                                    ? Radius.circular(10)
                                    : Radius.zero,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                          child: Column(
                            children: [
                              CupertinoListTile(
                                title: Text(
                                  items['title'],
                                  style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          items['date'] +
                                              "  " +
                                              trimNote(items['notes'], 3),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    index != lastIndex
                                        ? Divider()
                                        : SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox.shrink(),

                  CupertinoButton(
                    child: Icon(
                      CupertinoIcons.square_pencil,
                      color: CupertinoColors.systemYellow,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
