# EyeCare Connect — Firebase Dynamic (3 Roles)

Demo UI + **real Firebase Auth + Cloud Firestore**.  
সব data dynamic — Donor / Hospital / Admin.

## Step-by-step setup

### 1. Firebase Console
1. https://console.firebase.google.com → Create project
2. **Authentication** → Sign-in method → Enable **Email/Password**
3. **Firestore Database** → Create (test mode for now)

### 2. Project open & configure
```bash
cd eyecare_firebase_app
flutter create . --project-name eyecare_firebase_app
flutter pub get

# Install CLI once
dart pub global activate flutterfire_cli
firebase login
flutterfire configure
```
`flutterfire configure` will replace `lib/firebase_options.dart` automatically.

### 3. Run
```bash
flutter run
```

### 4. Firestore rules (recommended for production)
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
    match /donors/{donorId} {
      allow read: if request.auth != null;
      allow create, update: if request.auth != null &&
        (request.auth.uid == donorId ||
         get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role in ['hospital', 'admin']);
    }
  }
}
```

## Collections

**users** (doc id = Auth UID)
- name, email, phone, role (donor|hospital|admin), hospitalName?, address?

**donors** (doc id = Auth UID of donor)
- name, phone, bloodGroup, address, emergencyContact, emergencyPhone
- isRegistered, status (pending|verified|donated|rejected), registrationDate

## How roles work
| Role | Can do |
|------|--------|
| **Eye Donor** | Register as donor, see digital card, status, profile |
| **Hospital** | Search all donors, filter, update status (verify/donated) |
| **Admin** | See all users, hospitals, live report stats |

## Test flow
1. Register as **Eye Donor** → fill donation form → see card
2. Register another account as **Hospital** → Search Donor → Mark Verified
3. Register as **Admin** → Manage Users / Reports (live counts)
