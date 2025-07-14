import 'package:xml_rpc/client.dart' as xml_rpc;

void mainOdooRpc() async {
  final url = "https://demo.csit-ksa.com/";
  final db = "demo";
  final username = "admin";
  final password = "9a3bcb56b335c19387d8bf7e43381d935affc602";
  
  // 1. Get version (common call)
  final version = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/common'), 'version', []);
  print('Version: $version');
  
  // 2. Authenticate
  final uid = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/common'), 'authenticate', [db, username, password, <String, Object?>{}]);
  print('UID: $uid');
  
  // 3. Execute search on res.partner
  final partners = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/object'), 'execute_kw', [
    db, 
    uid, 
    password, 
    'res.partner', 
    'search_read', 
    <List<Object?>>[<Object?>[<Object?>['id', 'in', <Object?>[1, 2, 3]]]], 
    <String, Object?>{
        'fields': <Object?>['name', 'phone', 'email', 'id'], 
        'limit': 10 
    }
  ]);
  print('Partners: $partners');
}