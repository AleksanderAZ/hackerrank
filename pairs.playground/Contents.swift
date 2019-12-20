import UIKit
import Foundation

// Complete the pairs function below.
func pairs(k: Int, arr: [Int]) -> Int {
    
    var countPairs: Int = 0
    let lastIndex = arr.count
    let penultIndex = lastIndex - 1
    var j = 0
    var  itemPlas = 0
    var  itemMin = 0
    var i = 0
    var itemI = 0
    var itemJ = 0
    var count = 0
    
    
    while ( i < penultIndex) {
        itemI = arr[i]
        itemPlas = itemI + k
        itemMin = itemI - k
        count = 0
        j = i + 1
        while ( j < lastIndex) {
            itemJ = arr[j]
            if (itemJ == itemPlas ) {
                count += 1
                if (itemMin < 1) { j = lastIndex }
            }
            else if (itemJ == itemMin) {
                count += 1
            }
            if (count > 1) { j = lastIndex }
            j += 1
        }
        countPairs += count
        i += 1
    }
    return countPairs
}

let k = 2
let arr = [1, 5, 3, 4, 2]

var result = pairs(k: k, arr: arr)
print(result)
print("-------")
