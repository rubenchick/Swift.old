//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
struct WordForLearning {
    var foreign : String = ""
    var original: String = ""
    var isLearned: Bool = false
    var levelOfLearning: Int = 0
}
// Два массива
let arrayRoot : [WordForLearning] =
    [WordForLearning(foreign: "table", original: "стол", isLearned: false, levelOfLearning: 0  ),
     WordForLearning(foreign: "ball", original: "мяч", isLearned: false, levelOfLearning: 0  )]
let arraySub : [(Int,Bool)] = [(1,true),(1,true),(1,true),(0,true),(0,false),]

for i in arrayRoot.indices {
    let x = arraySub.filter({ (y,z) -> Bool in
        if y == i {
            return z ? true : false
        } else {
            return false
        }
    })
    print(x.count)
}

// Подсчитать элементы второго массива с условием
