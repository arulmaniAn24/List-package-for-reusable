import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: SkeletonAppBar(),
      ),
      body: SkeletonLoadingScreen(),
      bottomNavigationBar: SkeletonBottomNavigationBar(),
    );
  }
}

class SkeletonAppBar extends StatelessWidget {
  const SkeletonAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: AppBar(
        title: Container(
          width: 150,
          height: 20,
          color: Colors.white,
        ),
        actions: [
          Container(
            width: 50,
            height: 20,
            margin: const EdgeInsets.only(right: 16),
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class SkeletonLoadingScreen extends StatelessWidget {
  const SkeletonLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 100,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class SkeletonBottomNavigationBar extends StatelessWidget {
  const SkeletonBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const Icon(Icons.home),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const Icon(Icons.search),
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: const Icon(Icons.person),
          ),
          label: '',
        ),
      ],
    );
  }
}
