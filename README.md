# learnlyapp

A Flutter app for learnly assignment

# Requirements

Create a user interface that allows mothers to add, view, and edit milestones for their babies. Include necessary details such as date, milestone type (e.g., first smile, first step), and any additional notes.

Implement a state storage for milestone data to ensure that it persists between app sessions.

Consider the overall user experience, making the interface intuitive and engaging for mothers.

Create an onboarding screen and a dashboard screen

## Getting Started

run `flutter pub get`


# Approach

I used a feature driven development approach with BLoC state management.
I used Shared Preferences to store user data 
I used Shared Preferences to show a basic on-boarding screen only on the first launch of the app.
I created a primitive milestone model which requires Datetime, milestoneType and additionalNotes.
I created a dimenstions.dart file which contains a global key which provides dimensions to enitre app.


