import 'package:flutter/material.dart';

class DoacaoPage extends StatefulWidget {
  final String nomeOng;

  const DoacaoPage({super.key, required this.nomeOng});

  @override
  State<DoacaoPage> createState() => _DoacaoPageState();
}

class _DoacaoPageState extends State<DoacaoPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _mensagemController = TextEditingController();
  String _formaPagamento = 'Pix';
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildQrCodePix() {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text('Escaneie o QR Code abaixo para doar via Pix:'),
        const SizedBox(height: 10),
        Center(
          child: Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5e/QR_Code_example.png/220px-QR_Code_example.png',
            height: 180,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Chave Pix: ongnet@doacoes.org',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fazer Doação'),
        backgroundColor: const Color(0xFF005BA5),
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem de topo decorativa
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'https://images.unsplash.com/photo-1607746882042-944635dfe10e?auto=format&fit=crop&w=800&q=80',
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Doar para:',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
              ),
              Text(
                widget.nomeOng,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF005BA5),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _valorController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Valor da doação (R\$)',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _formaPagamento,
                decoration: InputDecoration(
                  labelText: 'Forma de Pagamento',
                  prefixIcon: const Icon(Icons.payment),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: const [
                  DropdownMenuItem(value: 'Pix', child: Text('Pix')),
                  DropdownMenuItem(
                      value: 'Cartão de Crédito',
                      child: Text('Cartão de Crédito')),
                  DropdownMenuItem(value: 'Boleto', child: Text('Boleto')),
                ],
                onChanged: (value) {
                  setState(() {
                    _formaPagamento = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _mensagemController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Mensagem (opcional)',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              if (_formaPagamento == 'Pix') _buildQrCodePix(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Doação realizada com sucesso!')),
                    );
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.volunteer_activism),
                  label: const Text('Confirmar Doação'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: const Color(0xFF005BA5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
