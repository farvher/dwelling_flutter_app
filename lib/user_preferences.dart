import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:dwelling_flutter_app/Login/login.dart';
import 'package:flutter/material.dart';

class UserPreferencesPage extends StatefulWidget {
  @override
  _UserPreferencesPage createState() => _UserPreferencesPage();
}

class _UserPreferencesPage extends State<UserPreferencesPage> {
  var _propertyTypes = ["Apartamentos", "Casas", "Oficinas", "Locales"];
  var _businessTypes = ["Venta", "Arriendo", "Alquiler"];
  var _propertySelected = "Apartamentos";
  var _businessTypeSelected = "Venta";
  var _selectedLocation = "";

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerHeader(
        child: Text('Dwelling'),
        decoration: BoxDecoration(
          color: const Color(0xff7c94b6),
          image: const DecorationImage(
            image: NetworkImage(
                'http://dwellingpics.blob.core.windows.net/dwelling/metro.png'),
            fit: BoxFit.cover,
          ),
          border: Border.all(
            color: Colors.black,
            width: 8,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      new Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: new Form(
            child: new Column(
              children: <Widget>[
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Seleccione el tipo de inmueble',
                      ),
                      isEmpty: _businessTypeSelected == null,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _businessTypeSelected,
                          isDense: false,
                          onChanged: (String newValue) {
                            setState(() {
                              _businessTypeSelected = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _businessTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 16.0),
                        hintText: 'Seleccione el tipo de inmueble',
                      ),
                      isEmpty: _propertyTypes == null,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _propertySelected,
                          isDense: false,
                          onChanged: (String newValue) {
                            setState(() {
                              _propertySelected = newValue;
                              state.didChange(newValue);
                            });
                          },
                          items: _propertyTypes.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    );
                  },
                ),
                new AutoCompleteTextField<String>(
                    itemSubmitted: (item) {},
                    suggestions: ["bogota", "antioquia", "santander"],
                    itemBuilder: (context, item) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(item),
                          Padding(
                            padding: EdgeInsets.all(15.0),
                          ),
                          Text(
                            item,
                          )
                        ],
                      );
                    },
                    itemFilter: (item, query) {
                      return item.toLowerCase().startsWith(query.toLowerCase());
                    },
                    decoration: new InputDecoration(
                        suffixIcon: Container(
                          width: 85.0,
                          height: 60.0,
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                        filled: true,
                        hintText: 'Ubicacion',
                        hintStyle: TextStyle(color: Colors.black)))
              ],
            ),
          ))
    ]));
  }
}
