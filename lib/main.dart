import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/all.dart';
import 'package:notes/notes.dart';
import 'variables.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  var box = await Hive.openBox('database');

  runApp(
    CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(brightness: Brightness.dark),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> notes = [];

  List<dynamic> defaultdata = [
    {
      'leading': true,
      'title': "All iCloud",
      'additional_info': 0,
      'default': true,
    },
    {'leading': true, 'title': "Notes", 'additional_info': 0, 'default': true},
    {
      'leading': true,
      'title': "Archives",
      'additional_info': 0,
      'default': true,
    },
    {
      'leading': false,
      'title': "Recently Deleted",
      'additional_info': 0,
      'default': true,
    },
  ];

  List<dynamic> todolist = [];

  List<dynamic> notesdata = [];
  TextEditingController _newtitle = TextEditingController();
  TextEditingController _newnotes = TextEditingController();
  DateTime now = DateTime.now();
  String created = DateFormat('M/d/yy').format(DateTime.now());
  TextEditingController _search = TextEditingController();
  TextEditingController _newfolder = TextEditingController();
  String seach_input = "";
  bool activity = true;

  var box = Hive.box('database');
  @override
  void initState() {
    // TODO: implement initState

    try {
      notes = box.get('note');
      notesdata = box.get('note');
    } catch (e) {
      notes = [];
      notesdata = [];
    }

    todolist = box.get('todo') ?? [];

    for (var dataItem in defaultdata) {
      if (!todolist.any((item) => item['title'] == dataItem['title'])) {
        todolist.add(dataItem);
      }
    }

    box.put('todo', todolist);

    print(todolist);
    print(activity);

    super.initState();

    Timer(Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          activity = false;
          print('ds $activity');
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(
            CupertinoIcons.person,
            color: CupertinoColors.systemYellow,
          ),
          onPressed: () {
            showCupertinoDialog(
              context: context,
              builder: (context) {
                return CupertinoAlertDialog(
                  title: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      'Development Team',
                      style: TextStyle(
                        color: CupertinoColors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  content: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemFill,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/beyonce.jpg",
                                height: 60,
                                width: 60,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ama Beyonce",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Software Developer",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemFill,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/bulanadi.jpeg",
                                height: 60,
                                width: 60,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bulanadi, Jhon Vianney",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Software Developer",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemFill,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/culala.jpg",
                                height: 60,
                                width: 60,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Culala, Andrea",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Software Developer",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemFill,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/jc.jpg",
                                height: 60,
                                width: 60,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Dizon, John Carlo V",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Software Developer",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: CupertinoColors.systemFill,
                          ),
                          child: Row(
                            children: [
                              Image.asset(
                                "images/timbol.jpg",
                                height: 60,
                                width: 60,
                                fit: BoxFit.fill,
                              ),
                              SizedBox(width: 15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Timbol, Christian",
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    "Software Developer",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    CupertinoButton(
                      child: Text(
                        'Close',
                        style: TextStyle(color: CupertinoColors.destructiveRed),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              },
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
                        'Folders',
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
                        seach_input = _search.text;
                        print("User typed: $seach_input");
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'iCloud',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  activity == true
                      ? CupertinoActivityIndicator()
                      : SizedBox.shrink(),
                ],
              ),

              SizedBox(height: 10),

              Expanded(
                child: ListView.separated(
                  itemCount:
                      seach_input == ""
                          ? todolist.length
                          : todolist
                              .where(
                                (item) => item['title'].toLowerCase().contains(
                                  seach_input.toLowerCase(),
                                ),
                              )
                              .length,

                  separatorBuilder:
                      (context, index) => Divider(
                        height: 1,
                        thickness: 0.5,
                        indent: 60,
                        endIndent: 16,
                        color: CupertinoColors.separator,
                      ),
                  itemBuilder: (context, index) {
                    final filteredNotes =
                        (seach_input == ""
                                ? todolist
                                : todolist.where(
                                  (item) => item['title']
                                      .toLowerCase()
                                      .contains(seach_input.toLowerCase()),
                                ))
                            .toList();

                    filteredNotes.sort((a, b) {
                      if (a['leading'] == b['leading']) return 0;
                      return a['leading'] ? -1 : 1;
                    });

                    final item = filteredNotes[index];

                    int count =
                        item['title'] == 'All iCloud'
                            ? notesdata
                                .where(
                                  (data) =>
                                      data['folder'] != 'Recently Deleted',
                                )
                                .length
                            : notesdata
                                .where(
                                  (data) => data['folder'] == item['title'],
                                )
                                .length;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          foldertitle = item['title'];
                        });

                        if (foldertitle == "All iCloud") {
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(builder: (context) => All()),
                          );
                        } else {
                          Navigator.pushReplacement(
                            context,
                            CupertinoPageRoute(builder: (context) => Notes()),
                          );
                        }
                      },

                      onLongPress: () {
                        if (item['default'] == false) {
                          showCupertinoModalPopup(
                            context: context,
                            builder:
                                (BuildContext context) => Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: CupertinoActionSheet(
                                        title: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Icon(
                                            item['leading']
                                                ? CupertinoIcons.folder
                                                : CupertinoIcons.trash,
                                            color:
                                                item['leading']
                                                    ? CupertinoColors
                                                        .systemYellow
                                                    : CupertinoColors.systemRed,
                                            size:
                                                MediaQuery.sizeOf(
                                                  context,
                                                ).width *
                                                0.40,
                                          ),
                                        ),

                                        message: Row(
                                          children: [
                                            Text(
                                              item['title'],
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),

                                        cancelButton:
                                            CupertinoActionSheetAction(
                                              onPressed: () {
                                                setState(() {
                                                  todolist.removeWhere(
                                                    (items) =>
                                                        items['title'] ==
                                                        item['title'],
                                                  );
                                                });
                                                box.put('todo', todolist);
                                                Navigator.pop(context);
                                              },
                                              isDestructiveAction: true,
                                              child: const Text(
                                                'Delete',
                                                style: TextStyle(fontSize: 17),
                                              ),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                          );
                        }
                      },

                      child: Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemFill,
                        ),
                        child: CupertinoListTile(
                          leading: Icon(
                            item['leading']
                                ? CupertinoIcons.folder
                                : CupertinoIcons.trash,
                            color:
                                item['leading']
                                    ? CupertinoColors.systemYellow
                                    : CupertinoColors.systemRed,
                          ),
                          title: Text(
                            item['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          additionalInfo: Text(
                            '$count',
                            style: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontSize: 14,
                            ),
                          ),
                          trailing: Icon(
                            CupertinoIcons.chevron_forward,
                            color: CupertinoColors.systemGrey,
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
                  CupertinoButton(
                    child: Icon(
                      CupertinoIcons.folder_badge_plus,
                      color: CupertinoColors.systemYellow,
                    ),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder:
                            (BuildContext context) => Container(
                              height: MediaQuery.sizeOf(context).height * 0.94,
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: CupertinoColors.black,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            color: CupertinoColors.systemYellow,
                                          ),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                      Text(
                                        "New Folder",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      CupertinoButton(
                                        padding: EdgeInsets.zero,
                                        child: Text(
                                          'Done',
                                          style: TextStyle(
                                            color: CupertinoColors.systemYellow,
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            todolist.add({
                                              'leading': true,
                                              'title': _newfolder.text,
                                              'additional_info': 0,
                                              'default': false,
                                            });
                                            _newfolder.text = "";
                                          });

                                          box.put('todo', todolist);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 5),

                                  CupertinoTextField(
                                    controller: _newfolder,
                                    placeholder: "New Folder",
                                    decoration: BoxDecoration(
                                      color: CupertinoColors.systemFill,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      );
                    },
                  ),

                  CupertinoButton(
                    child: Icon(
                      CupertinoIcons.square_pencil,
                      color: CupertinoColors.systemYellow,
                    ),
                    onPressed: () {
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
                                          color: CupertinoColors.systemYellow,
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
                                        notes.add({
                                          'title': _newtitle.text,
                                          'notes': _newnotes.text,
                                          'date': created,
                                          'folder': 'Notes',
                                          'status': true,
                                          'deleted': false,
                                          'deleted_date': "",
                                        });
                                        box.put('note', notes);
                                        _newtitle.text = "";
                                        _newnotes.text = "";

                                        setState(() {
                                          notes = [];
                                        });
                                        try {
                                          notes = box.get('note');
                                        } catch (e) {
                                          notes = [];
                                        }
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
                                            controller: _newtitle,
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
                                              controller: _newnotes,
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
