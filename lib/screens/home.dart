import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import '../noteModel.dart';
import '../search.dart';
class SearchScreen extends StatelessWidget {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  SearchScreen({required this.notificationsPlugin});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate());
            },
            icon: Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Text('App Settings'),
            ),
            ListTile(
              title: Text('Dark Mode'),
              trailing: CupertinoSwitch(
                value: Provider.of<NoteProvider>(context).isDarkMode,
                onChanged: (newValue) {
                  Provider.of<NoteProvider>(context, listen: false).toggleTheme();
                },
              ),
            ),
            ListTile(
              title: Text('Send Notification'),
              onTap: () {
                _showNoti(context);
              },
            ),
          ],
        ),
      ),
      body:Consumer<NoteProvider>(
        builder: (context, noteProvider, _) {
          return ListView.builder(
            itemCount: noteProvider.notes.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(noteProvider.notes[index]),
                onDismissed: (direction) {


                    noteProvider.deleteNote(index);

                },
                child: ListTile(
                  title: Text(noteProvider.notes[index].title),
                  subtitle: Text(noteProvider.notes[index].content),
                  onTap: () {
                    _showEditNoteDialog(context, index);

                  },
                ),
              );
            },
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddNoteDialog(context);
          },
          child: Icon(Icons.add),
        ),
    );
  }
  void _showAddNoteDialog(BuildContext context) {
    String title = '';
    String content = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) {
                  content = value;
                },
                decoration: InputDecoration(labelText: 'Content'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Note newNote = Note(title: title, content: content);
                Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showEditNoteDialog(BuildContext context, int index) {
    Note note = Provider.of<NoteProvider>(context, listen: false).notes[index];
    String updatedTitle = note.title;
    String updatedContent = note.content;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  updatedTitle = value;
                },
                decoration: InputDecoration(labelText: 'Title'),
                controller: TextEditingController(text: updatedTitle),
              ),
              TextField(
                onChanged: (value) {
                  updatedContent = value;
                },
                decoration: InputDecoration(labelText: 'Content'),
                controller: TextEditingController(text: updatedContent),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Note updatedNote = Note(title: updatedTitle, content: updatedContent);
                Provider.of<NoteProvider>(context, listen: false).editNote(index, updatedNote);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
  void _showNoti(BuildContext context) {
    String title = '';
    String content = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Send Notification'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) {
                  content = value;
                },
                decoration: InputDecoration(labelText: 'Content'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _sendNotification(
                  title: title,
                  body: content,
                );

                Navigator.pop(context);
              },
              child: Text('Send'),
            ),
          ],
        );
      },
    );
  }
  Future<void> _sendNotification(
  {required String title, required String body}
      ) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(

      "2318410",
      "Elseba3y",

      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);

    await notificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
