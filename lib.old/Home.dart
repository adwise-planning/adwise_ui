import 'package:flutter/material.dart';
import 'providers.dart'; // Import the providers.dart file
import 'services.dart'; // Import the extracted categories data

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final category = services[index];
            return Column(
              children: [
                ExpansionTile(
                  leading: const Icon(Icons.category, color: Colors.blue),
                  title: Text(
                    category['title']! as String,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  children: (category['subcategories'] as List).map((subcategory) {
                    return ExpansionTile(
                      leading: const Icon(Icons.subdirectory_arrow_right, color: Colors.green),
                      title: Text(
                        subcategory['title']! as String,
                        style: const TextStyle(fontSize: 16),
                      ),
                      children: (subcategory['items'] as List).map((item) {
                        return ListTile(
                          leading: const Icon(Icons.arrow_right, color: Colors.orange),
                          title: Text(item as String),
                          onTap: () {
                            if (item == 'Therapy Sessions') {
                              // Navigate to the Providers page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Providers(category: category.toString(),subcategory: subcategory.toString())
                                ),
                              );
                            } else {
                              // Show a message for other items
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Selected: $item')),
                              );
                            }
                          },
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
                const Divider(), // Adds visual separation between categories
              ],
            );
          },
        ),
      ),
    );
  }
}
