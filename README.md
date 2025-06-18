# 📚 MyBookShelf

A simple and elegant iOS app that displays books related to **"Swift"** using the Google Books API. Books are saved locally for offline access using `.plist`, and the app follows best practices like `MVC`, `Codable`, and `async/await`.

---

## ✨ Features

- 🔍 **Auto Fetching** – Loads books related to “Swift” from Google Books API
- ⚡️ **Async/Await Networking** – Non-blocking API calls using Swift concurrency
- 🗃 **Property List Storage** – Books are saved locally in `.plist` using `PropertyListEncoder`
- 🔁 **Offline Access** – Automatically loads saved books when offline
- 🚫 **Duplicate Prevention** – Avoids adding the same book title twice
- 🧠 **Sorted with Closures** – Book list is sorted alphabetically using Swift closure logic
- 🧩 **UITableView Extensions** – Custom cell registration & dequeuing using extensions
- 🎯 **MVC Pattern** – Clear separation of model, view, and controller logic

---

## 🧱 App Architecture
├── 📁 Model
│   └── Book.swift
│   └── GoogleBooksAPIResponse.swift
│
├── 📁 View
│   └── Main.storyboard
│
├── 📁 Controller
│   └── BooksTableViewController.swift
│   └── GoogleBooksAPIService.swift
│   └── DataController.swift
---

## 🧪 Technologies Used

- 🛠 Swift 5
- 🖥 UIKit + Storyboard
- 🌐 URLSession (Networking)
- 🧾 Codable (JSON & plist)
- 📦 PropertyListEncoder / Decoder
- ✅ Closures for sorting/filtering
- 📲 UITableView

---

## 🚀 How It Works

1. App launches and fetches books with `"Swift"` keyword.
2. Data is decoded using `Codable` and sorted alphabetically.
3. Books are stored in a `.plist` for offline use.
4. User can swipe to delete or pull to refresh the list.

---

## 📸 Screenshots

> ![image](https://github.com/user-attachments/assets/a1739a00-2f55-425a-95e3-f518e705b86c)


---

## 👨‍💻 Author

**Chandramohan**  
🔗 [GitHub Profile](https://github.com/CM004)  

---
