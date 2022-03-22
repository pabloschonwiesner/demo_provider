import 'package:demo_provider/ui/features/home/provider/home_provider.dart';
import 'package:demo_provider/ui/features/person/widgets/search_skills.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:demo_provider/ui/features/person/widgets/add_button.dart';
import 'package:demo_provider/ui/features/person/widgets/person_detail.dart';
import 'package:demo_provider/ui/core/app_colors.dart';
import 'package:demo_provider/ui/features/person/provider/person_provider.dart';
import 'package:demo_provider/ui/core/dialogs.dart';


class DetailPage extends StatefulWidget {
const DetailPage ({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey<ScaffoldState> _globalKeyDetail = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      key: _globalKeyDetail,
      appBar: AppBar(
        title: const Text('DetailPage'),
        actions: [ 
          if(Provider.of<PersonProvider>(context).isSavedPerson())
            PopupMenuButton(
              onSelected: (value) async {
                if(value == 'eliminar') {
                  bool response = await Dialogs.confirm(context, title: 'Confirmar', message: '¿Quiere eliminar esta persona?');
                  if(response == true) {
                    await Provider.of<PersonProvider>(context, listen: false).deletePerson();      
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Persona eliminada')));
                    await Provider.of<HomeProvider>(context, listen: false).getListPerson();
                    Navigator.of(context).pop();
                  }
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  child: Text('Eliminar persona'),
                  value: 'eliminar'
                )
              ]
            )
        ],
      ),
      body: Consumer<PersonProvider>(
        builder: (context, provider, child) {
          if ( provider.isLoading ) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary,)
            );
          } else {
            if ( provider.isValidPerson ) {
              return const PersonDetail();
            } else {
              return const AddButton();
            }
          }
        },
      ),
      floatingActionButton: Provider.of<PersonProvider>(context).isSavedPerson()
        ? FloatingActionButton(
            child: const Icon(Icons.workspace_premium),
            onPressed: () async {
              await Provider.of<PersonProvider>(context, listen: false).getSkills();
              showSearch(context: context, delegate: SearchSkills());
            },
          ) : null,
    );
  }
}