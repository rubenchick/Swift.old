//: A UIKit based Playground for presenting user interface
  // NSCondition lock, wait, signal
import UIKit
import PlaygroundSupport

func printNumber(number: Int, type: String) {
    for i in 0...number {
        print("\(number) \(type)")
    }
}
var j = 0
let convar = NSCondition()
var isCanceled = false
let thread1 = Thread() {
    convar.lock()
    for i in 1...10 {
        guard Thread.current.isCancelled == false else {
            break
        }
        j += 1
        print("\(j) Create")
        if i == 3 { isCanceled = true
            convar.signal()
            convar.wait()
        }
    }
    convar.signal()
    convar.unlock()
}
let thread2 = Thread() {
    convar.lock()
    while !isCanceled {
        convar.wait()
    }
  
    for i in 1...10 {
        guard Thread.current.isCancelled == false else {
            break
        }
        j += 1
        print("\(j) Work")
        if i == 3 { isCanceled = true
            convar.signal()
            convar.wait()
        }
    }
    convar.signal()
    convar.unlock()
}
thread1.start()
thread2.start()

