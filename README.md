TradMed - Traditional Medicine & Healthcare App
Overview
TradMed is a mobile application designed to provide users with access to traditional herbal remedies, education articles on first aid, a blog post community, and telemedicine features that allow users to chat with doctors for remote consultations. This app serves as a comprehensive platform for those seeking alternative medical advice, healthcare education, and professional consultations.

Key Features
AI-Powered Herbal Product Recommendations:

Using AI to recommend the best herbal products based on user preferences, symptoms, and health conditions. The recommendation engine ensures that users get personalized herbal solutions for common ailments.
Educational Articles About First Aid:

A curated collection of articles that provide essential information on first aid practices. Users can learn about immediate care techniques for injuries, emergencies, and other health situations, ensuring they are well-prepared in times of need.
Blog Post Community:

A community-driven feature where users can read, create, and comment on blog posts related to herbal medicine, wellness, and health topics. The community space fosters engagement and knowledge sharing among users.
Telemedicine - Chat with a Doctor:

The app offers telemedicine services where users can book consultations and chat with doctors online. The chat system allows users to discuss their health concerns, receive medical advice, and get prescriptions from licensed healthcare professionals.
Screenshots
app interface 
![Uploading photo_2024-12-02_07-25-55.jpg…]()
![photo_2024-12-02_07-25-47](https://github.com/user-attachments/assets/7422316a-f73c-42e7-965d-b1a6671551c0)
![photo_2024-12-02_07-25-29](https://github.com/user-attachments/assets/5890282a-497f-4e4c-a290-dd7ee17bc1d2)


![photo_2024-10-03_06-45-38](https://github.com/user-attachments/assets/dfcd13f5-8676-42fa-b6e1-be4affbb952d)
![photo_2024-10-03_06-51-23](https://github.com/user-attachments/assets/b78f16ca-45d2-466e-98e3-c724e80161ee)

![photo_2024-10-03_06-49-01](https://github.com/user-attachments/assets/dd309673-8aa0-4a9d-b4ed-8a6f75a035ee)
![photo_2024-10-03_06-49-12](https://github.com/user-attachments/assets/8e26c365-5e99-44a7-b41c-cb19fd7ba16e)
![photo_2024-10-03_06-49-17](https://github.com/user-attachments/assets/b7cb9cc2-3be7-4c0c-9f06-71dbfab6d369)
![photo_2024-10-03_06-51-32](https://github.com/user-attachments/assets/c3d83853-cd26-4b62-a05a-0fa30e6d0c62)
![photo_2024-10-03_06-45-23](https://github.com/user-attachments/assets/0f951664-f877-4d7a-9fa5-b4d17faeec80)

![photo_2024-10-03_06-51-51](https://github.com/user-attachments/assets/78bec3b5-628b-48db-a1a5-08a254a62bf5)

![photo_2024-10-03_07-12-39](https://github.com/user-attachments/assets/8d92b33a-e031-4e5d-acfe-f966d9d2023a)


Technology Stack
Frontend: Flutter
State Management: BLoC
Backend: go lang
Database: MongoDB
AI Recommendation System: TensorFlow (or any other AI model you use)
API: REST API
Authentication: JWT (JSON Web Token) based authentication
Real-time Messaging: socket_io_client for real-time chat between users and doctors
Features Breakdown
Herbal Product AI Recommendation:

Leverages machine learning to suggest herbal products based on user input.
Users can answer health-related questions and the AI will suggest the best herbal remedies.
First Aid Educational Articles:

Articles cover a wide range of first aid topics, including burns, cuts, sprains, and more.
Provides both text and visual content to help users understand proper first aid practices.
Blog Post Community:

Users can explore posts written by the community.
They can also create their own posts, share their experiences with herbal products, and interact with others through comments.
Telemedicine - Chat with Doctors:

A dedicated page where users can see a list of available doctors and start a chat session.
Doctors can provide remote medical advice, and if needed, prescribe medication.
The chat feature uses socket_io_client for real-time interaction with healthcare professionals.
Installation
Prerequisites:
Flutter SDK installed on your machine.
Android Studio or Xcode installed for mobile app development.
A code editor like Visual Studio Code.
Setup:
Clone the repository:

bash
Copy code
git clone (https://github.com/hawi-me/TradMed_medical_app)
Navigate to the project directory:

bash
Copy code
cd tradmed-app
Install dependencies:

bash
Copy code
flutter pub get
Run the app:

bash
Copy code
flutter run
API Configuration:
Set up your API keys and backend configuration in the .env file or config.dart.
Icons & Branding:
Make sure to update the app’s launcher icon with your custom design:

bash
Copy code
flutter pub run flutter_launcher_icons:main
Contributing
Contributions are welcome! Please follow the steps below to contribute:

Fork the project.
Create a new branch:
bash
Copy code
git checkout -b feature-branch
Commit your changes:
bash
Copy code
git commit -m 'Add a new feature'
Push to the branch:
bash
Copy code
git push origin feature-branch
Open a pull request.
License
This project is licensed under the MIT License - see the LICENSE file for details.
