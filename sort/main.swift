//
//  main.swift
//  sort
//
//  Created by Z on 1/9/20.
//  Copyright © 2020 Zyma. All rights reserved.

import Foundation

func sort(list: Array<Int>, in cores: Int)->Array<Int> {
    class SortMerge {
        private let controlQueue: ControlQueue
        private var listFirst: [Int]
        private var listSecond: [Int]
        private let cores: Int
        private let countList: Int
        private let lastIndexList: Int
        
        init(list: Array<Int>, in cores: Int) {
            listFirst = list
            listSecond = list
            self.cores = cores < 1 ? 1 : cores
            countList = list.count
            lastIndexList = countList - 1
            controlQueue = ControlQueue(cores: cores)
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
        
        class ControlQueueOld {
            var queue =  DispatchQueue(label: "sort.merger.corer1", qos: .userInteractive, attributes: .concurrent)
            //var queue =  DispatchQueue.global()
            func getQueue()->DispatchQueue {
                return queue
            }
        }
        
        
        class ControlQueue {
            var queue =  DispatchQueue(label: "sort.merger.cores", qos: .userInteractive)
            var queueControl =  DispatchQueue(label: "sort.merger.control", qos: .userInteractive, attributes: .concurrent)
            var cores: Int
            var items = [DispatchWorkItem?]()
            var _countCores: Int = 0
            var countCores: Int {
                get { return _countCores}
                set {
                    if _countCores < (cores-1) { _countCores = newValue }
                    else {_countCores = 0}
                }
            }
            
            init(cores: Int) {
                self.cores = cores
                countCores = 0
            }
            
            func getQueue(item: DispatchWorkItem)->DispatchQueue {
                queueControl.sync {
                    if self.items.count < self.cores {
                        self.items.append(item)
                        self.countCores += 1
                    }
                    else {
                        self.items[self.countCores]?.wait()
                        self.items[self.countCores] = item
                        self.countCores += 1
                    }
                }
                return queue
            }
        }
        
        func mergeSort(flagRout: Bool, indexStart: Int, indexEnd: Int)->DispatchWorkItem? {
            
            let lengthIndexArray = indexEnd - indexStart
            guard lengthIndexArray > 0 else { return nil }
            let middleIndex = indexStart + lengthIndexArray / 2
            
            let item1 = self.mergeSort(flagRout: !flagRout, indexStart: indexStart, indexEnd: middleIndex)
            let item2 = self.mergeSort(flagRout: !flagRout, indexStart: middleIndex+1, indexEnd: indexEnd)
            
            let nameChangeGroup = DispatchGroup()
            
            if (item1 != nil) {
                let queue1 = controlQueue.getQueue(item: item1!)
                queue1.async(group: nameChangeGroup, execute: item1!)
            }
            if (item2 != nil) {
                let queue2 = controlQueue.getQueue(item: item2!)
                queue2.async(group: nameChangeGroup, execute: item2!)
            }
            
            if (!(item1 == nil && item2 == nil)) {
                nameChangeGroup.wait()
            }
            
            let item = DispatchWorkItem {
                if flagRout {
                    self.merge( inList: &self.listSecond, outList: &self.listFirst, indexStart: indexStart, indexEnd: indexEnd)
                }
                else {
                    self.merge( inList: &self.listFirst, outList: &self.listSecond, indexStart: indexStart, indexEnd: indexEnd)
                }
            }
            return item
        }
        
        func getSort()->[Int] {
            let item = mergeSort(flagRout: true, indexStart: 0, indexEnd: lastIndexList)
            if (item != nil) {
                let queue = controlQueue.getQueue(item: item!)
                queue.async(execute: item!)
            }
            item?.wait()
            return listFirst
        }
    }
    
    let sort = SortMerge(list: list, in: cores)
    
    return sort.getSort()
}
