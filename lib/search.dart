import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'noteModel.dart';

class CustomSearchDelegate extends SearchDelegate {
  @override
  Widget buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (query) {
        Provider.of<NoteProvider>(context, listen: false).searchNotes(query);
      },
      decoration: InputDecoration(
        hintText: 'Search...',
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Use the search results provided by the NoteProvider
    List<Note> searchResults =
    Provider.of<NoteProvider>(context).searchNotes(query);

    return ListView.builder(
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchResults[index].title),
          subtitle: Text(searchResults[index].content),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context); // Reuse the suggestions for simplicity
  }

  @override
  void onQueryChanged(String query) {
    // Update the search suggestions based on the query


  }

  @override
  void onSearchQuerySubmit(String query) {
    // Display final search results based on the query
  }

  @override
  List<Widget>? buildActions(BuildContext context) {

  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
  }
}