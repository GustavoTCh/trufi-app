import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/bloc_provider.dart';
import '../blocs/locations_bloc_base.dart';
import '../location/location_storage.dart';
import '../trufi_configuration.dart';
import '../trufi_models.dart';

class SavedLocationsBloc extends LocationsBlocBase {
  static SavedLocationsBloc of(BuildContext context) {
    return BlocProvider.of<SavedLocationsBloc>(context);
  }

  SavedLocationsBloc(
    BuildContext context,
  ) : super(
          context,
          SharedPreferencesLocationStorage("saved_locations"),
        ){
          initSavedPage();
        }

  void initSavedPage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.get('init_Saved_Locations') == null) {
      LatLng _center = TrufiConfiguration().map.center;
      this.inAddLocation.add(TrufiLocation(
          description: 'Home',
          latitude: _center.latitude,
          longitude: _center.longitude,
          type: 'saved_place:home'));
      this.inAddLocation.add(TrufiLocation(
          description: 'Work',
          latitude: _center.latitude,
          longitude: _center.longitude,
          type: 'saved_place:work'));
    }
    preferences.setBool('init_Saved_Locations', true);
  }
}