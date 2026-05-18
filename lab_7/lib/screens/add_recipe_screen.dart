import 'package:flutter/material.dart';
import '../models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({Key? key}) : super(key: key);

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _nameController = TextEditingController();
  final _cookTimeController = TextEditingController();
  final _servingsController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _ingredientController = TextEditingController();
  final _instructionController = TextEditingController();

  String _selectedCategory = 'Main Course';
  final List<String> _ingredients = [];
  final List<String> _instructions = [];

  final List<String> _categories = [
    'Main Course',
    'Italian',
    'Fast Food',
    'Salad',
    'Mexican',
    'Dessert',
    'Breakfast',
    'Soup',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _cookTimeController.dispose();
    _servingsController.dispose();
    _imageUrlController.dispose();
    _ingredientController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  void _addIngredient() {
    final text = _ingredientController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _ingredients.add(text);
        _ingredientController.clear();
      });
    }
  }

  void _addInstruction() {
    final text = _instructionController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _instructions.add(text);
        _instructionController.clear();
      });
    }
  }

  void _removeIngredient(int index) =>
      setState(() => _ingredients.removeAt(index));

  void _removeInstruction(int index) =>
      setState(() => _instructions.removeAt(index));

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_ingredients.isEmpty) {
      _showError('Please add at least one ingredient');
      return;
    }
    if (_instructions.isEmpty) {
      _showError('Please add at least one instruction');
      return;
    }

    final newRecipe = Recipe(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: _nameController.text.trim(),
      imageUrl: _imageUrlController.text.trim().isEmpty
          ? 'https://images.unsplash.com/photo-1546548970-71785318a17b?w=400'
          : _imageUrlController.text.trim(),
      category: _selectedCategory,
      cookTime: _cookTimeController.text.trim(),
      servings: _servingsController.text.trim(),
      ingredients: List.from(_ingredients),
      instructions: List.from(_instructions),
    );

    Navigator.pop(context, newRecipe);
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE53935),
        title: const Text(
          '✨ Add New Recipe',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton.icon(
            onPressed: _submitForm,
            icon: const Icon(Icons.check, color: Colors.white),
            label: const Text('Save',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // ─── Basic Info Section ─────────────────────────
            _SectionCard(
              title: 'Basic Information',
              icon: Icons.info_outline,
              children: [
                // Recipe Name
                _buildField(
                  controller: _nameController,
                  label: 'Recipe Name',
                  hint: 'e.g. Chicken Biryani',
                  icon: Icons.restaurant_menu,
                  validator: (v) => (v == null || v.trim().isEmpty)
                      ? 'Recipe name is required'
                      : v.trim().length < 3
                          ? 'Name must be at least 3 characters'
                          : null,
                ),
                const SizedBox(height: 14),

                // Category Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: _inputDecoration('Category', Icons.category_outlined),
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (v) => setState(() => _selectedCategory = v!),
                ),
                const SizedBox(height: 14),

                // Cook Time & Servings in row
                Row(
                  children: [
                    Expanded(
                      child: _buildField(
                        controller: _cookTimeController,
                        label: 'Cook Time',
                        hint: 'e.g. 30 min',
                        icon: Icons.timer_outlined,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Required'
                            : null,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildField(
                        controller: _servingsController,
                        label: 'Servings',
                        hint: 'e.g. 4',
                        icon: Icons.people_outline,
                        keyboardType: TextInputType.number,
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Required'
                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // Image URL (optional)
                _buildField(
                  controller: _imageUrlController,
                  label: 'Image URL (optional)',
                  hint: 'https://...',
                  icon: Icons.image_outlined,
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ─── Ingredients Section ────────────────────────
            _SectionCard(
              title: 'Ingredients',
              icon: Icons.egg_alt_outlined,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _ingredientController,
                        decoration: _inputDecoration(
                            'Add ingredient', Icons.add_circle_outline),
                        onFieldSubmitted: (_) => _addIngredient(),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                      ),
                      onPressed: _addIngredient,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
                if (_ingredients.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Center(
                      child: Text('No ingredients added yet',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ),
                  ),
                ...(_ingredients.asMap().entries.map((entry) => Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3F3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red.shade100),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${entry.key + 1}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(entry.value,
                                  style: const TextStyle(fontSize: 14))),
                          IconButton(
                            icon: const Icon(Icons.close,
                                size: 18, color: Colors.red),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => _removeIngredient(entry.key),
                          ),
                        ],
                      ),
                    ))),
              ],
            ),
            const SizedBox(height: 16),

            // ─── Instructions Section ───────────────────────
            _SectionCard(
              title: 'Instructions',
              icon: Icons.format_list_numbered_rounded,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _instructionController,
                        maxLines: 2,
                        decoration: _inputDecoration(
                            'Add step', Icons.format_list_numbered),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                      ),
                      onPressed: _addInstruction,
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
                if (_instructions.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Center(
                      child: Text('No steps added yet',
                          style: TextStyle(color: Colors.grey, fontSize: 13)),
                    ),
                  ),
                ...(_instructions.asMap().entries.map((entry) => Container(
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3F3),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red.shade100),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE53935),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                'Step ${entry.key + 1}',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                              child: Text(entry.value,
                                  style: const TextStyle(fontSize: 13))),
                          IconButton(
                            icon: const Icon(Icons.close,
                                size: 18, color: Colors.red),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => _removeInstruction(entry.key),
                          ),
                        ],
                      ),
                    ))),
              ],
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE53935),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                icon: const Icon(Icons.save_alt, color: Colors.white),
                label: const Text(
                  'Save Recipe',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: _submitForm,
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, size: 20),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: _inputDecoration(label, icon).copyWith(hintText: hint),
      validator: validator,
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                Icon(icon, color: const Color(0xFFE53935), size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE53935),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}