import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:littlewords/listword.dart';
import 'package:littlewords/main.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'addword.dart';
import 'home.dart';
import 'device_location.provider.dart';
import 'package:location/location.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFF5CB2E8)),
      home: MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  late final MapController _mapController;
  String? username;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mapController = MapController();
    initial();
  }

  void initial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFC92A2A),
        title: Text("$username"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              var prefs = await SharedPreferences.getInstance();
              prefs.setBool('login', true);
              Navigator.pushReplacement(context,
                  new MaterialPageRoute(builder: (context) => MyLoginPage()));
            },
            child: Text('Deconnection'),
          )
        ],
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: Consumer(
                  builder: (BuildContext context, WidgetRef ref, Widget? child) {
                    return ref.watch(deviceLocationProvider).when(data: _onData, error: _onError, loading: _onLoading);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Consumer(
              builder: (context, ref, child) {
                return FloatingActionButton(
                  onPressed: () => _openAddWord(context),
                  tooltip: 'AddWord',
                  child: const Icon(Icons.arrow_upward),
                );
              },
            ),
            Consumer(
              builder: (context, ref, child) {
                return FloatingActionButton(
                  onPressed: () => _openListWord(context),
                  tooltip: 'AddWord',
                  child: const Icon(Icons.arrow_upward),
                );
              },
            ),
          ]
      ),);

  }

  Widget _onData(LatLng data) {
    return FlutterMap(
      mapController: _mapController,
      options:
      MapOptions(
        zoom: 13,
        onMapReady: () async{
          _mapController.move(data, _mapController.zoom);
        },
      ),
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        const MyPositionMarkerLayer(),
      ],
    );
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return Container(color: Colors.red,);
  }

  Widget _onLoading() {
    return const Center(child: CircularProgressIndicator(),);
  }



  void _openAddWord(final BuildContext context) {
    print('call openAddWord');
    final _txtCtrl = TextEditingController();
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        backgroundColor: Color(0xffCEDAE4),
        builder: (context){
          return AddWord(ctrl: _txtCtrl);
        });

  }

  void _openListWord(final BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        backgroundColor: Color(0xffCEDAE4),
        builder: (context) {
          return ListWord();
        });
  }
}

class MyPositionMarkerLayer extends ConsumerWidget {
  const MyPositionMarkerLayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(deviceLocationProvider).when(data: _onData, error: _onError, loading: _onLoading);
  }

  Widget _onData(LatLng data) {
    return MarkerLayer(
      markers: [
        Marker(point: data, builder: (context) => const Icon(Icons.location_on, color: Colors.red, size: 40.0),
        ),
      ],
    );
  }

  Widget _onError(Object error, StackTrace stackTrace) {
    return const SizedBox();
  }

  Widget _onLoading() {
    return const SizedBox();
  }
}