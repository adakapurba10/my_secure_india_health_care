import 'package:flutter/material.dart';

class AutoBillScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  const AutoBillScreen({super.key, required this.order});

  double get total {
    return order['items']
        .fold(0, (sum, item) => sum + (item['price'] ?? 0) * (item['qty'] ?? 1));
  }

  void generateInvoice(BuildContext context) {
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Invoice generated!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bill for ${order['customer']}")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: order['items'].length,
                itemBuilder: (context, index) {
                  final item = order['items'][index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Qty: ${item['qty']}'),
                    trailing: Text('₹${(item['qty'] ?? 0) * (item['price'] ?? 0)}'),
                  );
                },
              ),
            ),
            const Divider(),
            Text(
              'Total: ₹$total',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => generateInvoice(context),
              child: const Text('Generate Invoice'),
            ),
          ],
        ),
      ),
    );
  }
}
