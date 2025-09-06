import 'dart:math';

import 'package:flutter/material.dart';
import 'package:qr_code/delete_btn.dart';
import 'package:qr_code/scanned.dart';

bool? checkSelected(List<Scanned> data) {
  final any = data.any((e) => e.selected);
  if (!any) return false;
  final every = data.every((e) => e.selected);
  if (every) return true;
  return null;
}

int countSelected(List<Scanned> data) {
  var counter = 0;
  for (var e in data) {
    if (e.selected) {
      counter++;
    }
  }
  return counter;
}

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _controller = ScrollController();
  late Future<List<Scanned>> _future;
  bool _isSelectable = false;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _init(),
      child: FutureBuilder(
        future: _future,
        builder: (context, s) {
          if (s.hasError) {
            return Center(
              child: Text("Something went wrong: ${s.error}"),
            );
          }
          if (!s.hasData) {
            return Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          final x = s.data!;
          final check = checkSelected(x);
          final counter = countSelected(x);
          return Stack(
            children: [
              Scrollbar(
                controller: _controller,
                child: ListView.builder(
                  controller: _controller,
                  itemCount: x.length,
                  itemBuilder: (context, i) {
                    final e = x[i];
                    return ListTile(
                      onTap: () {
                        if (_isSelectable) {
                          setState(() {
                            e.selected = !e.selected;
                          });
                          return;
                        }
                        print("copy");
                      },
                      subtitle: Text(
                        e.dateTime.toString(),
                      ),
                      onLongPress: () {
                        setState(() {
                          _isSelectable = true;
                        });
                      },
                      leading: _isSelectable
                          ? Icon(
                              e.selected
                                  ? Icons.check_box_outlined
                                  : Icons.check_box_outline_blank,
                            )
                          : null,
                      trailing: _isSelectable
                          ? null
                          : DeleteBtn(
                              onPressed: () {
                                e.delete();
                                setState(() {
                                  x.remove(e);
                                });
                              },
                            ),
                      title: Text(e.data),
                      isThreeLine: true,
                    );
                  },
                ),
              ),
              if (_isSelectable)
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            for (var e in x) {
                              e.selected = check == true ? false : true;
                            }
                            setState(() {});
                          },
                          icon: Icon(switch (check) {
                            true => Icons.check_box_outlined,
                            false => Icons.check_box_outline_blank_outlined,
                            null => Icons.indeterminate_check_box_outlined,
                          }),
                        ),
                        Expanded(
                          child: Text(
                              "$counter element${counter == 1 ? "" : "s"} selected"),
                        ),
                        DeleteBtn(
                          onPressed: () {},
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isSelectable = false;
                            });
                          },
                          icon: Icon(Icons.close),
                        )
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    setState(() {
      _isSelectable = false;
      _future = Scanned.getAll;
    });
  }
}
