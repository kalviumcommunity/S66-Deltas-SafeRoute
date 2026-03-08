import 'package:flutter/material.dart';
import '../../core/responsive.dart';
import '../../widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTablet = Responsive.isTablet(context);
    final contentWidth = Responsive.contentWidth(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Safe Route'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: const Icon(Icons.person_outline_rounded),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentWidth),
            child: Padding(
              padding: Responsive.screenPadding(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TweenAnimationBuilder<double>(
                    duration: const Duration(milliseconds: 400),
                    tween: Tween(begin: 0, end: 1),
                    curve: Curves.easeOut,
                    builder: (context, opacity, child) {
                      return Opacity(opacity: opacity, child: child);
                    },
                    child: const Text(
                      'Discover Safe Routes',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 1.15,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Local experiences, safety scores, and trusted community paths.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 18),
                  GridView.count(
                    crossAxisCount: isTablet ? 4 : 2,
                    shrinkWrap: true,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    childAspectRatio: isTablet ? 1.6 : 1.5,
                    children: const [
                      _FeatureCard(
                        title: 'Explore',
                        icon: Icons.explore_rounded,
                        color: Color(0xFFDFF4F4),
                      ),
                      _FeatureCard(
                        title: 'Add Route',
                        icon: Icons.add_road_rounded,
                        color: Color(0xFFE6EEF8),
                      ),
                      _FeatureCard(
                        title: 'Heatmap',
                        icon: Icons.public_rounded,
                        color: Color(0xFFF0E8F8),
                      ),
                      _FeatureCard(
                        title: 'Alerts',
                        icon: Icons.shield_rounded,
                        color: Color(0xFFFCEEDC),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const SectionTitle(text: 'Trending Routes'),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 280 + index * 80),
                          tween: Tween(begin: 20, end: 0),
                          curve: Curves.easeOutCubic,
                          builder: (context, offset, child) {
                            return Transform.translate(
                              offset: Offset(0, offset),
                              child: child,
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 6,
                              ),
                              leading: CircleAvatar(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                child: const Icon(Icons.directions_run_rounded),
                              ),
                              title: Text('River Loop ${index + 1}'),
                              subtitle: const Text('Safety: 4.0/5 | 4.3 km'),
                              trailing: const Icon(Icons.chevron_right_rounded),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _FeatureCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 26),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
