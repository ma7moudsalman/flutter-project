import 'package:flutter/material.dart';
import '../models/product.dart';

class MyCartPage extends StatefulWidget {
  final List<Product> cartItems;

  const MyCartPage({super.key, required this.cartItems});

  @override
  State<MyCartPage> createState() => _MyCartPageState();
}

class _MyCartPageState extends State<MyCartPage> {
  double shippingFee = 80.0;

  @override
  void initState() {
    super.initState();

    for (var item in widget.cartItems) {
      item.quantity = item.quantity == 0 ? 1 : item.quantity;
    }
  }

  void _increaseQuantity(Product product) {
    setState(() {
      product.quantity++;
    });
  }

  void _decreaseQuantity(Product product) {
    setState(() {
      if (product.quantity > 1) {
        product.quantity--;
      }
    });
  }

  void _removeItem(Product product) {
    setState(() {
      widget.cartItems.remove(product);
    });
  }

  double get subtotal {
    return widget.cartItems.fold(
      0,
          (sum, item) => sum + (item.price * item.quantity),
    );
  }

  double get total => subtotal + shippingFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: widget.cartItems.isEmpty
                ? const Center(child: Text("Your cart is empty"))
                : ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final product = widget.cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: ListTile(
                    leading: Image.network(product.image, width: 50, height: 50),
                    title: Text(product.title),
                    subtitle: Text("\$${product.price}"),
                    trailing: SizedBox(
                      width: 120,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _decreaseQuantity(product),
                          ),
                          Text("${product.quantity}"),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => _increaseQuantity(product),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeItem(product),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildSummaryRow("Sub-total", subtotal),
                _buildSummaryRow("VAT (%)", 0),
                _buildSummaryRow("Shipping fee", shippingFee),
                const Divider(),
                _buildSummaryRow("Total", total, isBold: true),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Checkout clicked")),
                      );
                    },
                    child: const Text(
                      "Go To Checkout →",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 2) Navigator.pushNamed(context, '/account');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, double value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            "\$ ${value.toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 16 : 14,
            ),
          ),
        ],
      ),
    );
  }
}
