import 'package:flutter/material.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Zefmesh", "location": "Megenagna"},
    {"id": 2, "name": "Edna mall", "location":"In front of medhanialem"},
    {"id": 4, "name": "Friendship Park", "location": "East of 4 kilo palace"},
    {"id": 5, "name": "Ethnological Museum", "location": "6 kilo museum"},
    {"id": 6, "name": "4 kilo Green Area", "location": "North of the Kennedy library"},
    {"id": 7, "name": "Kennedy Museum", "location": "West block of main campus"},
    {"id": 8, "name": "Getu commercial", "location": "East of 4 kilo palace"},
    {"id": 9, "name": "6 kilo museum", "location": "North of the main dormitory"},
    {"id": 10, "name": "6 kilo cafeteria", "location": "North of the Kennedy library"},

  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {

    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
      setState(() {
        _foundUsers = results;
      });
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      setState(() {
        _foundUsers = results;
      });
      // we use the toLowerCase() method to make it case-insensitive
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Registered buildings',
          style: TextStyle(color: Colors.black),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
            Navigator.of(context).pop(); // Redirects to the previous page
          },
          ),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) {
                print(value);
                return _runFilter(value);
              },
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]["id"]),
                  color: Colors.deepOrange,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    onTap: () async {
                    },
                    title: Text(_foundUsers[index]['name'],
                        style:TextStyle(
                          color:Colors.white,
                          fontSize: 21,
                        )
                    ),
                    subtitle: Text(
                        '${_foundUsers[index]["location"].toString()}',style:TextStyle(
                        fontSize: 15,
                        color:Colors.white
                    )),
                  ),
                ),
              )
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}