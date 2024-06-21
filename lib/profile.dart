

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