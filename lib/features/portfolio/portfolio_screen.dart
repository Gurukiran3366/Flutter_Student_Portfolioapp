import 'package:flutter/material.dart';
import 'package:robokalam_app/data/db/db_helper.dart';
import 'package:robokalam_app/data/models/portfolio_model.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _collegeController = TextEditingController();
  final _skillsController = TextEditingController();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final DBHelper dbHelper = DBHelper();

  List<Portfolio> portfolios = [];

  @override
  void initState() {
    super.initState();
    loadPortfolios();
  }

  Future<void> loadPortfolios() async {
    final data = await dbHelper.getAllPortfolios();
    setState(() {
      portfolios = data;
    });
  }

  Future<void> savePortfolio() async {
    if (_formKey.currentState!.validate()) {
      Portfolio portfolio = Portfolio(
        name: _nameController.text.trim(),
        college: _collegeController.text.trim(),
        skills: _skillsController.text.split(',').map((s) => s.trim()).toList(),
        projectTitle: _titleController.text.trim(),
        projectDescription: _descController.text.trim(),
      );

      await dbHelper.insertPortfolio(portfolio);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Portfolio Saved')),
      );

      _nameController.clear();
      _collegeController.clear();
      _skillsController.clear();
      _titleController.clear();
      _descController.clear();

      loadPortfolios();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _collegeController,
                    decoration: const InputDecoration(labelText: 'College'),
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _skillsController,
                    decoration: const InputDecoration(labelText: 'Skills (comma separated)'),
                    validator: (val) {
                      if (val == null || val.isEmpty) return 'Required';
                      final skills = val.split(',').map((s) => s.trim()).toList();
                      return skills.length < 3 ? 'Enter at least 3 skills' : null;
                    },
                  ),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Project Title'),
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  TextFormField(
                    controller: _descController,
                    decoration: const InputDecoration(labelText: 'Project Description'),
                    validator: (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(onPressed: savePortfolio, child: const Text('Save')),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text('Saved Portfolios', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: portfolios.length,
                itemBuilder: (context, index) {
                  final e = portfolios[index];
                  return Card(
                    child: ListTile(
                      title: Text(e.name),
                      subtitle: Text('${e.college} | ${e.projectTitle}'),
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
