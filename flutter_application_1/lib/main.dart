import 'package:flutter/material.dart';

void main() {
  runApp(const BinarioApp());
}

class BinarioApp extends StatefulWidget {
  const BinarioApp({super.key});

  @override
  State<BinarioApp> createState() => _BinarioAppState();
}

class _BinarioAppState extends State<BinarioApp> {
  bool isDarkMode = true;
  int _currentIndex = 2;

  final TextEditingController _controller = TextEditingController();
  String resultado = '';

  void convertirABinario() {
    setState(() {
      int numero = int.parse(_controller.text);
      resultado = numero.toRadixString(2);
    });
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return _editorView();
      case 1:
        return _debugView();
      case 2:
        return _binarioView();
      case 3:
        return _settingsView();
      default:
        return _binarioView();
    }
  }

  Widget _editorView() {
    return _binarioView();
  }

  Widget _debugView() {
    return const Center(
      child: Text(
        "DEBUGGER\n(No implementado)",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _settingsView() {
    return const Center(
      child: Text(
        "SETTINGS\n(Ajustes futuros)",
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.grey),
      ),
    );
  }

  Widget _binarioView() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "DECIMAL → BINARIO",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color:
                    isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 10),
                ],
              ),
              child: Column(
                children: [
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    maxLines: null,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      color: isDarkMode
                          ? Colors.white70
                          : Colors.black87,
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Ingresa un número decimal',
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    resultado.isEmpty
                        ? 'Resultado binario aparecerá aquí'
                        : 'Binario: $resultado',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 16,
                      color: isDarkMode
                          ? Colors.redAccent
                          : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE53935),
                padding: const EdgeInsets.symmetric(
                    horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: convertirABinario,
              child: const Text(
                "CONVERTIR",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor:
            isDarkMode ? const Color(0xFF121212) : const Color(0xFFF5F5F5),

        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              Image.asset(
                'assets/logo/binario_logo.png',
                height: 32,
              ),
              const SizedBox(width: 10),
              Text(
                'BINARIO',
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          actions: [
            Row(
              children: [
                const Text(
                  "Dark / Light",
                  style:
                      TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Switch(
                  value: isDarkMode,
                  activeThumbColor: const Color(0xFFE53935),
                  onChanged: (value) {
                    setState(() => isDarkMode = value);
                  },
                ),
              ],
            ),
          ],
        ),

        body: _buildBody(),

        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFFE53935),
          unselectedItemColor: Colors.grey,
          backgroundColor:
              isDarkMode ? Colors.black : Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.code), label: "EDITOR"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bug_report), label: "DEBUG"),
            BottomNavigationBarItem(
                icon: Icon(Icons.calculate), label: "BINARIO"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "SETTINGS"),
          ],
        ),
      ),
    );
  }
}

