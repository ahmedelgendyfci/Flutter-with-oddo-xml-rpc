import 'package:flutter/material.dart';
import 'odooClient.dart';

void main() async {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void callOdoo() async {
    final url = "https://demo.csit-ksa.com/";
    final db = "demo";
    final username = "admin";
    final password = "123";
    
    print('=== Testing Odoo Integration ===\n');
    
    // Option 1: Use JSON-RPC service (recommended for JSON responses)
    print('1. Testing JSON-RPC Service:');
    OdooJsonService odooJsonService = OdooJsonService(url: url, db: db, username: username, password: password);
    
    try {
      // Get version
      final version = await odooJsonService.getVersion();
      print('✅ Version: $version');
      
      // Get partners
      final partners = await odooJsonService.getPartners();
      print('✅ Partners: ${partners.length} records found');
      
      // Get product templates
      final products = await odooJsonService.getProductTemplates();
      print('✅ Products: ${products.length} records found');
      
      // Uncomment to test other methods
      // final productVariants = await odooJsonService.getProductProducts();
      // final salesOrders = await odooJsonService.getSalesOrders();
      // final salesOrderLines = await odooJsonService.getSalesOrderLines();
      // final invoices = await odooJsonService.getInvoices();
      // final invoiceLines = await odooJsonService.getInvoicesLines();
      // final stockMoves = await odooJsonService.getStockMove();
      
    } catch (e) {
      print('❌ JSON-RPC Error: $e');
    }
    
    print('\n2. Testing XML-RPC Service:');
    // Option 2: Use XML-RPC service (original implementation)
    OdooService odooService = OdooService(url: url, db: db, username: username, password: password);
    
    try {
      await odooService.getVersion();
      await odooService.getPartners();
      await odooService.getProductTemplates();
      print('✅ XML-RPC calls completed successfully');
    } catch (e) {
      print('❌ XML-RPC Error: $e');
    }
    
    print('\n=== Testing Complete ===');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: callOdoo,
          child: const Text('Get Data'),
        ),
      ),
    );
  }
}