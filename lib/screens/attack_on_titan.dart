import 'package:flutter/material.dart';
import '../dummy_data.dart';
class AttackOnTitan extends StatelessWidget {
  AttackOnTitan({super.key});

  final DummyData _dummyData = DummyData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Attack On Titan",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black,fontSize: 30,fontStyle: FontStyle.italic),
        ),
      ),
      body: FutureBuilder(
        future: _dummyData.getAOTCharacters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Characters(_dummyData.characters);
        },
      ),
    );
  }
}

class Characters extends StatefulWidget {
  final List<Map<String, dynamic>> _list;
  Characters(this._list);

  @override
  State<Characters> createState() => _CharactersState();
}

class _CharactersState extends State<Characters> {
  int _isExpanded = -1;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._list.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            ListTile(
              tileColor: _isExpanded == index ? Colors.black : Colors.white,
              
              onTap: () {
                setState(() {
                  _isExpanded = _isExpanded == index ? -1 : index;
                });
              },
              leading: const CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://i.pinimg.com/originals/57/ed/3b/57ed3b5c113d60d1fa0eced7e2e37357.png"),
              ),
              title: Text(
                widget._list[index]["first_name"],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _isExpanded == index ? Colors.white : Colors.black,
                ),
              ),
              subtitle: Text(
                "${widget._list[index]["first_name"]} ${widget._list[index]["last_name"]}",
                style: TextStyle(
                  color: _isExpanded == index ? Colors.white : Colors.black,
                ),
              ),
              trailing: _isExpanded != index
                  ? const Icon(Icons.arrow_circle_down)
                  : const Icon(Icons.arrow_circle_up,color: Colors.white,),
            ),
            if (_isExpanded == index)
              Container(
                color: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Properties("Species", widget._list[index]["species"]),
                    Properties("Age", widget._list[index]["age"].toString()),
                    Properties(
                        "Height", widget._list[index]["height"].toString()),
                    Properties("Residence", widget._list[index]["residence"]),
                    Properties("Status", widget._list[index]["status"]),
                    Properties("Alias", widget._list[index]["alias"]),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class Properties extends StatelessWidget {
  final String _pName;
  final String? _text;
  Properties(this._pName, this._text);

  @override
  Widget build(BuildContext context) {
    return Text(
      "$_pName : ${_text == null ? "Empty" : _text}",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}