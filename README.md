# SwiftDataManager

SwiftDataManager est une librairie générique facilitant la gestion des objets persistants avec **SwiftData**. Il offre une interface simple pour **ajouter, récupérer, mettre à jour et supprimer** des objets tout en intégrant un mode **debug** optionnel.

## 📦 Installation

### Avec Swift Package Manager (SPM)
Ajoutez SwiftDataManager à votre projet en utilisant **Swift Package Manager** :

1. Ouvrez votre projet Xcode.
2. Allez dans **File > Add Packages...**.
3. Entrez l'URL du repository GitHub :
   ```
   https://github.com/Numero333/SwiftDataManager.git
   ```
4. Ajoutez le package à votre projet.

## 🚀 Utilisation

### **1️⃣ Importation**
Avant d'utiliser le gestionnaire de données, importez simplement la librairie :

```swift
import SwiftDataManager
```

### **2️⃣ Définition d'un Modèle**

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

### **3️⃣ Initialisation du DataManager**

```swift
let dataManager = try SwiftDataManager<User>(debugMode: true) // Mode debug activé
```

### **4️⃣ Ajout d'un Objet**

```swift
let newUser = User(name: "Alice", age: 25)
try dataManager.addItem(newUser)
```

### **5️⃣ Récupération des Objets**

```swift
let users = try dataManager.fetchItems()
```

### **6️⃣ Récupération d'un Objet avec un Prédicat**

```swift
let predicate = #Predicate<User> { $0.name == "Alice" }
if let user = try dataManager.fetchItem(predicate: predicate) {
    print("Utilisateur trouvé : \(user.name)")
}
```

### **7️⃣ Mise à Jour d'un Objet**

```swift
if let user = try dataManager.fetchItem(predicate: predicate) {
    try dataManager.updateItem(user) { $0.age = 30 }
}
```

### **8️⃣ Suppression d'un Objet**

```swift
if let user = try dataManager.fetchItem(predicate: predicate) {
    try dataManager.removeItem(user)
}
```

## 🛠 Mode Debug
Le mode **debug** permet d'afficher des logs détaillés lors des opérations CRUD. Il est désactivé par défaut.

- **Activer le mode debug :**
  ```swift
  let dataManager = try SwiftDataManager<User>(debugMode: true)
  ```
- **Désactiver le mode debug :**
  ```swift
  let dataManager = try SwiftDataManager<User>()
  ```

## 🏆 Avantages
✅ Simple d'utilisation<br>
✅ Basé sur **SwiftData**<br>
✅ Supporte les **prédicats et tris**<br>
✅ Mode debug activable<br>
✅ Compatible avec Swift Package Manager

## 📄 Licence
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

🎯 **Développé avec ❤️ par Numero333**
