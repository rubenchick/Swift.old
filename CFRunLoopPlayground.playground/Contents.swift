//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport
var i = 2
let timer1 = Timer(timeInterval: 2, repeats: true) {  timerX in
    i += 2
    print("\(i) Timer is working")
}

//RunLoop.current.add(timer1, forMode: .defaultRunLoopMode)
//RunLoop.current.run()
//let tt = CFRunLoopTimer(
//CFRunLoopAddTimer(<#T##rl: CFRunLoop!##CFRunLoop!#>, <#T##timer: CFRunLoopTimer!##CFRunLoopTimer!#>, <#T##mode: CFRunLoopMode!##CFRunLoopMode!#>)

let runLoop = CFRunLoopGetCurrent()

let timer =  CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, 0.1, 2.0, 0, 0, { _ in
    print("\(i) Timer is working")
    i += 2
    if i > 10 {
        print("the End")
        CFRunLoopStop(runLoop) }
})




//let  y = CFRunLoopMode.commonModes
CFRunLoopAddTimer(runLoop, timer, .commonModes)
CFRunLoopRun()
