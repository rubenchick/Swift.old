//
//  ViewController.swift
//  QoS
//
//  Created by Anton Rubenchik on 09.08.2018.
//  Copyright © 2018 Anton Rubenchik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        simpleGlobalAsyncQueue()
//        globalQueueWithDifferentQoS() // все выводится относительно последовательно , кроме main
//        customSerialQueue()   // Apple - задачи выполняются последовательно
//        customConcurrentQueue() // plApe - задачи выполняются параллельно
//        customConcurrentQueueSync() // Apple - задачи выполняются параллельно, но sync, задачи выполнятся по порядку
    }
    
    // 1 Вывели в задание очереди. Оно могло выполняться в разных потоках
    func simpleGlobalAsyncQueue() {
        DispatchQueue.global().async {
            for _ in 0...9 {
                print("😇")
            }
        }
    }
    
    //2 Создаем много очередей, с разным приоритетом. Асинхронно
    func globalQueueWithDifferentQoS() {
        
        DispatchQueue.global(qos: .background).async {
            sleep(1)
            for _ in 0...99 {
                print("background")
            }
        }
        
        DispatchQueue.global(qos: .utility).async {
            sleep(1)
            for _ in 0...99 {
                print("utility")
            }
        }
        
        DispatchQueue.global(qos: .default).async {
            sleep(1)
            for _ in 0...99 {
                print("default")
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            sleep(1)
            for _ in 0...99 {
                print("userInitiated")
            }
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            sleep(1)
            for _ in 0...99 {
                print("userInteractive")
            }
        }
        // вывод первым, так как main
        DispatchQueue.main.async {
            for _ in 0...99 {
                print("😇")
            }
        }
    }
    
    func customSerialQueue() {
        let serialQueue = DispatchQueue(label: "First")
        serialQueue.async {
            print("A")
        }
        
        serialQueue.async {
            print("p")
        }
        
        serialQueue.async {
            print("p")
        }
        
        serialQueue.async {
            print("l")
        }
        
        serialQueue.async {
            print("e")
        }
    }
    
    //4
    func customConcurrentQueue() {
        let concurrentQueue = DispatchQueue(label: "Second",
                                            qos: .background,
                                            attributes: .concurrent,
                                            autoreleaseFrequency: .inherit,
                                            target: .global(qos: .background))
        concurrentQueue.async {
            
            print("A")
        }
        
        concurrentQueue.async {
            
            print("p")
        }
        
        concurrentQueue.async {
            print("p")
        }
        
        concurrentQueue.async {
            print("l")
        }
        
        concurrentQueue.async {
            print("e")
            
        }
    }
    
    // 5
    func customConcurrentQueueSync()
    {
        let concurrentQueue = DispatchQueue(label: "Second",
                                            qos: .userInitiated,
                                            attributes: .concurrent,
                                            autoreleaseFrequency: .inherit,
                                            target: .global(qos: .userInitiated))
        concurrentQueue.sync {
            
            print("A")
        }
        
        concurrentQueue.sync {
            
            print("p")
        }
        
        concurrentQueue.sync {
            print("p")
        }
        
        concurrentQueue.sync {
            print("l")
        }
        
        concurrentQueue.sync {
            print("e")
            
        }
        
    }
}

