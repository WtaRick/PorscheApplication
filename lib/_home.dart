import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; //serve per le icone dei social
// ignore: depend_on_referenced_packages
import 'package:url_launcher/url_launcher.dart';

class Home {
  final Uri urlInstagram = Uri.parse('https://www.instagram.com/porsche/');
  final Uri urlFacebook = Uri.parse('https://www.facebook.com/porsche/');
  final Uri urlTwitter = Uri.parse('https://twitter.com/porsche');
  final Uri urlLinkedin = Uri.parse('https://www.linkedin.com/company/porsche/');

  Widget visualizzaHome() {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 80.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Home",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                  shadows: [
                    Shadow(
                      offset: const Offset(2.0, 2.0),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.grey[900]!],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              // Contenuto della Home
              _buildHistorySection(),
              _buildSocialMediaLinks(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "La Nostra Storia",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            "Porsche è un marchio automobilistico tedesco fondato nel 1931 da Ferdinand Porsche. "
            "Siamo famosi per la produzione di auto sportive, SUV e berline di alta qualità. "
            "La prima auto prodotta è stata la Porsche 64 nel 1939. "
            "Nel corso degli anni, abbiamo sviluppato una reputazione per l'eccellenza ingegneristica "
            "e il design iconico, con modelli leggendari come la Porsche 911, Boxster, e Cayenne.",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Widget _buildSocialMediaLinks() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Seguici sui Social Media",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              socialIcon('Instagram', urlInstagram, FontAwesomeIcons.instagram, Colors.purple),
              socialIcon('Facebook', urlFacebook, FontAwesomeIcons.facebook, Colors.blue),
              socialIcon('Twitter', urlTwitter, FontAwesomeIcons.twitter, Colors.lightBlue),
              socialIcon('LinkedIn', urlLinkedin, FontAwesomeIcons.linkedin, Colors.blue[700]!),
            ],
          ),
        ],
      ),
    );
  }

  Widget socialIcon(String name, Uri url, IconData icon, Color color) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: Column(
        children: [
          Icon(icon, color: color, size: 40.0),
          const SizedBox(height: 8.0),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
