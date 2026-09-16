# EyeCare Connect — Firebase Dynamic (3 Roles)

Demo UI + **real Firebase Auth + Cloud Firestore**.  
সব data dynamic — Donor / Hospital / Admin.

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
