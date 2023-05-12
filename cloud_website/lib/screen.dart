import 'package:cloud_website/app_cubit.dart';
import 'package:cloud_website/app_states.dart';
import 'package:cloud_website/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'reuable_components.dart';

class Screen extends StatelessWidget {
   Screen({Key? key}) : super(key: key);

  Person person=Person(
    id: '1',
    name: 'Hazem',
    age: '21',
    email: 'hazem@example.com',
    gender: 'male',
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>AppCubit()..getData(),
      child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            AppCubit cubit =AppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text('Cloud Website'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: (){
                      cubit.addButtonPressed(
                        context: context,
                        cubit: cubit,
                      );
                    },
                  )
                ],
              ),
              body: ListView.separated(
                  itemBuilder: (context,index)=>itemListBuilder(
                    context: context,
                    cubit: cubit,
                    person: cubit.persons[index],
                  ),
                  separatorBuilder: (context,index)=>Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                      thickness: 1,
                    ),
                  ),
                  itemCount: cubit.persons.length,
              ),
            );
          },
      ),
    );
  }
}
