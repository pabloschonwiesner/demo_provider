import 'package:demo_provider/ui/core/app_colors.dart';
import 'package:demo_provider/ui/features/home/provider/home_provider.dart';
import 'package:demo_provider/ui/features/person/widgets/skills_person.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:demo_provider/ui/features/person/provider/person_provider.dart';

class PersonDetail extends StatelessWidget {
  const PersonDetail ({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    const TextStyle _textStyleName =  TextStyle(fontSize: 32, fontWeight: FontWeight.bold);  
    // final _homeProvider = Provider.of<HomeProvider>(context, listen: false);
  
    return Consumer<PersonProvider>(
      builder: ( context , personProvider, child) {
        if(personProvider.isLoading == true) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary)
          );
        } else {
          return SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 50, width: double.infinity,),
              ClipOval(              
                child: FadeInImage(
                  height: 160,
                  width: 160,          
                  fit: BoxFit.contain,    
                  placeholder: const AssetImage('assets/images/personPlaceholder.png'), 
                  image: NetworkImage(personProvider.person.picture!) 
                ),
              ),
              const SizedBox(height: 10),
              Text(personProvider.person.name!, style: _textStyleName),
              const SizedBox(height: 10),
              Text(personProvider.person.lastName!, style: _textStyleName),
              const SizedBox(height: 10),
              if (personProvider.person.personId == null) 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      child: const Text('Other'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.accent),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),                  
                        ))
                      ),
                      onPressed: () async => await personProvider.getNewPerson(),
                    ),
                    const SizedBox(width: 10,),
                    ElevatedButton(
                      child: const Text('Save'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(AppColors.success),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),                  
                        ))
                      ),
                      onPressed: () async { 
                        await personProvider.savePerson();                      
                        Provider.of<HomeProvider>(context, listen: false).getListPerson();
                        Navigator.pop(context, true);
                      },
                    ),
                  ],
                )
              else  
                const SkillsPerson()
            ]),
          );
        }
      }
      
    );
      
  }
}