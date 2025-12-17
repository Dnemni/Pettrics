import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _step = 0;

  // Owner profile
  final _ownerNameController = TextEditingController();
  final _ownerEmailController = TextEditingController();

  // Pet profile
  final _petNameController = TextEditingController();
  final _petSpeciesController = TextEditingController();
  final _petBreedController = TextEditingController();
  final _petAgeController = TextEditingController();
  final _petWeightController = TextEditingController();
  final _petActivityLevelController = TextEditingController();
  final _petDietController = TextEditingController();
  final _petAllergiesController = TextEditingController();
  // TODO: Add photo upload

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Onboarding'),
        automaticallyImplyLeading: false,
      ),
      body: Stepper(
        currentStep: _step,
        onStepContinue: _nextStep,
        onStepCancel: _prevStep,
        steps: [
          Step(
            title: const Text('Owner Profile'),
            content: Column(
              children: [
                TextField(
                  controller: _ownerNameController,
                  decoration: const InputDecoration(labelText: 'Your Name'),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _ownerEmailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                ),
              ],
            ),
            isActive: _step == 0,
          ),
          Step(
            title: const Text('Pet Profile'),
            content: Column(
              children: [
                TextField(
                  controller: _petNameController,
                  decoration: const InputDecoration(labelText: 'Pet Name'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _petSpeciesController,
                  decoration: const InputDecoration(labelText: 'Species'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _petBreedController,
                  decoration: const InputDecoration(labelText: 'Breed'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _petAgeController,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _petWeightController,
                  decoration: const InputDecoration(labelText: 'Weight'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _petActivityLevelController,
                  decoration:
                      const InputDecoration(labelText: 'Activity Level'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _petDietController,
                  decoration:
                      const InputDecoration(labelText: 'Dietary Preferences'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _petAllergiesController,
                  decoration: const InputDecoration(labelText: 'Allergies'),
                ),
                // TODO: Add photo upload widget
              ],
            ),
            isActive: _step == 1,
          ),
          Step(
            title: const Text('Finish'),
            content: Column(
              children: [
                const Text('Setup complete!'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _finish,
                  child: const Text('Go to Dashboard'),
                ),
              ],
            ),
            isActive: _step == 2,
          ),
        ],
      ),
    );
  }

  void _nextStep() {
    if (_step < 2) {
      setState(() {
        _step++;
      });
    }
  }

  void _prevStep() {
    if (_step > 0) {
      setState(() {
        _step--;
      });
    }
  }

  void _finish() {
    // TODO: Save onboarding data and navigate to dashboard
    Navigator.of(context).pushReplacementNamed('/dashboard');
  }
}
