import 'odooClient.dart';

class OdooExampleUsage {
  static const String url = "https://demo.csit-ksa.com/";
  static const String db = "demo";
  static const String username = "admin";
  static const String password = "123";

  // Example 1: Basic JSON-RPC usage
  static Future<void> basicJsonRpcExample() async {
    print('=== Basic JSON-RPC Example ===');
    
    final odooJson = OdooJsonService(
      url: url, 
      db: db, 
      username: username, 
      password: password
    );

    try {
      // Get Odoo version
      final version = await odooJson.getVersion();
      print('Odoo Version: ${version['result']}');

      // Get partners (customers/suppliers)
      final partners = await odooJson.getPartners();
      print('Found ${partners.length} partners');
      
      for (var partner in partners) {
        print('- ${partner['name']} (ID: ${partner['id']})');
      }

    } catch (e) {
      print('Error: $e');
    }
  }

  // Example 2: Product management
  static Future<void> productManagementExample() async {
    print('\n=== Product Management Example ===');
    
    final odooJson = OdooJsonService(
      url: url, 
      db: db, 
      username: username, 
      password: password
    );

    try {
      // Get product templates (main products)
      final templates = await odooJson.getProductTemplates();
      print('Found ${templates.length} product templates');

      // Get product variants
      final variants = await odooJson.getProductProducts();
      print('Found ${variants.length} product variants');

    } catch (e) {
      print('Error: $e');
    }
  }

  // Example 3: Sales management
  static Future<void> salesManagementExample() async {
    print('\n=== Sales Management Example ===');
    
    final odooJson = OdooJsonService(
      url: url, 
      db: db, 
      username: username, 
      password: password
    );

    try {
      // Get sales orders
      final orders = await odooJson.getSalesOrders();
      print('Found ${orders.length} sales orders');

      // Get sales order lines
      final orderLines = await odooJson.getSalesOrderLines();
      print('Found ${orderLines.length} sales order lines');

    } catch (e) {
      print('Error: $e');
    }
  }

  // Example 4: Accounting
  static Future<void> accountingExample() async {
    print('\n=== Accounting Example ===');
    
    final odooJson = OdooJsonService(
      url: url, 
      db: db, 
      username: username, 
      password: password
    );

    try {
      // Get invoices
      final invoices = await odooJson.getInvoices();
      print('Found ${invoices.length} invoices');

      // Get invoice lines
      final invoiceLines = await odooJson.getInvoicesLines();
      print('Found ${invoiceLines.length} invoice lines');

    } catch (e) {
      print('Error: $e');
    }
  }

  // Example 5: Inventory management
  static Future<void> inventoryExample() async {
    print('\n=== Inventory Management Example ===');
    
    final odooJson = OdooJsonService(
      url: url, 
      db: db, 
      username: username, 
      password: password
    );

    try {
      // Get stock moves
      final stockMoves = await odooJson.getStockMove();
      print('Found ${stockMoves.length} stock moves');

    } catch (e) {
      print('Error: $e');
    }
  }

  // Example 6: XML-RPC vs JSON-RPC comparison
  static Future<void> comparisonExample() async {
    print('\n=== XML-RPC vs JSON-RPC Comparison ===');
    
    final odooJson = OdooJsonService(url: url, db: db, username: username, password: password);
    final odooXml = OdooService(url: url, db: db, username: username, password: password);

    try {
      print('Testing JSON-RPC...');
      final startTime = DateTime.now();
      final jsonPartners = await odooJson.getPartners();
      final jsonDuration = DateTime.now().difference(startTime);
      print('JSON-RPC: ${jsonPartners.length} partners in ${jsonDuration.inMilliseconds}ms');

      print('Testing XML-RPC...');
      final startTime2 = DateTime.now();
      await odooXml.getPartners();
      final xmlDuration = DateTime.now().difference(startTime2);
      print('XML-RPC: completed in ${xmlDuration.inMilliseconds}ms');

    } catch (e) {
      print('Error: $e');
    }
  }

  // Example 7: Error handling
  static Future<void> errorHandlingExample() async {
    print('\n=== Error Handling Example ===');
    
    // Test with wrong credentials
    final odooJson = OdooJsonService(
      url: url, 
      db: db, 
      username: "wrong_user", 
      password: "wrong_password"
    );

    try {
      final partners = await odooJson.getPartners();
      print('Unexpected success: ${partners.length} partners');
    } catch (e) {
      print('Expected error caught: $e');
    }
  }

  // Run all examples
  static Future<void> runAllExamples() async {
    await basicJsonRpcExample();
    await productManagementExample();
    await salesManagementExample();
    await accountingExample();
    await inventoryExample();
    await comparisonExample();
    await errorHandlingExample();
  }
}

// Usage in main.dart:
// 
// import 'example_usage.dart';
// 
// void main() async {
//   // Run all examples
//   await OdooExampleUsage.runAllExamples();
//   
//   // Or run specific examples
//   await OdooExampleUsage.basicJsonRpcExample();
//   await OdooExampleUsage.productManagementExample();
// } 