import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Centered text added above the buttons
            Text(
              'Choisissez le type d\'alerte',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0), // Add some space between text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action for the first button
                    print('Button 1 pressed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.local_hospital, color: Colors.white, size: 35),
                      SizedBox(height: 5.0),
                      Text(
                        'Médicale',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150.0, 100.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.blue[600],
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Action for the second button
                    print('Button 2 pressed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.whatshot, color: Colors.white, size: 35),
                      SizedBox(height: 5.0),
                      Text(
                        'Incendie',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150.0, 100.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.orange[400],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action for the third button
                    print('Button 3 pressed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.medical_information,
                          color: Colors.white, size: 35),
                      SizedBox(height: 8.0),
                      Text(
                        'Accident',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150.0, 100.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.red,
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Action for the fourth button
                    print('Button 4 pressed');
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.directions_run, color: Colors.white, size: 35),
                      SizedBox(height: 8.0),
                      Text(
                        'Evacuation',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(150.0, 100.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Dashboard(),
  ));
}
