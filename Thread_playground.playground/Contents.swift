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
        print("Печем хлеб сек - \(breadType.rawValue)") // delete
        sleep(UInt32(bakeTime + 5)) // +3 delete
    }
}

// my code

PlaygroundPage.current.needsIndefiniteExecution = true
struct StorageDevice {
    private(set) var array : [Bread] = []
    
    mutating func putNew(bread: Bread) {
        self.array.append(bread)
        print("one bread is put \(bread.breadType.rawValue)") // delete
    }
    
    mutating func getNew() -> Bread? {
        print("one bread is get \(array.last?.breadType.rawValue)") // delete
        return array.count > 0 ? array.removeLast() : nil // m.b need self
    }
}

var storageDevice = StorageDevice()
var isCreatedThreadWork = true
var isWorkerThreadWork = true
let condvar = NSCondition()
var i = 2

class CreateThread : Thread {
    override func main() {
        let runLoop = CFRunLoopGetCurrent()
        var isFinishedWork : Bool = false
        print("CreateThread Work")
        
        let timerX =  CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, 0.1, 2.0, 0, 0, { _ in
            
            print("Timer Work")
            if isFinishedWork {
                // больше добавляться полуфабрикаты не будут
                isCreatedThreadWork = false
                print("End of create")
//                timerX.invalidate()
                CFRunLoopStop(runLoop)
            } else {
                print("before Create")
                condvar.lock()
                let newBread = Bread.make()
                print("before PUT")
                storageDevice.putNew(bread: newBread)
                print("after PUT")
                condvar.unlock()
                if !isWorkerThreadWork {
                    condvar.signal()
                }
            }
            
            
//            print("\(i) Timer is working")
//            i += 2
//            if i > 10 {
//                print("the End")
//                CFRunLoopStop(runLoop) }
        })
        
        
//        let timer = Timer(timeInterval: 2, repeats: true) { timer in
//            print("Timer Work")
////            if isFinishedWork {
////                // больше добавляться полуфабрикаты не будут
////                isCreatedThreadWork = false
////                print("End of create")
////                timer.invalidate()
////            } else {
//            print("before Create")
//                condvar.lock()
//                let newBread = Bread.make()
//                print("before PUT")
//                storageDevice.putNew(bread: newBread)
//                print("after PUT")
//                condvar.unlock()
//                if !isWorkerThreadWork {
//                    condvar.signal()
////                }
//            }
//        }
        
        let timer20sec = Timer(timeInterval: 10, repeats: false) { _ in
            isFinishedWork = true
            isCreatedThreadWork = false
            print("20 sec finished")
        }
        RunLoop.current.add(timer20sec, forMode: .defaultRunLoopMode)

//        RunLoop.current.run(until: Date(timeIntervalSinceNow: 10))
//        RunLoop.current.run()
        
        CFRunLoopAddTimer(runLoop, timerX, .commonModes)
        CFRunLoopRun()
        
        
        
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
//                condvar.lock()
                print("\(storageDevice.array.count) While") // delete
                let x = storageDevice.array.last?.breadType.rawValue // delete
                storageDevice.getNew()?.bake()
                print("\(x) Закончили печь") // delete
//                condvar.unlock()
                print(storageDevice.array.count) // delete
            }
            print(isCreatedThreadWork,storageDevice.array.count) // delete
        }
        print("End roast")
    }
}


//RunLoop.current.add(timerFinish, forMode: .defaultRunLoopMode)
//RunLoop.current.add(timer, forMode: .defaultRunLoopMode)

//
print("Start")
let createThread = CreateThread()
let workThread = WorkThread()
createThread.qualityOfService = .userInitiated
workThread.qualityOfService = .userInitiated
createThread.start()
workThread.start()
//
//print(timer.isValid)
//print(timerFinish.isValid)
//while isWorked {
//
//}
//thread.cancel()
//let newBread = Bread.make()
//storageDevice.putNew(bread: newBread)
//let newBread2 = Bread.make()
//storageDevice.putNew(bread: newBread2)
//print(storageDevice.array.count)
//let newBread4 = storageDevice.getNew()
//print(storageDevice.array.count)
//print("The End")








// ======================
// ======================
// ======================
// ======================
// ======================

// REserve code

//let first = CreateThread()
//first.start()
//print("Done")
//Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
//    print("Finish work")
//}

//let timer = Timer.init(timeInterval: 3, repeats: false) { _ in
//    print("Finish work")
//}
//RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
//
//
//
//print(timer.isValid)
//
//
//print("The end")
//sleep(5)
//
//print(timer.isValid)

// Swift block syntax (iOS 10+)
//let timer = Timer(timeInterval: 0.4, repeats: true) { _ in print("Done!") }
// Swift >=3 selector syntax
//let timer = Timer.scheduledTimer(timeInterval: 0.4, target: self, selector: #selector(update), userInfo: nil, repeats: true)
//
//
////// must be internal or public.
//func update() {
//    // Something cool
//    print("Done!")
//}



//let timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
//    print("Timer Fired at: \(timer.fireDate)")
//}








// ======================
// ======================
// ======================
// ======================
// ======================


