import 'dart:collection';
import 'package:flutter/material.dart';

enum BallColor {
  Yellow,
  Blue,
  Red,
  Purple,
  Orange,
  Green,
  AppleRed,
  Black,
  White,
}

class TreeNode {
  int value;
  List<TreeNode> children;

  TreeNode(this.value) : children = [];
}

class Tree {
  TreeNode root;

  Tree() : root = TreeNode(1) {
    final node2 = TreeNode(2);
    final node3 = TreeNode(3);
    final node4 = TreeNode(4);
    final node5 = TreeNode(5);
    final node6 = TreeNode(6);
    final node7 = TreeNode(7);
    final node8 = TreeNode(8);
    final node9 = TreeNode(9);

    root.children.addAll([node2, node3]);
    node2.children.addAll([node4, node5]);
    node3.children.addAll([node6, node7]);
    node6.children.add(node8);
    node7.children.add(node9);
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Tree tree;

  MyApp() : tree = Tree();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Billiards Tree Visualization'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tree:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                buildBinaryTreeWidget(tree.root),
                const SizedBox(height: 32),
                const Text(
                  'BFS Traversal:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                buildBfsTraversalWidget(tree),
                const SizedBox(height: 32),
                const Text(
                  'DFS Traversal:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                buildDfsTraversalWidget(tree),
              ],
            ),
          ),
        ),
      ),
    );
  }

 Widget buildBinaryTreeWidget(TreeNode? node) {
  if (node == null) {
    return const SizedBox.shrink();
  }

  return Column(
    children: [
      buildNodeWidget(node),
      const SizedBox(height: 16),
      if (node.children.isNotEmpty)
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 32,
          runSpacing: 16,
          children: [
            ...node.children.map(buildBinaryTreeWidget).toList(),
          ],
        ),
    ],
  );
}

  Widget buildBfsTraversalWidget(Tree tree) {
    final traversal = bfsTraversal(tree.root);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: traversal
          .map(
            (value) => buildNodeWidget(findNode(tree.root, value)!),
          )
          .toList(),
    );
  }

  List<int> bfsTraversal(TreeNode root) {
    final List<int> traversal = [];
    final Set<TreeNode> visited = Set();
    final Queue<TreeNode> queue = Queue();

    queue.add(root);

    while (queue.isNotEmpty) {
      final current = queue.removeFirst();
      if (!visited.contains(current)) {
        traversal.add(current.value);
        visited.add(current);

        for (final child in current.children) {
          queue.add(child);
        }
      }
    }

    return traversal;
  }

  Widget buildDfsTraversalWidget(Tree tree) {
    final traversal = dfsTraversal(tree.root);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: traversal
          .map(
            (value) => buildNodeWidget(findNode(tree.root, value)!),
          )
          .toList(),
    );
  }

  List<int> dfsTraversal(TreeNode root) {
    final List<int> traversal = [];
    final Set<TreeNode> visited = Set();
    final List<TreeNode> stack = [];

    stack.add(root);

    while (stack.isNotEmpty) {
      final current = stack.removeLast();
      if (!visited.contains(current)) {
        traversal.add(current.value);
        visited.add(current);

        for (final child in current.children.reversed) {
          if (!visited.contains(child)) {
            stack.add(child);
          }
        }
      }
    }

    return traversal;
  }

  Widget buildNodeWidget(TreeNode node) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: getColorFromBallColor(getBallColor(node.value)),
        ),
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.white,
          child: Text(
            node.value.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }

  BallColor getBallColor(int value) {
    switch (value) {
      case 1:
        return BallColor.Yellow;
      case 2:
        return BallColor.Blue;
      case 3:
        return BallColor.Red;
      case 4:
        return BallColor.Purple;
      case 5:
        return BallColor.Orange;
      case 6:
        return BallColor.Green;
      case 7:
        return BallColor.AppleRed;
      case 8:
        return BallColor.Black;
      case 9:
        return BallColor.White;
      default:
        return BallColor.White;
    }
  }

  Color getColorFromBallColor(BallColor ballColor) {
    switch (ballColor) {
      case BallColor.Yellow:
        return Colors.yellow;
      case BallColor.Blue:
        return Color.fromARGB(255, 6, 87, 153);
      case BallColor.Red:
        return const Color.fromARGB(255, 230, 44, 31);
      case BallColor.Purple:
        return Colors.purple;
      case BallColor.Orange:
        return Colors.orange;
      case BallColor.Green:
        return Colors.green;
      case BallColor.AppleRed:
        return Color(0xFF8B0000); // Apple Red
      case BallColor.Black:
        return Colors.black;
      case BallColor.White:
      default:
        return Color.fromARGB(255, 255, 191, 0);
    }
  }

  TreeNode? findNode(TreeNode? node, int value) {
    if (node == null) return null;
    if (node.value == value) return node;

    TreeNode? foundNode;
    for (final child in node.children) {
      foundNode = findNode(child, value);
      if (foundNode != null) break;
    }

    return foundNode;
  }
}
