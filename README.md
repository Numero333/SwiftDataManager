# SwiftDataManager

SwiftDataManager is a generic library that simplifies the management of persistent objects with **SwiftData**. It provides an easy-to-use interface for **adding, retrieving, updating, and deleting** objects while integrating an optional **debug mode**.

## 📦 Installation

### Using Swift Package Manager (SPM)
Add SwiftDataManager to your project using **Swift Package Manager**:

1. Open your Xcode project.
2. Go to **File > Add Packages...**.
3. Enter the GitHub repository URL:
   ```
   https://github.com/Numero333/SwiftDataManager.git
   ```
4. Add the package to your project.

## 🚀 Usage

### **1️⃣ Importing**
Before using the data manager, simply import the library:

```swift
import SwiftDataManager
```

### **2️⃣ Defining a Model**

```swift
import SwiftData

@Model
class User {
    var id: UUID
    var name: String
    var age: Int
    
    init(id: UUID = UUID(), name: String, age: Int) {
        self.id = id
        self.name = name
        self.age = age
    }
}
```

### **3️⃣ Initializing the DataManager**

```swift
let dataManager = try SwiftDataManager<User>(debugMode: true) // Debug mode enabled
```

### **4️⃣ Adding an Object**

```swift
let newUser = User(name: "Alice", age: 25)
try dataManager.addItem(newUser)
```

### **5️⃣ Retrieving Objects**

```swift
let users = try dataManager.fetchItems()
```

### **6️⃣ Retrieving an Object with a Predicate**

```swift
let predicate = #Predicate<User> { $0.name == "Alice" }
if let user = try dataManager.fetchItem(predicate: predicate) {
    print("User found: \(user.name)")
}
```

### **7️⃣ Updating an Object**

```swift
if let user = try dataManager.fetchItem(predicate: predicate) {
    try dataManager.updateItem(user) { $0.age = 30 }
}
```

### **8️⃣ Deleting an Object**

```swift
if let user = try dataManager.fetchItem(predicate: predicate) {
    try dataManager.removeItem(user)
}
```

## 🛠 Debug Mode
The **debug mode** allows detailed logging of CRUD operations. It is disabled by default.

- **Enable debug mode:**
  ```swift
  let dataManager = try SwiftDataManager<User>(debugMode: true)
  ```
- **Disable debug mode:**
  ```swift
  let dataManager = try SwiftDataManager<User>()
  ```

## 🏆 Benefits
✅ Easy to use<br>
✅ Based on **SwiftData**<br>
✅ Supports **predicates and sorting**<br>
✅ Activatable debug mode<br>
✅ Compatible with Swift Package Manager

## 📄 License
MIT License

Copyright (c) 2025 Numero333

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

---

🎯 **Developed with ❤️ by Numero333**

