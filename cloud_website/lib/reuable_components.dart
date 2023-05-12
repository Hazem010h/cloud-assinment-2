import 'package:cloud_website/constants.dart';
import 'package:cloud_website/model.dart';
import 'package:flutter/material.dart';

import 'app_cubit.dart';

void showCustomBottomSheet({
  required context,
  required Widget child,
}){
  showModalBottomSheet(
    context: context,
    builder: (context){
      return child;
    },
  );
}

Widget reusableTextFormField({
  required String label,
  TextInputType keyboardType=TextInputType.text,
  required void Function() onTap,
  required TextEditingController controller,
})=>Padding(
  padding: const EdgeInsets.fromLTRB(8,5,8,5),
  child:   TextFormField(
    keyboardType: keyboardType,
    controller: controller,
    onTap: onTap,
    decoration: InputDecoration(
      enabledBorder: const OutlineInputBorder(),
      labelText: label,
      focusedBorder:OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
    ),
  ),
);

Widget itemListBuilder({
  required Person person,
  required AppCubit cubit,
  required context,
}){
  return Padding(
    padding: const EdgeInsets.fromLTRB(8,8,5,0),
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
            child: Text(
              'Id: ${person.id}',
              textAlign: TextAlign.center,
            ),
        ),
        Expanded(
          flex: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('Name: ${person.name}'),
              Text('Email: ${person.email}'),
              Text('Gender: ${person.gender}'),
              Text('Age: ${person.age}'),
            ],
          ),
        ),
        IconButton(
            onPressed: (){
          showCustomBottomSheet(
            context: context,
            child: Column(
              children: [
                reusableTextFormField(
                  label: person.id!,
                  onTap: (){},
                  controller: newIdController,
                ),
                reusableTextFormField(
                  label: person.name!,
                  onTap: (){},
                  controller: newNameController,
                ),
                reusableTextFormField(
                  label: person.email!,
                  onTap: (){},
                  controller: newEmailController,
                ),
                reusableTextFormField(
                  label: person.gender!,
                  onTap: (){},
                  controller: newGenderController,
                ),
                reusableTextFormField(
                  label: person.age!,
                  onTap: (){},
                  controller: newAgeController,
                ),
                TextButton(onPressed: (){
                  cubit.updateData(
                    id1: person.id!,
                    id2: newIdController.text,
                    name: newNameController.text,
                    email: newEmailController.text,
                    gender: newGenderController.text,
                    age: newAgeController.text,
                  );
                  newIdController.clear();
                  newNameController.clear();
                  newEmailController.clear();
                  newGenderController.clear();
                  newAgeController.clear();
                  Navigator.pop(context);
                }, child: Text('SUBMIT',textAlign: TextAlign.center,))
              ],
            ),
          );
        },
            icon: Icon(Icons.update)
        ),
        IconButton(
            onPressed: (){
              cubit.deleteData(id: person.id!);
            },
            icon: Icon(Icons.delete),
        ),
      ],
    ),
  );
}