# Odoo Integration with Flutter

This project demonstrates how to integrate Odoo ERP with Flutter using both XML-RPC and JSON-RPC protocols.

## 🚀 Features

- **Dual Protocol Support**: Both XML-RPC and JSON-RPC implementations
- **JSON Responses**: Clean JSON data instead of XML
- **Comprehensive API Coverage**: Partners, Products, Sales, Accounting, Inventory
- **Postman Collection**: Ready-to-use API testing collection
- **Error Handling**: Proper error handling and validation
- **Example Usage**: Complete examples for all methods

## 📁 Project Structure

```
lib/
├── main.dart                 # Main Flutter app with test button
├── odooClient.dart          # Both XML-RPC and JSON-RPC services
└── example_usage.dart       # Comprehensive usage examples

odoo_postman_collection.json # Postman collection for API testing
```

## 🛠️ Setup

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Configure Odoo Connection

Update the connection details in your code:

```dart
final url = "https://your-odoo-instance.com/";
final db = "your_database";
final username = "your_username";
final password = "your_password";
```

## 📱 Flutter Usage

### Basic Usage

```dart
import 'odooClient.dart';

// Create JSON-RPC service instance
final odooJson = OdooJsonService(
  url: "https://demo.csit-ksa.com/",
  db: "demo",
  username: "admin",
  password: "123"
);

// Get Odoo version
final version = await odooJson.getVersion();
print('Odoo Version: ${version['result']}');

// Get partners
final partners = await odooJson.getPartners();
print('Found ${partners.length} partners');
```

### Available Methods

#### Common Operations
- `getVersion()` - Get Odoo version
- `authenticate()` - Authenticate user

#### Partners (Customers/Suppliers)
- `getPartners()` - Get partner records

#### Products
- `getProductTemplates()` - Get main product templates
- `getProductProducts()` - Get product variants

#### Sales
- `getSalesOrders()` - Get sales orders
- `getSalesOrderLines()` - Get sales order lines

#### Accounting
- `getInvoices()` - Get invoices
- `getInvoicesLines()` - Get invoice lines

#### Inventory
- `getStockMove()` - Get stock movements

## 🧪 Testing with Postman

### 1. Import Collection

1. Open Postman
2. Click "Import"
3. Select the `odoo_postman_collection.json` file
4. The collection will be imported with all requests

### 2. Configure Variables

Update the collection variables:
- `base_url`: Your Odoo instance URL
- `database`: Your database name
- `username`: Your username
- `password`: Your password
- `uid`: Leave empty (will be filled after authentication)

### 3. Testing Flow

1. **Get Version** - Test basic connectivity
2. **Authenticate** - Get your UID
3. **Copy UID** from response and update the `uid` variable
4. **Test other endpoints** - All other requests will work

### 4. Example Response

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": [
    {
      "id": 1,
      "name": "Demo Partner",
      "phone": "+1234567890",
      "email": "demo@example.com"
    }
  ]
}
```

## 🔧 API Reference

### JSON-RPC Endpoint
```
POST https://your-odoo-instance.com/jsonrpc
Content-Type: application/json
```

### Request Format
```json
{
  "jsonrpc": "2.0",
  "method": "call",
  "params": {
    "service": "common|object",
    "method": "method_name",
    "args": [...]
  },
  "id": 1
}
```

### Common Methods

#### Version
```json
{
  "jsonrpc": "2.0",
  "method": "call",
  "params": {
    "service": "common",
    "method": "version",
    "args": []
  },
  "id": 1
}
```

#### Authenticate
```json
{
  "jsonrpc": "2.0",
  "method": "call",
  "params": {
    "service": "common",
    "method": "authenticate",
    "args": ["database", "username", "password", {}]
  },
  "id": 1
}
```

#### Search and Read
```json
{
  "jsonrpc": "2.0",
  "method": "call",
  "params": {
    "service": "object",
    "method": "execute_kw",
    "args": [
      "database",
      uid,
      "password",
      "model.name",
      "search_read",
      [[["field", "operator", "value"]]],
      {
        "fields": ["field1", "field2"],
        "limit": 10
      }
    ]
  },
  "id": 1
}
```

## 🎯 Example Usage

### Run All Examples

```dart
import 'example_usage.dart';

void main() async {
  await OdooExampleUsage.runAllExamples();
}
```

### Run Specific Examples

```dart
// Basic usage
await OdooExampleUsage.basicJsonRpcExample();

// Product management
await OdooExampleUsage.productManagementExample();

// Sales management
await OdooExampleUsage.salesManagementExample();
```

## 🔍 Troubleshooting

### Common Issues

1. **Authentication Failed**
   - Check username/password
   - Verify database name
   - Ensure user has proper permissions

2. **Connection Error**
   - Verify Odoo URL
   - Check network connectivity
   - Ensure Odoo instance is running

3. **Permission Denied**
   - Check user access rights
   - Verify model permissions
   - Contact Odoo administrator

### Debug Mode

Enable debug logging:

```dart
try {
  final result = await odooJson.getPartners();
  print('Success: $result');
} catch (e) {
  print('Error: $e');
  print('Stack trace: ${StackTrace.current}');
}
```

## 📊 Performance Comparison

| Protocol | Pros | Cons |
|----------|------|------|
| **JSON-RPC** | ✅ JSON responses<br>✅ Better performance<br>✅ Easier debugging | ❌ Requires http package |
| **XML-RPC** | ✅ Built-in support<br>✅ No additional dependencies | ❌ XML responses<br>❌ Slower parsing |

## 🔐 Security Notes

- Store credentials securely
- Use environment variables for production
- Implement proper error handling
- Validate all inputs
- Use HTTPS for production

## 📝 License

This project is for educational purposes. Please ensure you have proper authorization to access the Odoo instance.

## 🤝 Contributing

Feel free to submit issues and enhancement requests! 