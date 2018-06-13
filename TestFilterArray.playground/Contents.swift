//: A UIKit based Playground for presenting user interface
  
import UIKit

var array: [Int] = [1,2,3,4,5,6,7,8,9]

var array2 = array.filter { $0 > 2 && $0 < 7}

let array3 = array.filter { (x) -> Bool in
    if x == 5 || x == 6 { return true }
    return false
}

//print(array2)
//print(array3)

struct User {
    var name: String!
    var age: Int!
    var hasPet: Bool!
    var pets: [String]!
}

var users: [User] = []

users.append(User(name: "Anton", age: 43, hasPet: true, pets: ["cat", "dog", "rabbit"]))
users.append(User(name: "Bob", age: 36, hasPet: true, pets:["rabbit","dog"]))
users.append(User(name: "Cate", age: 65, hasPet: true, pets:["Guinea pigs", "Rats"]))

//let usersF = users.filter { (item) -> Bool in
//    if item.age > 60 { return true }
//    return false
//}

let usersF = users.filter { $0.age > 60 }
print(usersF)

let petArr = ["cat", "dog", "rabbit"]

var userFilter =
    users.filter { $0.pets.contains(petArr[1]) } // contains Bool содержит или нет
//print(userFilter)
//users = users.filter { $0.pets.contains(where: { petArr.contains($0) }) }
// func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element]

let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let shortNames = cast.filter { $0.count < 5 }
//print(shortNames)
// Prints "["Kim", "Karl"]"

