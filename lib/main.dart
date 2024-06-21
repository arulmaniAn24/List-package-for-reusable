import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Task 1'),
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                // Add your onPressed logic here
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Add your onPressed logic here
                },
              ),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // Add your onPressed logic here
                },
              ),
            ],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.green],
                ),
              ),
            ),
            elevation: 5.0,
            centerTitle: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text("Dashboard"),
                        ),
                        Icon(Icons.circle,size: 8,color: Colors.grey,),
                        TextButton(
                          onPressed: () {},
                          child: Text("User"),

                        ),
                        Icon(Icons.circle,size: 8,color: Colors.grey,),
                        SizedBox(width: 23),
                        Text("Arjun"),

                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/acd.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage:
                              AssetImage('assets/images/pe2.jpg'),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Arjun',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Developer')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    TabBar(
                      isScrollable: true, // This makes the tabs scrollable
                      tabs: [
                        Tab(
                          icon: Icon(Icons.perm_identity_outlined),
                          text: "Profile",
                        ),
                        Tab(
                          icon: Icon(Icons.add_reaction_rounded),
                          text: 'Follow',
                        ),
                        Tab(
                          icon: Icon(Icons.group),
                          text: "Friends",
                        ),
                        Tab(
                          icon: Icon(Icons.photo),
                          text: "Gallery",
                        ),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ProfilePage(),
                          FollowPage(),
                          FriendsPage(),
                          GalleryPage(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "1,947",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Followers"),
                      ],
                    ),
                  ),
                  height: 89,
                  width: 178,
                  color: Colors.grey[200],
                ),
                SizedBox(width: 2),
                Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "2000",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("Following"),
                      ],
                    ),
                  ),
                  height: 89,
                  width: 178,
                  color: Colors.grey[200],
                ),
              ],
            ),SizedBox(height: 20,),
            Container(color: Colors.grey[300],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                SizedBox(height: 20),
                Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Text(
                  '  I love sugar plum I love oat cake. Sweet roll caramels I love jujubes. Topping cake wafer..',
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(width: 8),
                    Text("Live at Andorra"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.email),
                    SizedBox(width: 8),
                    Text("ashlynn_ohara62@gmail.com"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.card_giftcard),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        "Data Analyst at Gleichner, Mueller and Tromp",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.wallet_giftcard),
                    SizedBox(width: 8),
                    Text('Studied at Nikolaus - Leuschke'),
                  ],
                ),]
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class FollowPage extends StatefulWidget {
  @override
  _FollowPageState createState() => _FollowPageState();
}

class _FollowPageState extends State<FollowPage> {
  // Dummy data for followers
  final List<Map<String, String>> followers = [
    {'name': 'Alice'},
    {'name': 'Bob', 'image': 'assets/images/fl.jpg'},
    {'name': 'Charlie', 'image': 'assets/images/pe2.jpg'},
    {'name': 'David', 'image': 'assets/images/fl.jpg'},
  ];

  // To keep track of which followers are followed
  final List<bool> isFollowed = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Followers'),
      ),
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, index) {
          String? imagePath = followers[index]['image'];
          String name = followers[index]['name']!;

          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.blue, // Change to your preferred color
                child: imagePath != null
                    ? ClipOval(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 60,
                    height: 60,
                  ),
                )
                    : Text(
                  name[0], // Display the first letter of the name
                  style: TextStyle(
                      fontSize: 24, color: Colors.white), // Adjust the text style
                ),
              ),
              title: Text(name),
              trailing: ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFollowed[index] = !isFollowed[index];
                  });
                },
                child: Text(isFollowed[index] ? 'Followed' : 'Follow'),
              ),
              onTap: () {
                // Handle tap
              },
            ),
          );
        },
      ),
    );
  }
}

class FriendsPage extends StatelessWidget {
  // Dummy data for friends
  final List<Map<String, String>> friends = [
    {
      'name': 'Jayvion Simon',
      'role': 'CEO',
      'image': 'assets/images/fl.jpg'
    },
    {
      'name': 'Lucian Obrien',
      'role': 'Designer',
      'image': 'assets/images/acd.jpg'
    },
    // Add more friends as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friends'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add your onPressed logic here
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  hintText: 'Search friends...',
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: friends.length,
                itemBuilder: (context, index) {
                  String? imagePath = friends[index]['image'];

                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              PopupMenuButton<String>(
                                onSelected: (String result) {
                                  // Handle the selected option
                                },
                                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                  const PopupMenuItem<String>(
                                    value: 'option1',
                                    child: Text('Option 1'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'option2',
                                    child: Text('Option 2'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundImage: imagePath != null
                                ? AssetImage(imagePath)
                                : AssetImage('assets/images/pe2.jpg'), // Default image if not provided
                            radius: 30,
                          ),
                          SizedBox(height: 8),
                          Text(
                            friends[index]['name']!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            friends[index]['role']!,
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.facebook, size: 20),
                              SizedBox(width: 8),
                              Icon(Icons.icecream, size: 20),
                              SizedBox(width: 8),
                              Icon(Icons.icecream, size: 20),
                              SizedBox(width: 8),
                              Icon(Icons.link, size: 20),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class GalleryPage extends StatelessWidget {
  // Dummy data for followers
  final List<Map<String, String>> followers = [
    {'name': 'Alice', 'image': 'assets/images/acd.jpg',},
    {'name': 'Bob', 'image': 'assets/images/pe2.jpg'},
    {'name': 'Charlie', 'image': 'assets/images/pe2.jpg'},
    {'name': 'David', 'image': 'assets/images/acd.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gallery'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: followers.length,
        itemBuilder: (context, index) {
          String? imagePath = followers[index]['image'];

          // Only show followers with images
          if (imagePath == null) {
            return Container(); // Empty container if no image
          }

          return Card(
            elevation: 5,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // Rounded corners
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
