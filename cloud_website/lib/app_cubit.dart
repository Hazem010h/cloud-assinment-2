import 'package:cloud_website/app_states.dart';
import 'package:cloud_website/model.dart';
import 'package:cloud_website/reuable_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'constants.dart';
import 'dio_helper.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(InitialState());

  Person? person;
  List<Person> persons=[];

  static AppCubit get(context)=>BlocProvider.of(context);

  void addButtonPressed({
    required context,
    required AppCubit cubit,
  }) {
    showCustomBottomSheet(
      context: context,
      child: Column(
        children: [
          reusableTextFormField(
            label: 'Id',
            onTap: (){},
            controller: idController,
          ),
          reusableTextFormField(
            label: 'Name',
            onTap: (){},
            controller: nameController,
          ),
          reusableTextFormField(
            label: 'Email',
            onTap: (){},
            controller: emailController,
          ),
          reusableTextFormField(
            label: 'Gender',
            onTap: (){},
            controller: genderController,
          ),
          reusableTextFormField(
            label: 'Age',
            onTap: (){},
            controller: ageController,
          ),
          TextButton(
            child: Text(
              'SUBMIT',
              textAlign: TextAlign.center,
            ),
            onPressed: (){
              if(idController.text.isEmpty||nameController.text.isEmpty||emailController.text.isEmpty||genderController.text.isEmpty||ageController.text.isEmpty){
                Fluttertoast.showToast(
                    msg: 'All data Must be not empty',
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 5,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0
                );
              }
              else {
                cubit.addData(
                  id: idController.text,
                  name: nameController.text,
                  email: emailController.text,
                  gender: genderController.text,
                  age: ageController.text,
                );
                idController.clear();
                nameController.clear();
                emailController.clear();
                genderController.clear();
                ageController.clear();
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    );
  }

  void getData(){
    DioHelper.getData(
      url: 'persons',
    ).then((value){
      persons=[];
      value.data.forEach((element) {
        person=Person.fromJson(element);
        persons.add(person!);
      });
      emit(GetPersonsSuccessState());
    }).catchError((e){
      print(e.toString());
      emit(GetPersonsErrorState());
    });
  }

  void addData({
    required String id,
    required String name,
    required String email,
    required String gender,
    required String age,
  }){
    DioHelper.postData(
        url: 'persons/',
        data: {
          'id':id,
          'name':name,
          'email':email,
          'gender':gender,
          'age':age,
        }
    ).then((value){
      Fluttertoast.showToast(
          msg: 'New Person Added Successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(AddPersonSuccessState());
      getData();
    }).catchError((error){

      Fluttertoast.showToast(
          msg: 'This id is already exist',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(AddPersonErrorState());
    });
  }

  updateData({
    required String id1,
    required String id2,
    required String name,
    required String email,
    required String gender,
    required String age,
  }){
    DioHelper.putData(
        url: 'persons/$id1',
        data: {
          'id':id2,
          'name':name,
          'email':email,
          'gender':gender,
          'age':age,
        }
    ).then((value){
      Fluttertoast.showToast(
          msg: 'Updated Successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(UpdatePersonSuccessState());
      getData();
    }).catchError((e){
      print(e.toString());
      emit(UpdatePersonErrorState());
    });
  }

  void deleteData({
    required String id
  }){
    DioHelper.deleteData(
        url: 'persons/$id'
    ).then((value){
      emit(DeletePersonSuccessState());
      getData();
      Fluttertoast.showToast(
          msg: 'Person Deleted Successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }
}