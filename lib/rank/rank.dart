import 'package:flutter/material.dart';

class Rank extends StatelessWidget {
  const Rank({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: ranks.length,
        itemBuilder: (context, index) {
          final rank = ranks[index];
          return RankCard(
            rankName: rank['name']!,
            rankIcon: rank['icon']!,
            isUnlocked: rank['unlocked'] as bool,
          );
        },
      ),
    );
  }
}

class RankCard extends StatelessWidget {
  final String rankName;
  final IconData rankIcon;
  final bool isUnlocked;

  const RankCard({
    super.key,
    required this.rankName,
    required this.rankIcon,
    required this.isUnlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isUnlocked ? Colors.deepPurple : Colors.grey,
          child: Icon(
            rankIcon,
            color: isUnlocked ? Colors.white : Colors.grey[400],
          ),
        ),
        title: Text(
          rankName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isUnlocked ? Colors.white : Colors.grey,
          ),
        ),
        subtitle: isUnlocked
            ? const Text(
                'Unlocked',
                style: TextStyle(color: Colors.green),
              )
            : const Text(
                'Locked',
                style: TextStyle(color: Colors.red),
              ),
        trailing: Icon(
          isUnlocked ? Icons.check_circle : Icons.lock,
          color: isUnlocked ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}

// Mock data for ranks
final List<Map<String, dynamic>> ranks = [
  {'name': 'Iron', 'icon': Icons.shield, 'unlocked': true},
  {'name': 'Bronze', 'icon': Icons.shield, 'unlocked': true},
  {'name': 'Silver', 'icon': Icons.shield, 'unlocked': true},
  {'name': 'Gold', 'icon': Icons.stars, 'unlocked': true},
  {'name': 'Platinum', 'icon': Icons.diamond, 'unlocked': false},
  {'name': 'Diamond', 'icon': Icons.diamond, 'unlocked': false},
  {'name': 'Immortal', 'icon': Icons.flash_on, 'unlocked': false},
  {'name': 'Radiant', 'icon': Icons.wb_sunny, 'unlocked': false},
];
