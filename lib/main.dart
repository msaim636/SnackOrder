import 'package:flutter/material.dart';

// ignore: camel_case_types
class SnackItems {
  final String name;
  final double price;

  SnackItems({required this.name, required this.price});
}

final List<SnackItems> snacks = [
  SnackItems(name: 'Chocolate', price: 100.3),
  SnackItems(name: 'Coke', price: 54.2),
  SnackItems(name: 'Chips', price: 20.7),
  SnackItems(name: 'Candy Bar', price: 3.5),
];

final List<SnackItems> cart = [];

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xffFFF6B7), Color(0xffF6416C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(padding: EdgeInsets.all(10), child: child),
      ),
    );
  }
}

void main() {
  runApp(OrderSnacks());
}

class OrderSnacks extends StatelessWidget {
  const OrderSnacks({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/order_screen': (context) => SnackList(),
        '/cart_screen': (context) => CartScreen(),
        '/checkout_screen': (context) => CheckOutScreen(),
        '/confirmation_screen': (context) => ConfirmationScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Order Your Snacks'))),
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(Icons.fastfood_rounded, size: 80),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/order_screen');
                },
                child: Text(
                  'Click Here to Order Your Snacks',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SnackList extends StatefulWidget {
  const SnackList({super.key});

  @override
  State<SnackList> createState() => _SnackListState();
}

class _SnackListState extends State<SnackList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Title(color: Colors.black, child: Text('Snacks List')),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/cart_screen');
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ],
        ),
      ),
      body: GradientBackground(
        child: ListView.builder(
          itemCount: snacks.length,
          itemBuilder: (context, index) {
            final snack = snacks[index];

            return Card(
              color: Colors.white.withOpacity(0.8),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ListTile(
                title: Text(snack.name),
                subtitle: Text('Rs:${snack.price}'),
                trailing: TextButton(
                  onPressed: () {
                    cart.add(snack);
                  },
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalBill() {
    double total = 0;
    for (var item in cart) {
      total += item.price;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Title(color: Colors.black, child: Text('Your Cart'))],
        ),
      ),
      body: GradientBackground(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  final cartItems = cart[index];

                  return Card(
                    color: Colors.white.withOpacity(0.8),
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: ListTile(
                      title: Text(cartItems.name),
                      subtitle: Text('Rs:${cartItems.price}'),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            cart.remove(cartItems);
                          });
                        },
                        icon: Icon(Icons.cancel_outlined),
                      ),
                    ),
                  );
                },
              ),
            ),

            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Bill",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Rs. ${totalBill()}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/checkout_screen');
              },
              child: Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Check Out'))),
      body: GradientBackground(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hint: Text('Enter Your Name'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Name';
                      }
                      if (RegExp(r'\d').hasMatch(value)) {
                        return 'Numbers are not allowed';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10),

                  TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      hint: Text('Enter Your Phone Number'),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Your Phone Number';
                      }
                      if (value == null || value.length != 11) {
                        return 'Enter Correct Phone Number With required 11 Digits';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        print('Form is Valid');
                      } else {
                        print('Form is Invalid');
                      }
                      Navigator.pushNamed(
                        context,
                        '/confirmation_screen',
                        arguments: {
                          'name': nameController.text,
                          'phone': phoneController.text,
                        },
                      );
                    },
                    child: Text('Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final name = args['name'] ?? '';
    final phone = args['phone'] ?? '';

    double total = 0;
    for (var items in cart) {
      total += items.price;
    }
    return Scaffold(
      body: GradientBackground(
        child: Center(
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 80),
                  const SizedBox(height: 20),
                  const Text(
                    "Order Confirmed!",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text("Name: $name"),
                  Text("Phone: $phone"),
                  Text("Total Bill: Rs. $total"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
