import 'package:flutter/material.dart';
import 'verificacao_email.dart';
import 'Alterar_Senha.dart';

class SegurancaPage extends StatelessWidget {
  const SegurancaPage({super.key});

  static const Color primaryGreen = Color(0xFF028C3E);

  void _mostrarSnackBar(BuildContext context, String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem)),
    );
  }

  void _confirmarExclusao(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar exclusão'),
          content: const Text(
            'Tem certeza que deseja excluir sua conta? Esta ação não poderá ser desfeita.',
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: const Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _mostrarSnackBar(context, 'Conta excluída com sucesso.');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segurança e Conta'),
        backgroundColor: primaryGreen,
        leading: const BackButton(color: Colors.white),
        centerTitle: true,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            _buildOptionButton(
              context,
              text: 'Alterar senha',
              icon: Icons.lock_outline,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AlterarSenhaPage()),
              ),
            ),
            const SizedBox(height: 10),
            _buildOptionButton(
              context,
              text: 'Verificação de e-mail',
              icon: Icons.email_outlined,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const VerificacaoEmailPage()),
              ),
            ),
            const SizedBox(height: 10),
            _buildOptionButton(
              context,
              text: 'Excluir conta',
              icon: Icons.delete_outline,
              textColor: const Color.fromARGB(255, 255, 255, 255),
              iconColor: const Color.fromARGB(255, 255, 255, 255),
              onTap: () => _confirmarExclusao(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(
    BuildContext context, {
    required String text,
    required IconData icon,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: iconColor ?? Colors.white),
        label: Text(
          text,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: iconColor == Colors.red ? Colors.red : primaryGreen,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        onPressed: onTap,
      ),
    );
  }
}
