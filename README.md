# fultter_test
The Flutter app for  Flutter Test showcases a secure login/signup system with validation, employing Provider for state management. Integrated with a RESTful API, the app displays a list of employees and allows users to view detailed information with a simple tap, emphasizing code quality and modularity
# Fresher Flutter Test App

This Flutter app is part of the Fresher Flutter Test and includes the following components:

- Login Screen
  <p>
    The login screen is where users can enter their credentials to log in. Proper validation is implemented to ensure the correctness of the entered information.
  </p>
- Signup Screen
  <p>
    The signup screen allows new users to register with their details, including first name, last name, email, mobile, and password. Proper validation is implemented, and there's a password hide/show functionality for enhanced user experience
  </p>
- Home Screen
- <p>
  After successful login or signup, users are redirected to the home screen, where a personalized welcome message is displayed along with an Employee List.
</p>
- Employee List
<p>
  The Employee List screen fetches employee information from the API endpoint https://dummy.restapiexample.com/api/v1/employees and displays it in a list. Each employee entry includes their name, salary, and age.
</p>
- Employee Details Screen
<p>
  Tapping on an employee card in the Employee List navigates the user to the Employee Details screen. This screen fetches detailed employee information using the API endpoint https://dummy.restapiexample.com/api/v1/employee/{id} and displays the employee's name, salary, and age.
</p>
-State Management
<p>
  The app uses the Provider package for state management. Each significant screen has its own corresponding provider or notifier.
</p>


