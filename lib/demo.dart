class _TradingTabState extends State<TradingTab> {
  // ... (other existing code)

  Timer? _timer;
  int _start = 0;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_timer != null && _timer!.isActive)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Time left: $_start seconds'),
          ),
        // ... (rest of your code)
      ],
    );
  }
}

ElevatedButton(
  onPressed: () {
    setState(() {
      _start = time * 60; // Assuming 'time' is in minutes, convert to seconds
    });
    startTimer();
    // Add your Call button logic here
  },
  // ... (rest of your code)
),

Widget build(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_timer != null && _timer!.isActive)
              Text("Time Left: $_start"),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Demo Account',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      // ... (rest of your code)
    ],
  );
}

