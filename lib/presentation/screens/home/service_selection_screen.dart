import 'package:Adwise/presentation/screens/chat/chat_screen.dart';
import 'package:flutter/material.dart';

class ServiceSelectionScreen extends StatelessWidget {
  final String userId;
  final String authToken;

  const ServiceSelectionScreen({
    super.key,
    required this.userId,
    required this.authToken,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
      body: SafeArea(
        child: Column(
          children: [
            _buildPromotionalBanner(),
            _buildSearchAndFavorites(),
            _buildServiceGrid(context),
            _buildAroundYouSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionalBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue.shade900,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              "Get your life a breeze, get services on the go →",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(Icons.celebration, color: Colors.white),
        ],
      ),
    );
  }

  Widget _buildSearchAndFavorites() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search services",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuickAction(Icons.star, "Favorite Services"),
              _buildQuickAction(Icons.schedule, "Now"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Colors.blue.shade900),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildServiceGrid(BuildContext context) {
    List<Map<String, dynamic>> services = [
      {'title': 'Health & Wellness', 'icon': Icons.health_and_safety},
      {'title': 'Home Services', 'icon': Icons.cleaning_services},
      {'title': 'Education', 'icon': Icons.school},
      {'title': 'Technology', 'icon': Icons.computer},
      {'title': 'Beauty & Fashion', 'icon': Icons.brush},
      {'title': 'Travel', 'icon': Icons.flight},
    ];
    
    print("Service screen authToken: ${authToken}, userId: ${userId}");

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return GestureDetector(
                  onTap: () {
                      // Navigate to the chat screen with a selected provider
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            chatId: context.toString(), // Replace with actual provider ID
                            recipientName: "Service screen for : ${services[index]['title']} authToken: ${authToken}, userId: ${userId}", // Replace with actual provider name
                            authToken: authToken,
                            userId: userId,
                          ),
                        ),
                      );
                    },
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue.shade100,
                  child: Icon(services[index]['icon'], size: 30, color: Colors.blue.shade900),
                ),
                const SizedBox(height: 8),
                Text(services[index]['title'], textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAroundYouSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Around You",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Container(
            height: 150,
            color: Colors.grey.shade300,
            child: Center(child: Text("Map View Placeholder")),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.blue.shade900,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: "Activity"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
      ],
    );
  }
}
