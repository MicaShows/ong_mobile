import 'package:flutter/material.dart';

class InfoUsuarioPage extends StatefulWidget {
  const InfoUsuarioPage({super.key});

  @override
  State<InfoUsuarioPage> createState() => _InfoUsuarioPageState();
}

class _InfoUsuarioPageState extends State<InfoUsuarioPage> {
  // Avatar selecionado
  String _avatarSelecionado = 'images/avatarhomem1.jpg';

  // Controle do hover
  bool _isHovering = false;

  final List<String> _avatares = [
    'images/avatarhomem1.jpg',
    'images/avatarhomem2.jpg',
    'images/avatarhomem3.jpg',
    'images/avatarmulher1.jpg',
    'images/avatarmulher2.jpg',
    'images/avatarmulher3.jpg',
  ];

  // Controladores dos campos
  final TextEditingController nomeController =
      TextEditingController(text: 'Nome do Usuário');
  final TextEditingController emailController =
      TextEditingController(text: 'usuario@email.com');
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController cpfController = TextEditingController();
  final TextEditingController cepController = TextEditingController();
  final TextEditingController ruaController = TextEditingController();
  final TextEditingController numeroController = TextEditingController();
  final TextEditingController complementoController = TextEditingController();
  final TextEditingController cidadeController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();

  void _mostrarEscolhaDeAvatar() {
    showModalBottomSheet(
      context: context,
      builder: (context) => GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _avatares.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final avatar = _avatares[index];
          return GestureDetector(
            onTap: () {
              setState(() => _avatarSelecionado = avatar);
              Navigator.pop(context);
            },
            child: Image.asset(avatar),
          );
        },
      ),
    );
  }

  void _salvarInformacoes() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Informações salvas com sucesso')),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool enabled = true, TextInputType keyboardType = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.green[100],
          labelStyle: const TextStyle(color: Colors.black87),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.black54),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green[800],
        leading: const BackButton(color: Colors.white),
        title: const Text('ONGNET', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(_avatarSelecionado),
            ),
            const SizedBox(height: 10),
            MouseRegion(
              onEnter: (_) => setState(() => _isHovering = true),
              onExit: (_) => setState(() => _isHovering = false),
              child: GestureDetector(
                onTap: _mostrarEscolhaDeAvatar,
                child: Text(
                  'Editar Foto',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                    decoration: TextDecoration.underline,
                    shadows: _isHovering
                        ? [
                            Shadow(
                              offset: Offset(1.5, 1.5),
                              blurRadius: 3.0,
                              color: Colors.grey.withOpacity(0.6),
                            ),
                          ]
                        : [],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildTextField('Nome completo', nomeController, enabled: false),
            _buildTextField('E-mail', emailController, enabled: false),
            _buildTextField('Telefone', telefoneController,
                keyboardType: TextInputType.phone),
            _buildTextField('CPF (opcional)', cpfController,
                keyboardType: TextInputType.number),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            const Text('Endereço',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            _buildTextField('CEP', cepController,
                keyboardType: TextInputType.number),
            _buildTextField('Rua', ruaController),
            _buildTextField('Número', numeroController,
                keyboardType: TextInputType.number),
            _buildTextField('Complemento', complementoController),
            _buildTextField('Cidade', cidadeController),
            _buildTextField('Estado', estadoController),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: Colors.green[800]!),
                  ),
                ),
                onPressed: _salvarInformacoes,
                child: Text(
                  'Salvar',
                  style: TextStyle(fontSize: 16, color: Colors.green[800]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
