import 'package:flutter/material.dart';
import 'package:todo_app/core/data/product_list.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({super.key});

  final List<ProductList> products = [
    ProductList(id: '1', productName: 'Product A', cost: 100),
    ProductList(id: '2', productName: 'Product B', cost: 200),
    ProductList(id: '3', productName: 'Product C', cost: 300),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return ListTile(
          title: Text(product.productName),
          subtitle: Text('Cost: \$${product.cost}'),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${product.productName} deleted')),
              );
            },
          ),
        );
      },
    );
  }
}
