import 'package:demo_provider/data/models/person_model.dart';
import 'package:demo_provider/ui/core/app_colors.dart';
import 'package:demo_provider/ui/features/home/widgets/person_list.dart';
import 'package:demo_provider/ui/features/person/detail_page.dart';
import 'package:demo_provider/ui/features/person/provider/person_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/home_provider.dart';

class HomePage extends StatelessWidget {
const HomePage ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<HomeProvider>(
        builder: (context, provider, child) {
          if ( provider.isLoading ) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary,)
            );
          } else {
            return SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Center(
                child: provider.persons.isEmpty
                  ? const Text('No hay personas guardadas')
                  : const PersonList()
              )
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Provider.of<PersonProvider>(context, listen: false).setPerson(PersonModel());
          await Navigator.push<bool>(context, MaterialPageRoute(builder: (context) => const DetailPage()));
        }
      ),
    );
  }

}