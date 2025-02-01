import 'chatscreen.dart';
import 'package:flutter/material.dart';

class User {
  final String name;
  final String username;
  final String email;
  final String gender;
  final int age;
  final String profilePhoto;

  User({
    required this.name,
    required this.username,
    required this.email,
    required this.gender,
    required this.age,
    required this.profilePhoto,
  });
}

class Providers extends StatelessWidget {
  final String category;
  final String subcategory;

  const Providers({super.key, required this.category, required this.subcategory});

  @override
  Widget build(BuildContext context) {
    // Example data for providers
    final List<User> _Users = [
    User(
      name: 'Gen Z',
      username: 'gen.z@gmail.com',
      email: 'gen.z@gmail.com',
      gender: 'Female',
      age: 25,
      profilePhoto: 'https://fastly.picsum.photos/id/1/200/300.jpg?hmac=jH5bDkLr6Tgy3oAg5khKCHeunZMHq0ehBZr6vGifPLY',
    ),
    User(
      name: 'Gen Y',
      username: 'gen.y@gmail.com',
      email: 'gen.y@gmail.com',
      gender: 'Female',
      age: 25,
      profilePhoto: 'https://fastly.picsum.photos/id/1/200/300.jpg?hmac=jH5bDkLr6Tgy3oAg5khKCHeunZMHq0ehBZr6vGifPLY',
    ),
    User(
      name: 'Alice Johnson',
      username: 'alice.johnson@gmail.com',
      email: 'alice.johnson@gmail.com',
      gender: 'Female',
      age: 25,
      profilePhoto: 'https://fastly.picsum.photos/id/1/200/300.jpg?hmac=jH5bDkLr6Tgy3oAg5khKCHeunZMHq0ehBZr6vGifPLY',
    ),
    User(
      name: 'Bob Smith',
      username: 'bob.smith@gmail.com',
      email: 'bob.smith@gmail.com',
      gender: 'Male',
      age: 30,
      profilePhoto: 'https://fastly.picsum.photos/id/866/200/300.jpg?hmac=rcadCENKh4rD6MAp6V_ma-AyWv641M4iiOpe1RyFHeI',
    ),
    User(
      name: 'Carol Miller',
      username: 'carol.miller@gmail.com',
      email: 'carol.miller@gmail.com',
      gender: 'Female',
      age: 28,
      profilePhoto: 'https://fastly.picsum.photos/id/133/200/300.jpg?grayscale&hmac=zxOutR8A3kXMtKlxnWYci59vGBsOnQG0rh5jWFUgYaU',
    ),
    User(
      name: 'David Brown',
      username: 'david.brown@gmail.com',
      email: 'david.brown@gmail.com',
      gender: 'Male',
      age: 35,
      profilePhoto: 'https://fastly.picsum.photos/id/10/2500/1667.jpg?hmac=J04WWC_ebchx3WwzbM-Z4_KC_LeLBWr5LZMaAkWkF68',
    ),
  ];
    return Scaffold(
      appBar: AppBar(
        title: Text('$subcategory Providers'),
      ),
      body: ListView.builder(
        itemCount: _Users.length,
        itemBuilder: (context, index) {
          final provider = _Users[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(provider.profilePhoto),
              ),
              title: Text(provider.name),
              subtitle: Text(
                'Gender: ${provider.gender}, Age: ${provider.age}',
              ),
              
              onTap: () {
                if (provider.name == 'Gen Y') {
                  // Navigate to ChatScreen when Gen Y is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(username: 'gen.z@gmail.com',status: 'online', 
                      authToken:'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6Imdlbi56QGdtYWlsLmNvbSIsImRldmljZV9pZCI6IngwXzJLMjJQUyIsImVtYWlsIjoiZ2VuLnpAZ21haWwuY29tIiwiZXhwIjoxNzM4MjEwNzM5LCJpYXQiOjE3MzgxMjQ1ODB9.nCIMh9hJRt9Cnij4lWCcxqZhY7Xp41uUETDSJscs6Vc')
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Contacting ${provider.name}')),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
