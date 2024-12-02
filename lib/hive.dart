import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive3/person.dart';
import 'package:hive_flutter/adapters.dart';

class Hiveeg extends StatefulWidget {
  const Hiveeg({super.key});

  @override
  State<Hiveeg> createState() => _HiveegState();
}

class _HiveegState extends State<Hiveeg> {
  final _box = Hive.box<Person>('peopleBox');
  TextEditingController cvalue1 = TextEditingController();
  TextEditingController cvalue2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        TextField(controller: cvalue1,
          decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintText: 'Name'),),
          SizedBox(height: 10,),
           TextField(keyboardType: TextInputType.number,
            controller: cvalue2,
            decoration: InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      hintText: 'Age'),),
      SizedBox(height: 10,),
      ElevatedButton(onPressed: (){   final name = cvalue1.text;
        final age =int.tryParse(cvalue2.text)??0; 
        _addPerson(Person(name: name, age: age));
     
      }, child: Text('Add Person'),
      style: ElevatedButton.styleFrom(foregroundColor: Colors.white,backgroundColor: Colors.green),),
      Expanded(
        child: ValueListenableBuilder(valueListenable: _box.listenable(), builder:(Context, Box<Person>box,_ )
        
        {
          if(box.values.isEmpty){
            return Text('No person added');}
            return ListView.builder(itemCount: box.length,
              itemBuilder: (context, index){
                final person = box.getAt(index);
              return ListTile(title: Text('${person?.name}'),
              subtitle: Text('${person?.age}',
              ),trailing: Row(mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(onPressed: (){
                    _showUpdateDialog(index, person!);
                  }, icon: Icon(Icons.edit)
                  ,
                  ),
                  IconButton(onPressed: (){_deletePerson(index);}, icon: Icon(Icons.delete))
                ],
              ),);
            });
          }
        ),
      )

      ],
    )
      ,);
  }
  void _addPerson(Person person) {
    _box.add(person);
    cvalue1.clear();
    cvalue2.clear();
  }

  void _deletePerson(int index) {
    _box.deleteAt(index);
  }

  void _showUpdateDialog(int index, Person person) {
  
    cvalue1.text = person.name;
    cvalue2.text = person.age.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cvalue1,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: cvalue2,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedName = cvalue1.text;
                final updatedAge = int.tryParse(cvalue2.text) ?? person.age;

                _updatePerson(index, Person(name: updatedName, age: updatedAge));
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _updatePerson(int index, Person updatedPerson) {
    _box.putAt(index, updatedPerson); 
    cvalue1.clear();
    cvalue2.clear();
  }
}