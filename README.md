# QuickSlot Flutter App

## Overview

QuickSlot is a Flutter application for booking sports venue slots.

Users can:

* Select a user profile
* Browse available venues
* View slots for a selected date
* Book available slots
* View their bookings
* Cancel bookings

---

## Tech Stack

* Flutter
* GetX
* Dio
* Shared Preferences

---

## Project Structure

```text
lib/
├── controllers/
├── data/
│   ├── models/
│   └── api_service.dart
├── screens/
│   ├── login/
│   ├── venue/
│   ├── venue_detail/
│   └── bookings/
└── main.dart
```

---

## Features

### User Selection

Simple user selection screen using predefined users.

### Venue Listing

Displays all available sports venues.

### Slot Availability

Displays slots from 6 AM to 10 PM.

Available Slots:

* Green

Booked Slots:

* Red
* Disabled

### Booking Flow

User selects:

* Venue
* Date
* Time Slot

Confirmation dialog is shown before booking.

### My Bookings

Displays all bookings made by the selected user.

### Cancel Booking

Allows users to cancel an existing booking.

---

## Setup

### Install Dependencies

```bash
flutter pub get
```

### Run Application

```bash
flutter run
```

---

## Backend Configuration

Update API Base URL:

```dart
const String baseUrl =
    "YOUR_BACKEND_URL/api/v1";
```

Examples:

Local:

```text
http://10.0.2.2:5000/api/v1
```

Production:

```text
https://your-app.up.railway.app/api/v1
```

---

## State Management

GetX is used for:

* Dependency Injection
* State Management
* Navigation

Controllers:

* AuthController
* VenueController
* BookingController

---

## User Flow

```text
Login
↓
Venue List
↓
Venue Detail
↓
Select Date
↓
Select Slot
↓
Book Slot
↓
My Bookings
↓
Cancel Booking
```

---

## Error Handling

Implemented:

* Loading States
* Empty States
* API Error Handling
* Booking Conflict Handling

---

## Future Improvements

* Real-time slot updates
* Offline cache support
* Push notifications
* User authentication
* Unit and Widget Tests

---

## AI Usage

AI tools were used for:

* Architecture planning
* UI scaffolding
* Code generation assistance

All generated code was reviewed, understood, and tested before integration.
