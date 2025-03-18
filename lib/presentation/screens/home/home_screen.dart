import 'package:adwise/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // To make the body go behind AppBar
      appBar: AppBar(
        title: Text(
          AppConstants.appName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28, // Make the title more prominent
            shadows: [ // Subtle shadow for depth
              Shadow(
                blurRadius: 3.0,
                color: Colors.black26,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent, // Make AppBar transparent
        elevation: 0, // Remove AppBar shadow for cleaner look
        flexibleSpace: Container( // Add a gradient background
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppConstants.primaryColor,
                AppConstants.primaryColorShade, // A slightly darker shade
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white), // White search icon
            tooltip: 'Search chats', // Accessibility
            onPressed: () {
              // TO DO: Implement search functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search functionality coming soon!')),
              );
            },
          ),
          PopupMenuButton<String>( // Specify type for clarity
            icon: const Icon(Icons.more_vert, color: Colors.white), // White menu icon
            tooltip: 'More options', // Accessibility
            color: Colors.white, // Popup menu background color
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'settings',
                child: Text('Settings'),
              ),
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('Profile'), // Added Profile option here too
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
            ],
            onSelected: (String value) { // Specify type for clarity
              if (value == 'logout') {
                // TO DO: Implement logout functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout functionality coming soon!')),
                );
              } else if (value == 'settings') {
                // TO DO: Implement settings functionality
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings functionality coming soon!')),
                );
              } else if (value == 'profile') {
                // TO DO: Implement profile functionality
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile functionality coming soon!')),
                );
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white, // White indicator line
          indicatorWeight: 3.0, // Make indicator line thicker
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70, // Slightly less opaque unselected labels
          labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500), // More stylish label style
          unselectedLabelStyle: const TextStyle(fontSize: 16), // Slightly smaller unselected labels
          tabs: const [
            Tab(icon: Icon(Icons.chat_bubble_outline, size: 28), text: 'Chats'), // Icons for tabs
            Tab(icon: Icon(Icons.fiber_manual_record, size: 28), text: 'Status'),
            Tab(icon: Icon(Icons.call_outlined, size: 28), text: 'Calls'),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration( // Background gradient for the body
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.primaryColorShade, // Start with the darker shade
              Colors.white, // Fade into white
            ],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: const [
            ChatsTab(),
            StatusTab(),
            CallsTab(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TO DO: Implement new chat functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('New chat functionality coming soon!')),
          );
        },
        backgroundColor: AppConstants.accentColor,
        elevation: 3.0, // Add a bit of elevation
        tooltip: 'Start new chat', // Accessibility
        child: const Icon(Icons.chat, color: Colors.white, size: 28), // White chat icon, larger
      ),
      drawer: Drawer(
        backgroundColor: Colors.white.withOpacity(0.95), // Slightly transparent drawer background
        elevation: 2.0, // Subtle drawer elevation
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: AppConstants.primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Adwise',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32, // Larger Drawer title
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your Digital Canvas', // Subtitle for drawer
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person_outline, color: AppConstants.primaryColor), // Themed icons
              title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.w500)), // Style text
              onTap: () {
                // TO DO: Navigate to profile screen
                context.pop(); // Close drawer after navigation (optional)
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile screen coming soon!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: AppConstants.primaryColor),
              title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                // TO DO: Navigate to settings screen
                context.pop(); // Close drawer
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings screen coming soon!')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: AppConstants.primaryColor),
              title: const Text('Logout', style: TextStyle(fontWeight: FontWeight.w500)),
              onTap: () {
                // TO DO: Implement logout functionality
                context.pop(); // Close drawer
                 ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logout functionality coming soon!')),
                );
              },
            ),
            const Divider(color: Colors.grey, indent: 16.0, endIndent: 16.0), // Visual separator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'App Version 1.0.0', // Example version info
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder widgets for tabs - Enhanced with styling
class ChatsTab extends StatelessWidget {
  const ChatsTab({super.key});
  final mock_user = 'gen.y@gmail.com';
  final mock_name = 'Gen Y';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0), // Add some padding to the list
      itemCount: 5, // Mock data - increased for visual example
      itemBuilder: (context, index) {
        return Card( // Use Card for a lifted effect and visual separation
          elevation: 2.0, // Subtle card elevation
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0), // Card margins
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), // Rounded card corners
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Padding inside ListTile
            leading: const CircleAvatar(
              radius: 30, // Larger avatar
              backgroundImage: AssetImage('default_avatar.png'),
            ),
            title: Text(mock_name, style: const TextStyle(fontWeight: FontWeight.bold)), // Bold name
            subtitle: Text('Hey! How are you doing today?', overflow: TextOverflow.ellipsis,), // Example last message, ellipsis for long text
            trailing: const Text('10:00 AM', style: TextStyle(color: Colors.grey)), // Grey time
            onTap: () {
              context.push('/chat/$mock_user', extra: 'User ${index + 1}');
            },
            tileColor: Colors.white.withOpacity(0.8), // Slightly transparent white tile
          ),
        );
      },
    );
  }
}

class StatusTab extends StatelessWidget {
  const StatusTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder( // Using GridView for a status grid layout
      padding: const EdgeInsets.all(10.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 columns for status grid
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 0.8, // Adjust aspect ratio for status cards
      ),
      itemCount: 10, // More mock status items
      itemBuilder: (context, index) {
        return Card(
          elevation: 3.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: InkWell( // InkWell for tap effect on status cards
            onTap: () {
              // TO DO: Navigate to status screen
               ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('View status ${index + 1} coming soon!')),
                );
            },
            borderRadius: BorderRadius.circular(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40, // Larger status avatar
                  backgroundImage: AssetImage('default_avatar.png'),
                ),
                const SizedBox(height: 10),
                Text('Status ${index + 1}', style: const TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        );
      },
    );
  }
}

class CallsTab extends StatelessWidget {
  const CallsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      itemCount: 7, // More mock call items
      itemBuilder: (context, index) {
        return Card(
          elevation: 1.5, // Slightly less elevation for call cards
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0), // Smaller vertical margin
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: const CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage('default_avatar.png'),
            ),
            title: Text('Call with User ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Row( // Row for call details
              children: [
                const Icon(Icons.call_received, color: Colors.green, size: 16), // Example call type icon
                const SizedBox(width: 5),
                Text('Incoming, Yesterday', style: TextStyle(color: Colors.grey[600])), // More descriptive subtitle
              ],
            ),
            trailing: IconButton( // IconButton for call action
              icon: const Icon(Icons.call, color: AppConstants.accentColor),
              tooltip: 'Make voice call',
              onPressed: () {
                // TO DO: Implement call functionality
                 ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Call functionality with User ${index + 1} coming soon!')),
                );
              },
            ),
            onTap: () {
              // TO DO: Implement call details screen
               ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Call details for User ${index + 1} coming soon!')),
                );
            },
            tileColor: Colors.white.withOpacity(0.7), // Even more transparent tile for calls
          ),
        );
      },
    );
  }
}