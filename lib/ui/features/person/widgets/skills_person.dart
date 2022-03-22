import 'package:demo_provider/ui/features/person/provider/person_provider.dart';
import 'package:demo_provider/ui/features/person/widgets/skill_person_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SkillsPerson extends StatelessWidget {
const SkillsPerson ({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<PersonProvider>(
      builder: (_, personProvider, child) {
        return  Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 230,    
            child: Wrap(
              children: personProvider.skillsPerson.map((e) => SkillPersonItem(skill: e )).toList(),
              spacing: 6,
            )      
          ),
        );

      },
    );
  }
}