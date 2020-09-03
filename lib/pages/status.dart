import 'package:bands/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class StatusPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    // socketService.socket.emit(event)
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.message),
        onPressed: (){
          final mapa = {'nombre':'Flutter', 'message':'Hola desde Flutter'};
          socketService.emit('emitir-mensaje', mapa);
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text('Server Status : ${socketService.serverStatus}')
        ],)
     ),
   );
  }
}