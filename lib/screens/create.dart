import 'package:aplikasicrud/models/CharaHolocure.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum FormMode {create, update}

class CreateEdit extends StatefulWidget {
  const CreateEdit({super.key, required this.mode, this.character });

  final FormMode mode;
  final Character? character;

  @override
  State<CreateEdit> createState() => _CreateEditState();
}

class _CreateEditState extends State<CreateEdit> {
  TextEditingController _NameController = TextEditingController();
  TextEditingController _GroupController = TextEditingController();
  TextEditingController _Skill1Controller = TextEditingController();
  TextEditingController _Skill2Controller = TextEditingController();
  TextEditingController _Skill3Controller = TextEditingController();
  TextEditingController _SpecialController = TextEditingController();
  TextEditingController _StarterWeaponController = TextEditingController();

  @override
  initState(){
    super.initState();
    if (widget.mode == FormMode.update){
      _NameController.text = widget.character!.Name;
      _GroupController.text = widget.character!.Group;
      _Skill1Controller.text = widget.character!.Skill1;
      _Skill2Controller.text = widget.character!.Skill2;
      _Skill3Controller.text = widget.character!.Skill3;
      _SpecialController.text = widget.character!.Special;
      _StarterWeaponController.text = widget.character!.StarterWeapon;
    }
  }

  getData(){
    return Character(
      Name: _NameController.text,
      Group: _GroupController.text,
      Skill1: _Skill1Controller.text,
      Skill2: _Skill2Controller.text,
      Skill3: _Skill3Controller.text,
      Special: _SpecialController.text,
      StarterWeapon: _StarterWeaponController.text,
    );
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Character Holocure'),
        trailing: GestureDetector(
          onTap: (){
            Navigator.pop(context, getData());
          },
          child: Text( widget.mode == FormMode.create ? 'Add' : 'Edit' ),
          ),
        ),
      child: SafeArea(
        child: CupertinoFormSection(
          header: Text (widget.mode == FormMode.create ? 'Add Character Data' : 'Edit Character Data'),
          children: [
            CupertinoFormRow(
              prefix: Text ('Name : ',
                style: TextStyle(
                  color: Colors.pink,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _NameController,
                placeholder: 'Insert Name',
              ),
            ),
            CupertinoFormRow(
              prefix: Text ('Group : ',
                style: TextStyle(
                  color: Colors.pink,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _GroupController,
                placeholder: 'Insert Group',
              ),
            ),
            CupertinoFormRow(
              prefix: Text ('Skill 1 : ',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _Skill1Controller,
                placeholder: 'Insert Skill 1',
              ),
            ),
            CupertinoFormRow(
              prefix: Text ('Skill 2 : ',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _Skill2Controller,
                placeholder: 'Insert Skill 2',
              ),
            ),
            CupertinoFormRow(
              prefix: Text ('Skill 3 : ',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _Skill3Controller,
                placeholder: 'Insert Skill 3',
              ),
            ),
            CupertinoFormRow(
              prefix: Text ('Special : ',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _SpecialController,
                placeholder: 'Insert Special',
              ),
            ),
            CupertinoFormRow(
              prefix: Text ('Starter Weapon : ',
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
              child: CupertinoTextFormFieldRow(
                controller: _StarterWeaponController,
                placeholder: 'Insert Starter Weapon',
              ),
            ),
          ],
        ),
      ),
    );
  }
}