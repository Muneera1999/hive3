// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive3/person.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class Hive2 extends StatefulWidget {
//   const Hive2({super.key});

//   @override
//   State<Hive2> createState() => _Hive2State();
// }

// class _Hive2State extends State<Hive2> {
//   TextEditingController cvalue1 = TextEditingController();
//   TextEditingController cvalue2 = TextEditingController();
//     final _box = Hive.box<Person>('Box');
    
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(body: Column(
//       children: [
//         TextField(
//           controller: cvalue1,
//           decoration: InputDecoration(
            
//           hintText: 'Name',
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
//         ),),
//         SizedBox(height: 10,),
//         TextField(
//       controller: cvalue2,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
        
//       hintText: 'Age',
//       border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
//     ),),
//      SizedBox(height: 10,),
//     ElevatedButton(onPressed: (){
//       final name = cvalue1.text;
//       final age = int.tryParse(cvalue2.text)??0;
//       add();
    
//     }, child: Text('Add person')),
//     Expanded(
//       child: ValueListenableBuilder(valueListenable: _box.listenable(),builder: (BuildContext, Box<Person>box,_){
//          if(box.values.isEmpty){
//           return Text('No person added');

//         }
//         return
//          ListView.builder(itemCount: box.length,
//           itemBuilder: ( Context, int index){
//           return ListTile(title: Text(''),trailing: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               IconButton(onPressed: (){alert(index, person!);}, icon:Icon( Icons.edit),),
//               IconButton(onPressed: (){_deletePerson(index);}, icon: Icon(Icons.delete))
//             ],
//           ));
//         }
      
//       );}
//     )
//     )],
//     ),
//     );
//   }
//   void add(Person person){
//     _box.add(person);
//     cvalue1.clear();
//     cvalue2.clear();
//   }
//   void alert(int index, Person person){
    
//     cvalue1.text = person.name;
//     cvalue2.text = person.age.toString();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Update Person'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: cvalue1,
//                 decoration: InputDecoration(labelText: 'Name'),
//               ),
//               TextField(
//                 controller: cvalue2,
//                 decoration: InputDecoration(labelText: 'Age'),
//                 keyboardType: TextInputType.number,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 final updatedName = cvalue1.text;
//                 final updatedAge = int.tryParse(cvalue2.text) ?? person.age;

//                 _updatePerson(index, Person(name: updatedName, age: updatedAge));
//                 Navigator.of(context).pop();
//               },
//               child: Text('Update'),
//             ),
//           ],
//         );

//   });}
//    void _updatePerson(int index, Person updatedPerson) {
//     _box.putAt(index, updatedPerson); 
//     cvalue1.clear();
//     cvalue2.clear();
//   }
//   void _deletePerson(int index) {
//     _box.deleteAt(index);
//   }

// }