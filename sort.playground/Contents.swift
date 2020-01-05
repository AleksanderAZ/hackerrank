import UIKit

func sort(list: Array<Int>, in cores: Int)->Array<Int> {
    
    func merge(leftPile: [Int], rightPile: [Int]) -> [Int] {
        var leftIndex = 0
        var rightIndex = 0
        var orderedPile = [Int]()
        orderedPile.reserveCapacity(leftPile.count + rightPile.count)
        while true {
            guard leftIndex < leftPile.endIndex else {
                orderedPile.append(contentsOf: rightPile[rightIndex..<rightPile.endIndex])
                break
            }
            guard rightIndex < rightPile.endIndex else {
                orderedPile.append(contentsOf: leftPile[leftIndex..<leftPile.endIndex])
                break
            }
            if leftPile[leftIndex] < rightPile[rightIndex] {
                orderedPile.append(leftPile[leftIndex])
                leftIndex += 1
            }
            else if leftPile[leftIndex] > rightPile[rightIndex] {
                orderedPile.append(rightPile[rightIndex])
                rightIndex += 1
            }
            else {
                orderedPile.append(leftPile[leftIndex])
                orderedPile.append(rightPile[rightIndex])
                leftIndex += 1
                rightIndex += 1
            }
        }
        return orderedPile
    }
    
    func mergeSort(array: [Int], lineQueue: Int, nameQueue: String, maxQueue: Int, queue: OperationQueue?) -> [Int] {
        guard array.count > 1 else { return array }
        let middleIndex = array.count / 2
        var leftArray: [Int]?
        var rightArray: [Int]?
        var result: [Int]?
        let line = lineQueue * 2
        if line <= maxQueue  {
            let queueNew = OperationQueue()
            queueNew.name = (queue?.name ?? "error") + "."  + String(lineQueue) + nameQueue
            queueNew.maxConcurrentOperationCount = 4
            queue?.addOperation {
                leftArray = mergeSort(array: Array(array[0..<middleIndex]), lineQueue: line, nameQueue: nameQueue + "l", maxQueue: maxQueue, queue: queueNew)
            }
            queue?.addOperation {
                rightArray = mergeSort(array: Array(array[middleIndex..<array.count]), lineQueue: line, nameQueue: nameQueue + "r", maxQueue: maxQueue, queue: queueNew)
            }
            queue?.waitUntilAllOperationsAreFinished()
        }
        else {
            leftArray = mergeSort(array: Array(array[0..<middleIndex]), lineQueue: line, nameQueue: "", maxQueue: maxQueue, queue: nil)
            rightArray = mergeSort(array: Array(array[middleIndex..<array.count]), lineQueue: line, nameQueue: "", maxQueue: maxQueue, queue: nil)
        }
        result =  merge(leftPile: leftArray!, rightPile: rightArray!)
        return result!
    }
    
    // start recursion
    let queue = OperationQueue()
    queue.name = "com"
    queue.maxConcurrentOperationCount = 2
    let result = mergeSort(array: list, lineQueue: 1, nameQueue: "", maxQueue: cores, queue: queue)
    return result
}

// ----TEST -------
// generate Array
func creatArray(count: Int)-> [Int] {
    let third = count / 2
    var array = [Int]()
    for i in 0..<third {
        array.append(i)
    }
    array = array.reversed()
    for i in third..<count {
        array.append(i)
    }
    return array
}
// init data
let test = creatArray(count: 500)
let max = 32
//
for i in 0...max {
    print("-------\(i)------")
    let queueNew = OperationQueue()
    queueNew.name = "com"
    queueNew.maxConcurrentOperationCount = 2
    let t1 = Date()
    let result1 = sort(list: test, in: i)
    print("core=", i, "time=", Date().timeIntervalSince(t1))
    let t2 = Date()
    let result2 = sort(list: test, in: max - i)
    print("core=", max - i, "time=", Date().timeIntervalSince(t2))
    var testResult = test.sorted()
    // == [int] is equatable
    print(testResult == result1, testResult == result2)
}





