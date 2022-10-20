import 'dart:js';

import 'package:aplikasicrud/models/CharaHolocure.dart';
import 'package:aplikasicrud/screens/create.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Character> _listCharacter = [
    Character(
      Name: 'IRyS', 
      Group: 'Project: HOPE', 
      Skill1: 'Half Angel', 
      Skill2: 'Half Demon', 
      Skill3: 'Hope', 
      Special: 'Hope is Descending', 
      StarterWeapon: 'Nephilim Blast',
    ),
    Character(
      Name: 'Calliope Mori', 
      Group: 'HoloMyth', 
      Skill1: 'The Rapper', 
      Skill2: 'Death', 
      Skill3: 'Work-a-holic', 
      Special: 'The Reaper', 
      StarterWeapon: 'Scythe Swing',
    ),
  ];

  _showPopupMenu(BuildContext context, int index ) {
    final CharacterClicked = _listCharacter[index];
    
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('Menu ${CharacterClicked.Name} '),
        actions: <CupertinoActionSheetAction> [
          CupertinoActionSheetAction(
            onPressed: () async {
              Navigator.pop(context);
              final result = await Navigator.push(
                context, 
                CupertinoPageRoute(
                  builder: (context) => CreateEdit(
                    mode: FormMode.update,
                    character: CharacterClicked,
                    ),
                  ),
                );
                if ( result is Character ){
                  setState(() {
                    _listCharacter[index] = result;
                  });
                }
            },
            child: const Text('Edit',
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
              showCupertinoModalPopup <void>(
                context: context, 
                builder: ( BuildContext context) => CupertinoAlertDialog(
                  title: const Text('are you sure?'),
                  content: Text('Character Data ${CharacterClicked.Name} will be deleted'),
                  actions: <CupertinoDialogAction> [
                    CupertinoDialogAction(
                      isDefaultAction: true,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('No')
                      ),
                      CupertinoDialogAction(
                        isDestructiveAction: true,
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            _listCharacter.removeAt(index);
                          });
                        },
                        child: const Text('Yes')
                      )
                  ],
                ) 
                );
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Character Holocure'),
        trailing: GestureDetector(
          onTap: () async {
            final result = await Navigator.push(
              context,
              CupertinoPageRoute(
                builder:  (context) => const CreateEdit(mode: FormMode.create)
                ),
              );
              if (result is Character){
                setState(() {
                  _listCharacter.add(result);
                });
              }
          },
          child: Icon(
            CupertinoIcons.add_circled,
            size: 25,
            ),
        ),
      ), 
      child: SafeArea(
        child: ListView.separated(
            itemCount: _listCharacter.length,
            itemBuilder: (context, index) {
              final item = _listCharacter[index];
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10, 
                ),
                child: GestureDetector (
                  onTap: () => _showPopupMenu(context, index),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text ('${item.Name} (${item.Group})',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.pink,
                        ),
                      ),
                      Text ('Skill 1 : ${item.Skill1}       skill 2 : ${item.Skill2}      Skill 3 : ${item.Skill3}',
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ), 
                      Text ('Special Skill : ${item.Special}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                      ), 
                      Text ('Starter Weapon :  ${item.StarterWeapon}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.blue,
                        ),
                        ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: ((context, index) {
              return const Divider();
            }), 
          ),
      ),
    );
  }
}