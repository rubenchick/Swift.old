//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport
import Foundation


public struct Bread {
    public enum BreadType: UInt32 {
        case small = 1
        case medium
        case big
    }
    
    public let breadType: BreadType
    
    public static func make() -> Bread {
        guard let breadType = Bread.BreadType(rawValue: UInt32(arc4random_uniform(3) + 1)) else {
            fatalError("Incorrect random value")
        }
        
        return Bread(breadType: breadType)
    }
    
    public func bake() {
        let bakeTime = breadType.rawValue
        sleep(UInt32(bakeTime))
    }
}

// my code

PlaygroundPage.current.needsIndefiniteExecution = true
let condvar = NSCondition()

struct StorageDevice {
    private(set) var array : [Bread] = []
    
    mutating func putSemiFinished(bread: Bread) {
        print("One SemiFinished was put (\(bread.breadType.rawValue) sec)") // delete
        condvar.lock()
        self.array.append(bread)
        condvar.unlock()
        
    }
    
    mutating func getSemiFinished() -> Bread? {
        print("One SemiFinished was taken for baking (\((array.last?.breadType.rawValue)!) sec) ") // delete
        condvar.lock()
        defer { condvar.unlock() }
        return array.count > 0 ? array.removeLast() : nil
    }
}

var storageDevice = StorageDevice()
var isCreatedThreadWorking = true // Индикатор работы первого потока
var isWorkThreadWorking = true    // Индикатор работы второго потока

class CreateThread : Thread {
    override func main() {
        let runLoop = CFRunLoopGetCurrent()
        // основной таймер
        let timer =  CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, 0.1, 2.0, 0, 0, { _ in
            if !isCreatedThreadWorking {
                // больше добавляться полуфабрикаты не будут
                print("End of create")
                CFRunLoopStop(runLoop)
            } else {
                let newBread = Bread.make()
                storageDevice.putSemiFinished(bread: newBread)
            }
        })
        // вспомогательный таймер, который через 20 сек отключит  первый таймер
        let timer20sec = Timer(timeInterval: 20, repeats: false) { _ in
            isCreatedThreadWorking = false
        }
        
        RunLoop.current.add(timer20sec, forMode: .defaultRunLoopMode)
        CFRunLoopAddTimer(runLoop, timer, .commonModes)
        CFRunLoopRun()
        
        // Понимаю, что лучше использовать один таймер:
        // RunLoop.current.run(until: Date(timeIntervalSinceNow: 10))
        // но не смог понять как изменить isCreatedThreadWorking = false после отработки таймера
    }
}

class WorkThread : Thread {
    override func main() {
        
        while isCreatedThreadWorking {
            
            if storageDevice.array.count == 0 {
                isWorkThreadWorking = false
            }

            while storageDevice.array.count > 0 {
                isWorkThreadWorking = true
                print("\nCount elements of array is \(storageDevice.array.count) ")
                storageDevice.getSemiFinished()?.bake()
            }
        }
        print("End roast")
    }
}

let createThread = CreateThread()
let workThread = WorkThread()
createThread.qualityOfService = .userInitiated
workThread.qualityOfService = .userInitiated
createThread.start()
workThread.start()


