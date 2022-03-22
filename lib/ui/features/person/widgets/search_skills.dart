import 'package:demo_provider/data/models/skill_model.dart';
import 'package:demo_provider/ui/features/person/provider/person_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchSkills extends SearchDelegate {


  SearchSkills() : super(
    searchFieldLabel: 'Buscar'
  );

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('hola $query');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SkillModel> _skills = [...Provider.of<PersonProvider>(context, listen: false).skills];

    _skills.removeWhere((skill) => Provider.of<PersonProvider>(context).skillsPerson.indexWhere((sp) => skill.skillId == sp.skillId ) >= 0);

    if( query != '') {
      _skills.retainWhere((element) => element.name.toLowerCase().contains(query.toLowerCase()));
    } 

    return ListView.builder(
      itemCount: _skills.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(_skills[index].name),
          onTap: () async {
            final _personProvider = Provider.of<PersonProvider>(context, listen: false);
            await _personProvider.setPersonSkill(_skills[index]);
            await _personProvider.getListSkillsPerson();
            close(context, null);
          },
        );
      }          
    );
      
    
  }

  @override
  void showResults(BuildContext context) async {
    print(query);
  }

}