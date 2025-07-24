import 'package:xml_rpc/client.dart' as xml_rpc;
import 'dart:convert';
import 'package:http/http.dart' as http;

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

class OdooService{
  final String url;
  final String db;
  final String username;
  final String password;

  OdooService({required this.url, required this.db, required this.username, required this.password});

  String object = 'res.partner';

  Future<int> authenticate() async {
    final uid = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/common'), 'authenticate', [db, username, password, <String, Object?>{}]);
    return uid;
  }

  Future<void> getVersion() async {
    final version = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/common'), 'version', []);
    print('Version: $version');
  }

  // customers with address
  Future<void> getPartners() async {
    final uid = await authenticate();
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

// products without variants -- main product 
  Future<void> getProductTemplates() async {
    final uid = await authenticate();
    final products = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/object'), 'execute_kw', [
      db, 
      uid, 
      password, 
      'product.template', 
      'search_read', 
      <List<Object?>>[<Object?>[<Object?>['id', 'in', <Object?>[1, 2, 3]]]], 
      <String, Object?>{
          'fields': <Object?>[], 
          'limit': 10 
      }
    ]);
    print('Products: $products');
  }

// products with variants -- variants for main product
  Future<void> getProductProducts() async {
    final uid = await authenticate();
    final products = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/object'), 'execute_kw', [
      db, 
      uid, 
      password, 
      'product.product', 
      'search_read', 
      <List<Object?>>[<Object?>[<Object?>['id', 'in', <Object?>[1, 2, 3]]]], 
      <String, Object?>{
          'fields': <Object?>[], 
          'limit': 10 
      }
    ]);
    print('Products: $products');
    // return products;
  }

  Future<void> getSalesOrders() async {
    final uid = await authenticate();
    final salesOrders = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/object'), 'execute_kw', [
      db, 
      uid, 
      password, 
      'sale.order', 
      'search_read', 
      <List<Object?>>[<Object?>[<Object?>['id', 'in', <Object?>[1, 2, 3]]]], 
      <String, Object?>{
          'fields': <Object?>['name', 'phone', 'email', 'id'], 
          'limit': 10 
      }
    ]);
    print('Sales Orders: $salesOrders');
    // return salesOrders;
  }

  Future<void> getSalesOrderLines() async {
    final uid = await authenticate();
    final salesOrderLines = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/object'), 'execute_kw', [
      db, 
      uid, 
      password, 
      'sale.order.line', 
      'search_read', 
      <List<Object?>>[<Object?>[<Object?>['id', 'in', <Object?>[1, 2, 3]]]], 
      <String, Object?>{
          'fields': <Object?>['name', 'phone', 'email', 'id'], 
          'limit': 10 
      }
    ]);
    print('Sales Order Lines: $salesOrderLines');
    // return salesOrderLines;
  }

  Future<void> getInvoices() async {
    final uid = await authenticate();
    final invoices = await xml_rpc.call(Uri.parse('${url  }/xmlrpc/2/object'), 'execute_kw', [
      db, 
      uid, 
      password, 
      'account.move', 
      'search_read', 
      <List<Object?>>[<Object?>[<Object?>['id', 'in', <Object?>[1, 2, 3]]]], 
      <String, Object?>{
          'fields': <Object?>['name', 'phone', 'email', 'id'], 
          'limit': 10 
      }
    ]);
    print('Invoices: $invoices');
    // return invoices;
  }

  Future<void> getInvoicesLines() async {
    final uid = await authenticate();
    final invoicesLines = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/object'), 'execute_kw', [
      db, 
      uid, 
      password, 
      'account.move.line', 
      'search_read', 
      <List<Object?>>[<Object?>[<Object?>['id', 'in', <Object?>[1, 2, 3]]]], 
      <String, Object?>{
          'fields': <Object?>['name', 'phone', 'email', 'id'], 
          'limit': 10 
      }
    ]);
    print('Invoices Lines: $invoicesLines');
    // return invoicesLines;
  }

  Future<void> getStockMove() async {
    final uid = await authenticate();
    final stockMove = await xml_rpc.call(Uri.parse('${url}/xmlrpc/2/object'), 'execute_kw', [
      db, 
      uid, 
      password, 
      'stock.move', 
      'search_read', 
      <List<Object?>>[<Object?>[<Object?>['id', 'in', <Object?>[1, 2, 3]]]], 
      <String, Object?>{
          'fields': <Object?>[], 
          'limit': 10 
      }
    ]);
    print('Stock Move: $stockMove');
    // return stockMove;
  }
  
}

class OdooJsonService {
  final String url;
  final String db;
  final String username;
  final String password;

  OdooJsonService({required this.url, required this.db, required this.username, required this.password});

