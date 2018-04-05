# Serial and Concurrent Queue Example

## Serial Queue
### Create a serial queue
```
let serialQueue = DispatchQueue(label: "com.queue.serial")
```
### #1 
Async does not block the main thread
```
serialQueue.async {
    let thread = Thread.current.isMainThread ? "main": "other"
    for x in 0...10 {
        print("\(x)👿 \(thread)")
    }
}
```
### #2 
Not blocked by <b>#1</b> so it just runs
```
print("1🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸")
```
### #3 
Since queue is serial, it has to wait for <b>#1</b> to complete. Sync blocks the main thread
```       
serialQueue.sync {
    let thread = Thread.current.isMainThread ? "main": "other"
    for x in 0...15 {
        print("\(x)💩 \(thread)")
    }
}
```

### #4 
Blocked by <b>#3</b> so it has to wait for that to complete
```
print("2🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸🔸")
```

### Output
![03279484-8259-44a5-9d8b-15e2d1b6d5a7](https://user-images.githubusercontent.com/8204242/38346670-ad478f90-3864-11e8-857d-b5f469438977.png)


## Concurrent Queue
### Create a concurrent queue
```
let concurrentQueue = DispatchQueue(label: "com.queue.concurrent", attributes: .concurrent)
```

### #1 
Async does not block the main thread
```
concurrentQueue.async {
    let thread = Thread.current.isMainThread ? "main": "other"
    for x in 0...10 {
        print("\(x)👿 \(thread)")
    }
}
```

###  #2 
Not blocked by <b>#1</b> so it just runs
```
print("3🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹")
```
### #3 
Since queue is concurrent, it just runs right away. Sync blocks the main queue
```
concurrentQueue.sync {
    let thread = Thread.current.isMainThread ? "main": "other"
    for x in 0...10 {
        print("\(x)💩 \(thread)")
    }
}
```

###  #4 
Blocked by <b>#3</b> so it has to wait for that to complete
```
print("4🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹🔹")
```
### Output
![a1b9e926-404b-4057-b5b3-72f58b819d58](https://user-images.githubusercontent.com/8204242/38346694-d9c76dc4-3864-11e8-8742-675d588acd2c.png)

