import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({super.key});

  final List<Map<String, String>> addresses = const [
    {
      "title": "Home",
      "subtitle": "925 S Chugach St #APT 10, Alaska",
      "isDefault": "true"
    },
    {
      "title": "Office",
      "subtitle": "2438 6th Ave, Ketchikan, Alaska",
      "isDefault": "false"
    },
    {
      "title": "Apartment",
      "subtitle": "2551 Vista Dr #B301, Juneau, Alaska",
      "isDefault": "false"
    },
    {
      "title": "Parent’s House",
      "subtitle": "4821 Ridge Top Cir, Anchorage, Alaska",
      "isDefault": "false"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Address",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Saved Address",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: addresses.length,
                itemBuilder: (context, index) {
                  final address = addresses[index];
                  final isDefault = address["isDefault"] == "true";

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    color: Colors.grey[100],
                    child: ListTile(
                      leading: const Icon(Icons.location_on,
                          color: Colors.redAccent),
                      title: Row(
                        children: [
                          Text(address["title"]!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          if (isDefault) ...[
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                "Default",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 10),
                              ),
                            )
                          ]
                        ],
                      ),
                      subtitle: Text(address["subtitle"]!,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      onTap: () {},
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
