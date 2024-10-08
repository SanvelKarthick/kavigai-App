# Kavigai App | Front-end development
>Kavigai is a mobile application developed using Flutter and Firebase, leveraging Flutter's robust UI toolkit for building natively compiled applications across multiple platforms from a single codebase. The integration of Firebase provides backend services such as real-time databases, authentication, cloud storage, and analytics, enabling Kavigai to offer a seamless and scalable user experience.

## Requirements
- Flutter SDK Download
- Android Studio SDK Download
- Firebase - Firestore CLI connection

## Home Page 
- App bar - Menu Drawer - Bottom Navigator
>Intro Page to Home page Navigate
```
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomeScreen();
```
<img width="487" alt="Screenshot 2024-08-29 at 2 42 24 AM" src="https://github.com/user-attachments/assets/ecd54d7f-a1dd-4be6-9c8d-42ff59a61778">

## Goal Page - CRUD Operation
- Goal Creation - Goal Save - Goal Update - Goal Delete
> Goal crud operations
 <img width="391" alt="Screenshot 2024-08-29 at 2 50 24 AM" src="https://github.com/user-attachments/assets/9be77c6e-4480-4dd0-a0bc-6f7212ad29d7">

## Firebase Database 
- Slider option - To make the process easy for the users to save all changes at a time 
- database - To save and retrieve the data from the firestore database
> Slider option
<img width="393" alt="Screenshot 2024-08-29 at 2 57 29 AM" src="https://github.com/user-attachments/assets/edaec312-c2d6-4fdf-b8b4-f890faceefbd">

> firestore database save
<img width="399" alt="Screenshot 2024-08-29 at 3 01 00 AM" src="https://github.com/user-attachments/assets/31067bbb-2965-491d-9df9-669de8b402a4">

## Reference 
- [Flutter Documentation](https://docs.flutter.dev/)
- [Flutter Studio](https://flutterstudio.app/)




