import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:flutter/widgets.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class RecordListModel extends ChangeNotifier {
  List<Record> records = [];
  bool isLoading = true;
  final String _rpcUrl = "http://192.168.43.3:7545";
  final String _wsUrl = "ws://192.168.43.3:7545";
  final String _privatekey =
      'ec22fdcec0bb2943d3ad6c84543a5095d993799725c8af21a4beb83e81438a7d';

  late String uemail;
  late Web3Client _client;
  var _abicode;
  int taskCount = 0;
  late Credentials _credentials;
  late EthereumAddress _contractAddress;
  late EthereumAddress _ownAddressl;
  late DeployedContract _contract;
  late ContractFunction _recordCount;
  late ContractFunction _recdones;
  late ContractFunction _createRecord;
  late ContractEvent _recordCreatedEvent;

  RecordListModel(email) {
    this.uemail = email;
    initialeSetup();
  }

  Future<void> initialeSetup() async {
    _client = Web3Client(
      _rpcUrl,
      Client(),
      socketConnector: () {
        return IOWebSocketChannel.connect(_wsUrl).cast<String>();
      },
    );
    await getAbifunc();
    await getCredentials();
    await getDeployedContract();
  }

  getAbifunc() async {
    String abiStringFile =
        await rootBundle.loadString("src/abis/MedicalList.json");
    var jsonAbi = jsonDecode(abiStringFile);
    _abicode = jsonEncode(jsonAbi['abi']);
    _contractAddress =
        EthereumAddress.fromHex(jsonAbi["networks"]["5777"]['address']);
  }

  Future<void> getCredentials() async {
    _credentials = await _client.credentialsFromPrivateKey(_privatekey);
    _ownAddressl = await _credentials.extractAddress();
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abicode, "MedicalList"), _contractAddress);
    _recordCount = _contract.function('medicalcount');
    _createRecord = _contract.function('createService');
    _recdones = _contract.function("rec1");
    _recordCreatedEvent = _contract.event("RecordAdded");
    getTods(uemail);
  }

  getTods(String email) async {
    var totaTasksListc = await _client
        .call(contract: _contract, function: _recordCount, params: []);
    BigInt totalCount = totaTasksListc[0];
    taskCount = totalCount.toInt();
    for (var i = 0; i < totalCount.toInt(); i++) {
      var temp = await _client.call(
          contract: _contract, function: _recdones, params: [BigInt.from(i)]);
      if (email == temp[1]) {
        records.add(Record(
            customername: temp[0],
            customeremail: temp[1],
            doctorid: temp[2],
            doctorname: temp[3],
            doctoremail: temp[4],
            recordhash: temp[5]));
      }
    }
    isLoading = false;
    notifyListeners();
  }

  addTask(String customername, String customeremail, String doctorid,
      String doctorname, String doctoremail, String recordhash) async {
    isLoading = true;
    notifyListeners();
    await _client.sendTransaction(
        _credentials,
        Transaction.callContract(
            contract: _contract,
            function: _createRecord,
            parameters: [
              customername,
              customeremail,
              doctorid,
              doctorname,
              doctoremail,
              recordhash,
            ]));
    getTods(this.uemail);
  }
}

class Record {
  String customername;
  String customeremail;
  String doctorid;
  String doctorname;
  String doctoremail;
  String recordhash;
  Record(
      {required this.customername,
      required this.customeremail,
      required this.doctorid,
      required this.doctorname,
      required this.doctoremail,
      required this.recordhash});
}
