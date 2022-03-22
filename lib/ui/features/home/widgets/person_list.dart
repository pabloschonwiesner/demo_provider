import 'package:demo_provider/ui/features/home/provider/home_provider.dart';
import 'package:demo_provider/ui/features/home/widgets/person_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonList extends StatelessWidget {
const PersonList ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    print('personList');
    
    return Consumer<HomeProvider>(
      builder: (_, homeProvider, child) {
        return ListView.separated(
          padding: const EdgeInsets.only(top: 60),
          separatorBuilder: (_, int i) => const Divider(),
          itemCount: homeProvider.persons.length,
          itemBuilder: (BuildContext context, int i) => PersonItem(person: homeProvider.persons[i]) 
        );

      },
    );
  }
}