  Future<int> authenticate() async {
    final response = await http.post(
      Uri.parse('${url}/jsonrpc'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "common",
          "method": "authenticate",
          "args": [db, username, password, {}]
        },
        "id": 1
      }),
    );
    
    final data = jsonDecode(response.body);
    return data['result'];
  }

  Future<Map<String, dynamic>> getVersion() async {
    final response = await http.post(
      Uri.parse('${url}/jsonrpc'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "common",
          "method": "version",
          "args": []
        },
        "id": 1
      }),
    );
    
    return jsonDecode(response.body);
  }

  Future<List<dynamic>> getPartners() async {
    final uid = await authenticate();
    final response = await http.post(
      Uri.parse('${url}/jsonrpc'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "object",
          "method": "execute_kw",
          "args": [
            db,
            uid,
            password,
            "res.partner",
            "search_read",
            [[["id", "in", [1, 2, 3]]]],
            {
              "fields": ["name", "phone", "email", "id"],
              "limit": 10
            }
          ]
        },
        "id": 1
      }),
    );
    
    final data = jsonDecode(response.body);
    return data['result'] ?? [];
  }

  Future<List<dynamic>> getProductTemplates() async {
    final uid = await authenticate();
    final response = await http.post(
      Uri.parse('${url}/jsonrpc'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "object",
          "method": "execute_kw",
          "args": [
            db,
            uid,
            password,
            "product.template",
            "search_read",
            [[["id", "in", [1, 2, 3]]]],
            {
              "fields": [],
              "limit": 10
            }
          ]
        },
        "id": 1
      }),
    );
    
    final data = jsonDecode(response.body);
    return data['result'] ?? [];
  }

  Future<List<dynamic>> getProductProducts() async {
    final uid = await authenticate();
    final response = await http.post(
      Uri.parse('${url}/jsonrpc'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "object",
          "method": "execute_kw",
          "args": [
            db,
            uid,
            password,
            "product.product",
            "search_read",
            [[["id", "in", [1, 2, 3]]]],
            {
              "fields": [],
              "limit": 10
            }
          ]
        },
        "id": 1
      }),
    );
    
    final data = jsonDecode(response.body);
    return data['result'] ?? [];
  }

  Future<List<dynamic>> getSalesOrders() async {
    final uid = await authenticate();
    final response = await http.post(
      Uri.parse('${url}/jsonrpc'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "object",
          "method": "execute_kw",
          "args": [
            db,
            uid,
            password,
            "sale.order",
            "search_read",
            [[["id", "in", [1, 2, 3]]]],
            {
              "fields": ["name", "phone", "email", "id"],
              "limit": 10
            }
          ]
        },
        "id": 1
      }),
    );
    
    final data = jsonDecode(response.body);
    return data['result'] ?? [];
  }

  Future<List<dynamic>> getSalesOrderLines() async {
    final uid = await authenticate();
    final response = await http.post(
      Uri.parse('${url}/jsonrpc'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "object",
          "method": "execute_kw",
          "args": [
            db,
            uid,
            password,
            "sale.order.line",
            "search_read",
            [[["id", "in", [1, 2, 3]]]],
            {
              "fields": ["name", "phone", "email", "id"],
              "limit": 10
            }
          ]
        },
        "id": 1
      }),
    );
    
    final data = jsonDecode(response.body);
    return data['result'] ?? [];
  }

  Future<List<dynamic>> getInvoices() async {
    final uid = await authenticate();
    final response = await http.post(
      Uri.parse('${url}/jsonrpc'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "object",
          "method": "execute_kw",
          "args": [
            db,
            uid,
            password,
            "account.move",
            "search_read",
            [[["id", "in", [1, 2, 3]]]],
            {
              "fields": ["name", "phone", "email", "id"],
              "limit": 10
            }
          ]
        },
        "id": 1
      }),
    );
    
    final data = jsonDecode(response.body);
    return data['result'] ?? [];
  }

  Future<List<dynamic>> getInvoicesLines() async {
    final uid = await authenticate();
    final response = await http.post(
      Uri.parse('${url}/jsonrpc'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "object",
          "method": "execute_kw",
          "args": [
            db,
            uid,
            password,
            "account.move.line",
            "search_read",
            [[["id", "in", [1, 2, 3]]]],
            {
              "fields": ["name", "phone", "email", "id"],
              "limit": 10
            }
          ]
        },
        "id": 1
      }),
    );
    
    final data = jsonDecode(response.body);
    return data['result'] ?? [];
  }

  Future<List<dynamic>> getStockMove() async {
    final uid = await authenticate();
    final response = await http.post(
      Uri.parse('${url}/jsonrpc'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "jsonrpc": "2.0",
        "method": "call",
        "params": {
          "service": "object",
          "method": "execute_kw",
          "args": [
            db,
            uid,
            password,
            "stock.move",
            "search_read",
            [[["id", "in", [1, 2, 3]]]],
            {
              "fields": [],
              "limit": 10
            }
          ]
        },
        "id": 1
      }),
    );
    
    final data = jsonDecode(response.body);
    return data['result'] ?? [];
  }
}