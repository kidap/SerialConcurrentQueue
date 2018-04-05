//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

print("----------------------------------------")
print("SERIAL")
print("----------------------------------------")

let serialQueue = DispatchQueue(label: "com.queue.serial")

//#1 --- Async means main thread is not blocked
serialQueue.async {
    let thread = Thread.current.isMainThread ? "main": "else"
    for x in 0...10 {
        print("\(x)👿 \(thread)")
    }
}

//#2 --- Not blocked by #1 so it just runs
print("1🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸")

//#3 --- Since queue is serial, it has to wait for #1 to complete
//       Sync blocks the main queue
serialQueue.sync {
    let thread = Thread.current.isMainThread ? "main": "else"
    for x in 0...15 {
        print("\(x)💩 \(thread)")
    }
}

//Blocked by #3 so it has to wait for that to complete
print("2🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸")


print("----------------------------------------")
print("CONCURRENT")
print("----------------------------------------")

let concurrentQueue = DispatchQueue(label: "com.queue.concurrent", attributes: .concurrent)


//#1 --- Async means main thread is not blocked
concurrentQueue.async {
    let thread = Thread.current.isMainThread ? "main": "other"
    for x in 0...10 {
        print("\(x)👿 \(thread)")
    }
}

//#2 --- Not blocked by #1 so it just runs
print("3🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹")

//#3 --- Since queue is concurrent, it just runs right away
//       Sync blocks the main queue
concurrentQueue.sync {
    let thread = Thread.current.isMainThread ? "main": "other"
    for x in 0...10 {
        print("\(x)💩 \(thread)")
    }
}

//#4 --- Blocked by #3 so it has to wait for that to complete
print("4🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹")

PlaygroundPage.current.needsIndefiniteExecution = true
