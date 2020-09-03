import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;

  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  Function get emit => this._socket.emit;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    // final localHost = 'http://172.21.0.1:3000/';
    final devHost = 'https://band-names-server.herokuapp.com/';

    this._socket = IO.io(devHost ,{
      'transports': ['websocket'],
      'autoConnect': true
    });
    this._socket.on('connect', (_) {
      print('connect');
      this._serverStatus = ServerStatus.Online;
      // Re-Draw
      notifyListeners();
    });
    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      // Re-Draw
      notifyListeners();
    });
    /*socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje: $payload');
      print('nombre: ' +  payload['nombre']);
      print('mensaje: ' +  payload['message']);
    });*/
  }
}
