import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'service/firestore_service.dart';
import 'auto_bill.dart';

class OrderBookScreen extends StatelessWidget {
  const OrderBookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = Provider.of<FirestoreService>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Order Book')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: firestoreService.getProducts('nearby_location'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading products'));
          }
          final products = snapshot.data ?? [];
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                title: Text(product['name']),
                subtitle: Text('Price: ₹${product['price']}'),
                trailing: IconButton(
                  icon: const Icon(Icons.add_shopping_cart),
                  onPressed: () {
                    // Add to cart logic
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD001',
      'customer': 'Retailer A',
      'items': [
        {'name': 'Paracetamol', 'qty': 5, 'price': 50},
        {'name': 'Laptop', 'qty': 1, 'price': 50000},
      ],
      'status': 'Pending'
    },
    {
      'orderId': 'ORD002',
      'customer': 'Retailer B',
      'items': [
        {'name': 'Mask', 'qty': 100, 'price': 10},
      ],
      'status': 'Pending'
    },
  ];

  void billFromOrder(Map<String, dynamic> order) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AutoBillScreen(order: order),
      ),
    );
  }

  void acceptOrder(int index) {
    setState(() {
      orders[index]['status'] = 'Accepted';
    });
  }

  void declineOrder(int index) {
    setState(() {
      orders[index]['status'] = 'Declined';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Book")),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text("${order['customer']}"),
              subtitle: Text("Items: ${order['items'].length} | Status: ${order['status']}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(Icons.check, color: Colors.green),
                      onPressed: () => acceptOrder(index)),
                  IconButton(
                      icon: Icon(Icons.close, color: Colors.red),
                      onPressed: () => declineOrder(index)),
                  IconButton(
                      icon: Icon(Icons.receipt),
                      onPressed: () => billFromOrder(order)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
