//
//  main.swift
//  sort
//
//  Created by Z on 1/9/20.
//  Copyright © 2020 Zyma. All rights reserved.
//

import Foundation

import Foundation

func sort(list: Array<Int>, in cores: Int)->Array<Int> {
    
    class SortMerge {
        private var listFirst: [Int]
        private var listSecond: [Int]
        private var flagOutRout = true
        private let queue = OperationQueue()
        private let cores: Int
        private let countList: Int
        private let lastIndexList: Int
        
        init(list: Array<Int>, in cores: Int) {
            listFirst = list
            listSecond = list
            self.cores = cores < 1 ? 1 : cores
            countList = list.count
            lastIndexList = countList - 1
            queue.name = "sort.merge.multi"
            queue.maxConcurrentOperationCount = cores
        }
        
        func merge( inList: inout [Int], outList: inout [Int], indexStart: Int, indexEnd: Int) {
            let countIndex = indexEnd - indexStart
            guard countIndex > 0 else { outList[indexStart] = inList[indexStart];  return}
            var newIndex = indexStart
            var leftIndex = indexStart
            let leftIndexEnd = indexStart + countIndex / 2
            var rightIndex = leftIndexEnd + 1
            while (newIndex <= indexEnd) {
                if (leftIndex > leftIndexEnd) {
                    if (!(rightIndex > indexEnd)) {
                        for i in rightIndex...indexEnd {
                            outList[i] = inList[i]
                        }
                    }
                    break
                }
                else if (rightIndex > indexEnd) {
                    if (!(leftIndex > leftIndexEnd)) {
                        for i in leftIndex...leftIndexEnd {
                            outList[newIndex] = inList[i]
                            newIndex += 1
                        }
                    }
                    break
                }
                else if (inList[leftIndex] < inList[rightIndex]) {
                    outList[newIndex] = inList[leftIndex]
                    leftIndex += 1
                }
                else if (inList[leftIndex] > inList[rightIndex]) {
                    outList[newIndex] = inList[rightIndex]
                    rightIndex += 1
                }
                else {
                    outList[newIndex] = inList[rightIndex]
                    newIndex += 1
                    outList[newIndex] = inList[leftIndex]
                    leftIndex += 1
                    rightIndex += 1
                }
                newIndex += 1
            }
        }
        
        func mergeSort(flagRout: Bool, indexStart: Int, indexEnd: Int, lineQueue: Int, maxQueue: Int, queue: OperationQueue?) {
            let lengthIndexArray = indexEnd - indexStart
            guard lengthIndexArray > 0 else { return }
            let middleIndex = indexStart + lengthIndexArray / 2
            if lineQueue <= maxQueue  {
                let line = lineQueue * 2
                if line > maxQueue  {
                    let operetion1 = BlockOperation {
                        self.mergeSort(flagRout: !flagRout, indexStart: indexStart, indexEnd: middleIndex, lineQueue: line, maxQueue: maxQueue, queue: queue)
                        self.mergeSort(flagRout: !flagRout, indexStart: middleIndex+1, indexEnd: indexEnd, lineQueue: line, maxQueue: maxQueue, queue: queue)
                    }
                    let operetion3 = BlockOperation {
                        if flagRout {
                            self.merge( inList: &self.listSecond, outList: &self.listFirst, indexStart: indexStart, indexEnd: indexEnd)
                        }
                        else {
                            self.merge( inList: &self.listFirst, outList: &self.listSecond, indexStart: indexStart, indexEnd: indexEnd)
                        }
                        self.flagOutRout = flagRout
                    }
                    operetion3.addDependency(operetion1)
                    queue?.addOperation(operetion1)
                    queue?.addOperations([operetion3], waitUntilFinished: true)
                }
                else {
                    mergeSort(flagRout: !flagRout, indexStart: indexStart, indexEnd: middleIndex, lineQueue: line, maxQueue: maxQueue, queue: queue)
                    mergeSort(flagRout: !flagRout, indexStart: middleIndex+1, indexEnd: indexEnd, lineQueue: line, maxQueue: maxQueue, queue: queue)
                    let operetion2 = BlockOperation {
                        if flagRout {
                            self.merge( inList: &self.listSecond, outList: &self.listFirst, indexStart: indexStart, indexEnd: indexEnd)
                        }
                        else {
                            self.merge( inList: &self.listFirst, outList: &self.listSecond, indexStart: indexStart, indexEnd: indexEnd)
                        }
                        self.flagOutRout = flagRout
                    }
                    queue?.addOperations([operetion2], waitUntilFinished: true)
                }
            }
            else {
                mergeSort(flagRout: !flagRout, indexStart: indexStart, indexEnd: middleIndex, lineQueue: maxQueue*2, maxQueue: maxQueue, queue: queue)
                mergeSort(flagRout: !flagRout, indexStart: middleIndex+1, indexEnd: indexEnd, lineQueue: maxQueue*2, maxQueue: maxQueue, queue: queue)
                if flagRout {
                    merge( inList: &listSecond, outList: &listFirst, indexStart: indexStart, indexEnd: indexEnd)
                }
                else {
                    merge( inList: &listFirst, outList: &listSecond, indexStart: indexStart, indexEnd: indexEnd)
                }
                flagOutRout = flagRout
            }
        }
        
        func getSort()->[Int] {
            mergeSort(flagRout: flagOutRout, indexStart: 0, indexEnd: lastIndexList, lineQueue: 1, maxQueue: cores, queue: queue)
            if flagOutRout {
                return listFirst
            }
            else {
                return listSecond
            }
        }
        
    }
    
    let sort = SortMerge(list: list, in: cores)
    
    return sort.getSort()
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
func test() {
    let max = 8
    let test = creatArray(count: 20003)
    for i in 1...max {
        print("---cores----\(i)------")
        let t1 = Date()
        let result1 = sort(list: test, in: i)
        print("core=", i, "time=", Date().timeIntervalSince(t1))
        let testResult = test.sorted()
        print(testResult == result1)
    }
}

