import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive3/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Hive3 extends StatefulWidget {
  const Hive3({super.key});

  @override
  State<Hive3> createState() => _Hive3State();
}

class _Hive3State extends State<Hive3> {
  TextEditingController cvalue1 = TextEditingController();
  TextEditingController cvalue2 = TextEditingController();
  final _box = Hive.box<Person>('Box');
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      children: [
        TextField(
          controller: cvalue1,
          decoration: InputDecoration(
            hintText: 'Name',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
          ),
        ),
        SizedBox(height: 10,),
            TextField(
          controller: cvalue2,
          decoration: InputDecoration(
            hintText: 'age',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
          ),
        ),
        SizedBox(height: 10,),
        ElevatedButton(onPressed: (){
          final name = cvalue1.text;
          final age = int.tryParse(cvalue2.text)??0;
          addvalue(Person(name: name, age: age));
        }, child: Text('Add person'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,foregroundColor: Colors.white),),
        Expanded(
          child: ValueListenableBuilder(valueListenable: _box.listenable(),
           builder: (context, Box<Person>box , _){
             if(box.values.isEmpty){
              return Text('No people added');
              
            }
            return ListView.builder(itemCount: box.length,
              itemBuilder: (context,index){
              final person = box.getAt(index);
          return ListTile(
            title: Text('${person?.name}, ${person?.age}'),
            trailing: Row(mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(onPressed: (){
          edit(index, person!);
                }, icon: Icon(Icons.edit)),
                IconButton(onPressed: (){
          deletevalue(index);
                }, icon: Icon(Icons.delete)),
              ],
            ),
          );
            });
           }),
        )
      ],
    ),
    
    );
  }
  void addvalue(Person person){
    _box.add(person);
    cvalue1.clear();
    cvalue2.clear();
  }
  void deletevalue(int index){
    _box.deleteAt(index);
  }
  void edit(int index, Person person){
    cvalue1.text = person.name;
    cvalue2.text = person.age.toString();
    showDialog(context: context, builder: (context){
      return AlertDialog(
        content: Column(
          children: [
            TextField(controller: cvalue1,
            decoration: InputDecoration(hintText: 'Name'),),
            TextField(controller: cvalue2,
        decoration: InputDecoration(hintText: 'Age'),),
          ],
        ),
        actions: [TextButton(onPressed: (){
          final updatedname =cvalue1.text;
          final updatedage = int.tryParse(cvalue2.text)??person.age;
          update(index, Person(name: updatedname, age: updatedage));
          Navigator.of(context).pop();
        }, child: Text('update'))],
      );
    });
  }
  void update(int index, Person updatedperson){
    _box.putAt(index, updatedperson);
    cvalue1.clear();
    cvalue2.clear();

  }
}