import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/constants.dart';
import '../home/widgets/carousel.dart';

class AboutUsScreen extends ConsumerStatefulWidget {
  const AboutUsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends ConsumerState<AboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 45),
                Image.asset("assets/prathaName.jpg"),
                const SizedBox(height: 10),
                Text("Established In 2001",
                    style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                const SizedBox(height: 10),
                const Text(
                    "F-143, Prem Nagar, Kopri Colony, Thane, Maharashtra, 400603",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                CarouselImages(imagesList: Constants.carouselImagesAboutUs),
                const SizedBox(height: 10),
                const Text(
                    "Pratha Samajik Sanstha is a dynamic NGO, formed by a group of professionals and social workers. It strives to deliver sustainable sanitation solutions by enhancing sanitation programmes and to motivate and help people residing in slums to create a clean, open-defecation free environment in their neighbourhood. It started its work in the year 2001 in Mumbai addressing the issue of sanitation by undertaking projects like Slum Sanitation Project supported by Municipal Corporation of Greater Mumbai. \n\nTo bring about change in the sanitation situation by developing the concerned model and system with active participation of concerned group/community to sustain the sanitation facility is the main objective of Pratha.\n",
                    textAlign: TextAlign.justify),
                const Text("Pratha works with the aim to\n",
                    textAlign: TextAlign.justify,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const Text(
                    "1] Create clean, healthy & open defecation free environment in the society.\n2] Create sustainable sanitation options for slum dwellers.\n3] Initiate a path of participatory development by motivating communities to contribute in their own development process.\n4] Bridge and lessen the gap between The Municipal Corporation and community so that the communities can avail these services provided by the Corporation\n\nSince the inception, Pratha has worked with the major objective of strengthening CBOs to take the ownership of operation and maintenance of the community toilet blocks and to run on the model of “Sustainability”.",
                    textAlign: TextAlign.justify),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade300,
                  ),
                  child: const Center(
                      child: Text("Chief Functionary",
                          style: TextStyle(color: Colors.white, fontSize: 18))),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Name:",
                              style: TextStyle(color: Colors.blue.shade700)),
                          const SizedBox(width: 10),
                          const Text("Mr. Anil Narayan Bhatia")
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Designation:",
                              style: TextStyle(color: Colors.blue.shade700)),
                          const SizedBox(width: 10),
                          const Text("CEO")
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Email:",
                              style: TextStyle(color: Colors.blue.shade700)),
                          const SizedBox(width: 10),
                          const Text("prathassthane@gmail.com")
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue.shade300,
                  ),
                  child: const Center(
                      child: Text("Contact",
                          style: TextStyle(color: Colors.white, fontSize: 18))),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 70),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Name:",
                              style: TextStyle(color: Colors.blue.shade700)),
                          const SizedBox(width: 10),
                          const Text("Aditi Milind Mulye")
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Designation:",
                              style: TextStyle(color: Colors.blue.shade700)),
                          const SizedBox(width: 10),
                          const Text("Programme Manager")
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Email:",
                              style: TextStyle(color: Colors.blue.shade700)),
                          const SizedBox(width: 10),
                          const Text("prathassthane@gmail.com")
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Phone:",
                              style: TextStyle(color: Colors.blue.shade700)),
                          const SizedBox(width: 10),
                          const Text("9619088814")
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Image.asset(
                        "assets/instagram.webp",
                        fit: BoxFit.fill,
                        // height: 220,
                        width: 40,
                      ),
                    ),
                    const SizedBox(width: 25),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Image.asset(
                        "assets/facebook.webp",
                        fit: BoxFit.fill,
                        // height: 220,
                        width: 40,
                      ),
                    ),
                    const SizedBox(width: 25),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Image.asset(
                        "assets/linkedIn.webp",
                        fit: BoxFit.fill,
                        // height: 220,
                        width: 40,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
