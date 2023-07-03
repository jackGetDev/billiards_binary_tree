import 'package:flutter/material.dart';

class TreeNode {
  int value;
  TreeNode? left;
  TreeNode? right;

  TreeNode(this.value);
}

class BinaryTree {
  TreeNode? root;

  BinaryTree() : root = null {
    final node1 = TreeNode(1);
    final node2 = TreeNode(2);
    final node3 = TreeNode(3);
    final node4 = TreeNode(4);
    final node5 = TreeNode(5);
    final node6 = TreeNode(6);
    final node7 = TreeNode(7);
    final node8 = TreeNode(8);
    final node9 = TreeNode(9);
    final node10 = TreeNode(10);
    final node11 = TreeNode(11);
    final node12 = TreeNode(12);
    final node13 = TreeNode(13);
    final node14 = TreeNode(14);
    final node15 = TreeNode(15);

    root = node1;
    node1.left = node2;
    node1.right = node3;
    node2.left = node4;
    node2.right = node5;
    node3.left = node6;
    node3.right = node7;
    node4.left = node8;
    node4.right = node9;
    node5.left = node10;
    node5.right = node11;
    node6.left = node12;
    node6.right = node13;
    node7.left = node14;
    node7.right = node15;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final BinaryTree tree;

  MyApp() : tree = BinaryTree();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Binary Tree Billiards Visualization'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Binary Tree:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                buildBinaryTreeWidget(tree.root),
                const SizedBox(height: 32),
                const Text(
                  'In-order Traversal:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                buildTraversalWidget(tree.root, TraversalType.inOrder),
                const SizedBox(height: 32),
                const Text(
                  'Pre-order Traversal:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                buildTraversalWidget(tree.root, TraversalType.preOrder),
                const SizedBox(height: 32),
                const Text(
                  'Post-order Traversal:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                buildTraversalWidget(tree.root, TraversalType.postOrder),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBinaryTreeWidget(TreeNode? node) {
    if (node == null) {
      return SizedBox.shrink();
    }

    return Column(
      children: [
        buildCircleAvatar(node.value),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (node.left != null) buildVerticalLine(),
            SizedBox(width: 32),
            if (node.right != null) buildVerticalLine(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (node.left != null) buildBinaryTreeWidget(node.left),
            SizedBox(width: 32),
            if (node.right != null) buildBinaryTreeWidget(node.right),
          ],
        ),
      ],
    );
  }

  Widget buildVerticalLine() {
    return Container(
      height: 40,
      width: 2,
      color: Colors.grey,
    );
  }

  Widget buildCircleAvatar(int value) {
    BallColor ballColor = getBallColor(value);
    Color color = getColorFromBallColor(ballColor);
    bool isStriped = ballColor.toString().contains('Striped');

    return Stack(
      alignment: Alignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
        ),
        if (isStriped)
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 60,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        CircleAvatar(
          radius: 10,
          backgroundColor: Colors.white,
          child: Text(
            value.toString(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTraversalWidget(TreeNode? node, TraversalType type) {
    final traversal = performTraversal(node, type);
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: traversal
          .map(
            (value) => buildCircleAvatar(value),
          )
          .toList(),
    );
  }

  List<int> performTraversal(TreeNode? node, TraversalType type) {
    if (node == null) {
      return [];
    }

    switch (type) {
      case TraversalType.inOrder:
        return inOrderTraversal(node);
      case TraversalType.preOrder:
        return preOrderTraversal(node);
      case TraversalType.postOrder:
        return postOrderTraversal(node);
    }
  }

  List<int> inOrderTraversal(TreeNode node) {
    final List<int> traversal = [];
    _inOrderTraversalHelper(node, traversal);
    return traversal;
  }

  void _inOrderTraversalHelper(TreeNode? node, List<int> traversal) {
    if (node == null) {
      return;
    }

    _inOrderTraversalHelper(node.left, traversal);
    traversal.add(node.value);
    _inOrderTraversalHelper(node.right, traversal);
  }

  List<int> preOrderTraversal(TreeNode node) {
    final List<int> traversal = [];
    _preOrderTraversalHelper(node, traversal);
    return traversal;
  }

  void _preOrderTraversalHelper(TreeNode? node, List<int> traversal) {
    if (node == null) {
      return;
    }

    traversal.add(node.value);
    _preOrderTraversalHelper(node.left, traversal);
    _preOrderTraversalHelper(node.right, traversal);
  }

  List<int> postOrderTraversal(TreeNode node) {
    final List<int> traversal = [];
    _postOrderTraversalHelper(node, traversal);
    return traversal;
  }

  void _postOrderTraversalHelper(TreeNode? node, List<int> traversal) {
    if (node == null) {
      return;
    }

    _postOrderTraversalHelper(node.left, traversal);
    _postOrderTraversalHelper(node.right, traversal);
    traversal.add(node.value);
  }
}

enum BallColor {
  YellowSolid,
  RedSolid,
  BlueSolid,
  PurpleSolid,
  OrangeSolid,
  GreenSolid,
  BurgundySolid,
  BlackSolid,
  YellowStriped,
  BlueStriped,
  RedStriped,
  PurpleStriped,
  OrangeStriped,
  GreenStriped,
  BurgundyStriped,
}

BallColor getBallColor(int value) {
  switch (value) {
    case 1:
      return BallColor.YellowSolid;
    case 2:
      return BallColor.BlueSolid;
    case 3:
      return BallColor.RedSolid;
    case 4:
      return BallColor.PurpleSolid;
    case 5:
      return BallColor.OrangeSolid;
    case 6:
      return BallColor.GreenSolid;
    case 7:
      return BallColor.BurgundySolid;
    case 8:
      return BallColor.BlackSolid;
    case 9:
      return BallColor.YellowStriped;
    case 10:
      return BallColor.BlueStriped;
    case 11:
      return BallColor.RedStriped;
    case 12:
      return BallColor.PurpleStriped;
    case 13:
      return BallColor.OrangeStriped;
    case 14:
      return BallColor.GreenStriped;
    case 15:
      return BallColor.BurgundyStriped;
    default:
      return BallColor.YellowSolid;
  }
}

Color getColorFromBallColor(BallColor ballColor) {
  switch (ballColor) {
    case BallColor.YellowSolid:
      return Colors.yellow;
    case BallColor.RedSolid:
      return Colors.red;
    case BallColor.BlueSolid:
      return Colors.blue;
    case BallColor.PurpleSolid:
      return Colors.purple;
    case BallColor.OrangeSolid:
      return Colors.orange;
    case BallColor.GreenSolid:
      return Colors.green;
    case BallColor.BurgundySolid:
      return Color(0xFF8B0000); // Burgundy
    case BallColor.BlackSolid:
      return Colors.black;
    case BallColor.YellowStriped:
      return Colors.yellow;
    case BallColor.BlueStriped:
      return Colors.blue;
    case BallColor.RedStriped:
      return Colors.red;
    case BallColor.PurpleStriped:
      return Colors.purple;
    case BallColor.OrangeStriped:
      return Colors.orange;
    case BallColor.GreenStriped:
      return Colors.green;
    case BallColor.BurgundyStriped:
      return Color(0xFF8B0000); // Burgundy
    default:
      return Colors.yellow;
  }
}

enum TraversalType {
  inOrder,
  preOrder,
  postOrder,
}
