import 'dart:math';

import 'package:decisive_app/components/custom_textfield/custom_textfield.dart';
import 'package:decisive_app/core/models/menu.dart';
import 'package:decisive_app/utils/helpers.dart';
import 'package:flutter/material.dart';

enum TimeOfDayType {
  OPENING,
  CLOSING
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _foodNameController = TextEditingController();
  final TextEditingController _foodPriceController = TextEditingController();
  final TextEditingController _foodDescriptionController = TextEditingController();
  final TextEditingController _openingTimeController = TextEditingController(text: '00:00');
  final TextEditingController _closingTimeController = TextEditingController(text: '00:00');
  final List<Menu> _menu = List();

  GlobalKey<FormState> _addFoodkey = GlobalKey<FormState>();
  TimeOfDay _openingTime;
  TimeOfDay _closingTime;

  Future<Null> selectTime(BuildContext context, TimeOfDayType type) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );
    if (picked != null) {
      setState(() {
        switch(type){
          case TimeOfDayType.OPENING:
            _openingTime = picked;
            _openingTimeController.text = picked.format(context);
            break;
          case TimeOfDayType.CLOSING:
            _closingTime = picked;
            _closingTimeController.text = picked.format(context);
            break;
        }
      });
    }
  }

  Widget _buildAddMenuForm(BuildContext context) {
    return Container(
      width: Helper.getResponsiveWidth(90, context),
      height: 500,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Form(
        key: _addFoodkey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add Food',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              key: Key('Name-Field'),
              labelTextString: 'Food Name',
              controller: _foodNameController,
              validator: (String value) {
                if (Helper.checkIfFieldIsEmpty(value) != null) {
                  return Helper.checkIfFieldIsEmpty(value);
                }

                return null;
              },
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              key: Key('Description'),
              labelTextString: 'Food Description',
              maxLines: 4,
              controller: _foodDescriptionController,
              validator: (String value) {
                if (Helper.checkIfFieldIsEmpty(value) != null) {
                  return Helper.checkIfFieldIsEmpty(value);
                }

                return null;
              },
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextField(
              key: Key('Price'),
              labelTextString: 'Food Price',
              controller: _foodPriceController,
              validator: (String value) {
                if (Helper.checkIfFieldIsEmpty(value) != null) {
                  return Helper.checkIfFieldIsEmpty(value);
                }

                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 300,
              height: 50,
              child: RaisedButton(
                onPressed: () {
                  if (_addFoodkey.currentState.validate()) {
                    Menu menu = Menu(
                        name: _foodNameController.text,
                        description: _foodDescriptionController.text,
                        price: _foodPriceController.text);
                    setState(() {
                      _menu.add(menu);
                    });
                    Navigator.pop(context);
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                color: Helper.primaryColor,
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _builldMenuPicker() {
    return InkWell(
      onTap: () {
        Helper.showActionDialog(context, _buildAddMenuForm);
      },
      child: Container(
        height: 150,
        width: 150,
        margin: EdgeInsets.only(right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.add_circle,
              color: Colors.greenAccent,
              size: 60,
            ),
            Text(
              'Add Menu',
              style: TextStyle(color: Colors.greenAccent),
            )
          ],
        ),
        decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.greenAccent)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _buildMenuWidget(Menu menu) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      width: 200,
      margin: EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            menu.name,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Description: ${menu.description}',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            'Price: ${menu.price}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.fromBorderSide(BorderSide(color: Colors.greenAccent)),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  List<Widget> _buildMenu() {
    List<Widget> menus = [];
    for (int i = 0; i < _menu.length; i++) {
      menus.add(_buildMenuWidget(_menu[i]));
    }

    menus.add(_builldMenuPicker());
    return menus;
  }

  Widget _buildImagePicker(int index) {
    return Container(
      key: Key('$index'),
      height: 150,
      width: 150,
      margin: EdgeInsets.only(right: 10),
      child: Icon(
        Icons.add_circle,
        color: Colors.greenAccent,
        size: 60,
      ),
      decoration: BoxDecoration(
          border: Border.fromBorderSide(BorderSide(color: Colors.greenAccent)),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  List<Widget> _buildImagePickers() {
    List<Widget> pickers = [];
    for (int i = 0; i < 6; i++) {
      pickers.add(_buildImagePicker(i));
    }
    return pickers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: Drawer(
        child: Container(
          color: Helper.primaryColor,
          child: ListView(
            padding: EdgeInsets.only(left: 20),
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                        child: Text(
                      'decisive',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )),
                    SizedBox(
                      height: 20,
                    ),
                    Text('The George', style: TextStyle(color: Colors.white, fontSize: 24)),
                    Text('Ikoyi', style: TextStyle(color: Colors.greenAccent, fontSize: 16))
                  ],
                ),
              ),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.greenAccent,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.dashboard,
                  color: Colors.greenAccent,
                ),
                title: Text(
                  'Dashboard',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.calendar_today,
                  color: Colors.greenAccent,
                ),
                title: Text(
                  'Reservations',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.book,
                  color: Colors.greenAccent,
                ),
                title: Text(
                  'Reports',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.add_box,
                  color: Colors.greenAccent,
                ),
                title: Text(
                  'Create Deals',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
                color: Colors.grey,
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.greenAccent,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Colors.greenAccent,
                ),
                title: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Profile Input'),
        backgroundColor: Helper.primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              CustomTextField(
                key: Key('Name-Field'),
                labelTextString: 'Restaurant Name',
                controller: _nameController,
                validator: (String value) {
                  if (Helper.checkIfFieldIsEmpty(value) != null) {
                    return Helper.checkIfFieldIsEmpty(value);
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                key: Key('Address-Field'),
                labelTextString: 'Address',
                controller: _addressController,
                validator: (String value) {
                  if (Helper.checkIfFieldIsEmpty(value) != null) {
                    return Helper.checkIfFieldIsEmpty(value);
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                key: Key('About-Field'),
                labelTextString: 'About',
                maxLines: 4,
                controller: _aboutController,
                validator: (String value) {
                  if (Helper.checkIfFieldIsEmpty(value) != null) {
                    return Helper.checkIfFieldIsEmpty(value);
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Photos(6)',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 170,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _buildImagePickers(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Menu',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 170,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _buildMenu(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          InkWell(
                            onTap: () => selectTime(context, TimeOfDayType.OPENING),
                            child: CustomTextField(
                              key: Key('Opening-Time'),
                              labelTextString: 'Opening Time',
                              controller: _openingTimeController,
                              onTap: () => selectTime(context, TimeOfDayType.OPENING),
                              enabled: false,
                              validator: (String value) {
                                if (Helper.checkIfFieldIsEmpty(value) != null) {
                                  return Helper.checkIfFieldIsEmpty(value);
                                }

                                return null;
                              },
                            ),
                          ),
                          // Spacer(),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: () => selectTime(context, TimeOfDayType.CLOSING),
                            child: CustomTextField(
                              key: Key('Closing-Time'),
                              labelTextString: 'Closing Time',
                              controller: _closingTimeController,
                              onTap: () => selectTime(context, TimeOfDayType.CLOSING),
                              enabled: false,
                              validator: (String value) {
                                if (Helper.checkIfFieldIsEmpty(value) != null) {
                                  return Helper.checkIfFieldIsEmpty(value);
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          color: Helper.primaryColor,
                          child: Text(
                            'Preview',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          color: Helper.primaryColor,
                          child: Text(
                            'Save',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