// Example 5
//// Подсчет суммы чисел массива
//let n = 1000
//var array : [Int] = []
//array.reserveCapacity(n)
//
//struct SumStorage {
//
//    private(set) var sum = 0
//    private(set) var count = 0
//    mutating func increment(sum: Int, count: Int) {
//        let newSum = self.sum + sum
//        let newCount = self.count + count
//        self.sum = newSum
//        self.count = newCount
//    }
//}
//
//struct SumStorageWithMutex {
//    private let mutex = NSLock() // add
//    private(set) var sum = 0
//    private(set) var count = 0
//    mutating func increment(sum: Int, count: Int) {
//        mutex.lock() // add
//        let newSum = self.sum + sum
//        let newCount = self.count + count
//        self.sum = newSum
//        self.count = newCount
//        mutex.unlock() // add
//    }
//}
//
//var storage = SumStorage()
//var storage2 = SumStorageWithMutex()
//for i in 0...n {
//    array.append(i)
//}
//
//let threadCount = 50
//for i in 0...threadCount - 1 {
//    Thread.detachNewThread {
//        var sum = 0
//        var count = 0
//        var currentIndex = i
//        while currentIndex < array.count {
//            sum += array[currentIndex]
//            count += 1
//            currentIndex += threadCount
//        }
//        storage2.increment(sum: sum, count: count)// выдает ошибочный результат, так как вызывается одновременнов разных потоках
//
//    }
//}
//
//sleep(2)
//print("sum \(storage2.sum)")
//print("count \(storage2.count)")


// Example 4


//class MyThread: Thread {
//    override func main() { // write code
//        print(self.isMainThread)
//        print(self.isExecuting)
//    }
//}
//
//let thread3 = MyThread()
//thread3.start()
//print("Done")

// Example 3
//let thread = Thread() {
//    for i in 1...10 {
//        guard Thread.current.isCancelled == false else {
//            break
//        }
//        print("Hello \(i)")
//        sleep(1)
//    }
//}
//
//thread.start()
//sleep(3)
//thread.cancel()
//print("Done")




















// Example 1
//var thread: pthread_t? // переменная для хранения потока
//pthread_create(&thread, // создаем поток; &thread - указатель на адрес в памяти на значение этой переменной;
//               nil, // nil - передаем атрибуты
//               { // точка входа для потока
//    _ in
//    sleep(3)                   // код
//    print("Hello World")
//    return nil
//}, nil) // аргумент, который используется в замыкании, в данном случае его нет
//// default все потоки join
//pthread_join(thread!, nil) // прерываем выполнение текущего потока, пока не выполнится этот  поток
//print("Done")

// Example 2
// сообщаем, что главный поток не должен быть остановлен
//PlaygroundPage.current.needsIndefiniteExecution = true
//
//var attributes = pthread_attr_t()
//pthread_attr_init(&attributes) // инициализируем
//// указываем что поток не прерывает другие
//pthread_attr_setdetachstate(&attributes, PTHREAD_CREATE_DETACHED)
//
//var detachedThread: pthread_t?
//pthread_create(&detachedThread, &attributes, {
//    _ in
//    sleep(3)
//    print("Hello World")
//    return nil
//}, nil)
//
//pthread_detach(detachedThread!)
//print("Done")
// ======================================================================
// ======================================================================
// ======================== Work Version ================================
// ======================================================================
// ======================================================================
// Work Version
// my code

//PlaygroundPage.current.needsIndefiniteExecution = true
//struct StorageDevice {
//    private(set) var array : [Bread] = []
//
//    mutating func putNew(bread: Bread) {
//        self.array.append(bread)
//        print("one bread is put \(bread.breadType.rawValue)") // delete
//    }
//
//    mutating func getNew() -> Bread? {
//        print("one bread is get \(array.last?.breadType.rawValue)") // delete
//        return array.count > 0 ? array.removeLast() : nil // m.b need self
//    }
//}
//
//var storageDevice = StorageDevice()
//var isCreatedThreadWork = true
//var isWorkerThreadWork = true
//let condvar = NSCondition()
//
//class CreateThread : Thread {
//    override func main() {
//        //        var isFinishedWork : Bool = false
//        //
//        //        let timer = Timer(timeInterval: 2, repeats: true) { timer in
//        //            if isFinishedWork {
//        //                timer.invalidate()
//        //            } else {
//        //                let newBread = Bread.make()
//        //                storageDevice.putNew(bread: newBread)
//        //                print(storageDevice.array.count)
//        //            }
//        //            print("timer 2sec")
//        //        }
//
//        //        let timerFinish = Timer(timeInterval: 20, repeats: false) { timer2 in
//        //            isFinishedWork = true
//        //            isWorked = false
//        //            print("Timer Fired at: \(timer2.fireDate)")
//        //        }
//        for _ in 0...4 {
//            let newBread = Bread.make()
//            condvar.lock()
//            storageDevice.putNew(bread: newBread)
//            condvar.unlock()
//            if !isWorkerThreadWork {
//                condvar.signal()
//            }
//            Darwin.sleep(2)
//        }
//        // больше добавляться полуфабрикаты не будут
//        isCreatedThreadWork = false
//        print("End of create")
//
//        //        RunLoop.current.add(timerFinish, forMode: .defaultRunLoopMode)
//        //        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
//    }
//}
//
//class WorkThread : Thread {
//    override func main() {
//
//        while isCreatedThreadWork {
//
//            if storageDevice.array.count == 0 {
//                isWorkerThreadWork = false
//                print("wait")               // delete
//                condvar.wait()
//
//            }
//            while storageDevice.array.count > 0 {
//                isWorkerThreadWork = true
//                //                condvar.lock()
//                print("\(storageDevice.array.count) While") // delete
//                let x = storageDevice.array.last?.breadType.rawValue // delete
//                storageDevice.getNew()?.bake()
//                print("\(x) Закончили печь") // delete
//                //                condvar.unlock()
//                print(storageDevice.array.count) // delete
//            }
//            print(isCreatedThreadWork,storageDevice.array.count) // delete
//        }
//        print("End roast")
//    }
//}
//
//
////RunLoop.current.add(timerFinish, forMode: .defaultRunLoopMode)
////RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
//
////
//
//let createThread = CreateThread()
//let workThread = WorkThread()
//createThread.qualityOfService = .userInitiated
//workThread.qualityOfService = .background
//createThread.start()
//workThread.start()

