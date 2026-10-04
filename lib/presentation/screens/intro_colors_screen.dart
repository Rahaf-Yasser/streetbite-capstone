import 'package:flutter/material.dart';

class IntroColorsScreen extends StatelessWidget {
  const IntroColorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> colorsData = [
      {
        'name': 'Primary',
        'hex': '#006D3D',
        'code': 'colorScheme.primary',
        'colorValue': '0xff006d3d',
      },
      {
        'name': 'Primary Container',
        'hex': '#00C874',
        'code': 'colorScheme.primaryContainer',
        'colorValue': '0xff00c874',
      },
      {
        'name': 'Secondary',
        'hex': '#50625C',
        'code': 'colorScheme.secondary',
        'colorValue': '0xff50625c',
      },
      {
        'name': 'Surface (Bg)',
        'hex': '#FCF8F8',
        'code': 'colorScheme.surface',
        'colorValue': '0xfffcf8f8',
      },
      {
        'name': 'Error',
        'hex': '#9F3F37',
        'code': 'colorScheme.error',
        'colorValue': '0xff9f3f37',
      },
      {
        'name': 'Yellow (Brand)',
        'hex': '#FFA800',
        'code': 'MaterialTheme.yellow.value',
        'colorValue': '0xffffa800',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('StreetBite - Design System'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Project Color Palette',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Use these properties in your widgets:',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const Divider(height: 24),
                Expanded(
                  child: ListView.separated(
                    itemCount: colorsData.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final colorItem = colorsData[index];
                      return _ColorRowItem(
                        name: colorItem['name']!,
                        hex: colorItem['hex']!,
                        code: colorItem['code']!,
                        colorValue: Color(int.parse(colorItem['colorValue']!)),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColorRowItem extends StatelessWidget {
  final String name;
  final String hex;
  final String code;
  final Color colorValue;

  const _ColorRowItem({
    required this.name,
    required this.hex,
    required this.code,
    required this.colorValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: colorValue,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Hex: $hex',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'Theme.of(context).$code',
                  style: const TextStyle(
                    fontSize: 13,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
