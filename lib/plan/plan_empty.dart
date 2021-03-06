import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:latlong/latlong.dart';

import 'package:trufi_app/widgets/trufi_map.dart';
import 'package:trufi_app/widgets/trufi_online_map.dart';

class PlanEmptyPage extends StatefulWidget {
  PlanEmptyPage({this.initialPosition, this.onLongPress});

  final LatLng initialPosition;
  final LongPressCallback onLongPress;

  @override
  PlanEmptyPageState createState() => PlanEmptyPageState();
}

class PlanEmptyPageState extends State<PlanEmptyPage>
    with TickerProviderStateMixin {
  final _trufiMapController = TrufiMapController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      TrufiOnlineMap(
        key: ValueKey("PlanEmptyMap"),
        controller: _trufiMapController,
        onLongPress: widget.onLongPress,
        layerOptionsBuilder: (context) {
          return <LayerOptions>[
            _trufiMapController.yourLocationLayer,
          ];
        },
      ),
      Positioned(
        bottom: 16.0,
        right: 16.0,
        child: _buildFloatingActionButton(context),
      ),
    ]);
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Theme.of(context).backgroundColor,
      child: Icon(Icons.my_location, color: Colors.black),
      onPressed: _handleOnYourLocationPressed,
      heroTag: null,
    );
  }

  void _handleOnYourLocationPressed() async {
    _trufiMapController.moveToYourLocation(
      context: context,
      tickerProvider: this,
    );
  }
}
