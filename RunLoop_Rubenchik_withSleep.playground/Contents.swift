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
struct StorageDevice {
    private(set) var array : [Bread] = []

    mutating func putNew(bread: Bread) {
        print("one bread is put \(bread.breadType.rawValue)") // delete
        self.array.append(bread)
    }

    mutating func getNew() -> Bread? {
        print("one bread is get \(array.last?.breadType.rawValue)") // delete
        return array.count > 0 ? array.removeLast() : nil
    }
}

var storageDevice = StorageDevice()
var isCreatedThreadWork = true
var isWorkerThreadWork = true
let condvar = NSCondition()

class CreateThread : Thread {
    override func main() {
        for _ in 0...9 {
            let newBread = Bread.make()
            condvar.lock()
            storageDevice.putNew(bread: newBread)
            condvar.unlock()
            if !isWorkerThreadWork {
                print("signal")
                condvar.signal()
            }
            Darwin.sleep(2)
        }
        // больше добавляться полуфабрикаты не будут
        isCreatedThreadWork = false
        print("End of create")
    }
}

class WorkThread : Thread {
    override func main() {

        while isCreatedThreadWork {

            if storageDevice.array.count == 0 {
                isWorkerThreadWork = false
                print("wait")               // delete
                condvar.wait()
            }
            while storageDevice.array.count > 0 {
                isWorkerThreadWork = true
                storageDevice.getNew()?.bake()
          }
        }
        print("End roast")
    }
}

let createThread = CreateThread()
let workThread = WorkThread()
createThread.qualityOfService = .userInitiated
workThread.qualityOfService = .background
createThread.start()
workThread.start()


