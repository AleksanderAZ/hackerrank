import UIKit
import Foundation

// Complete the pairs function below.
func pairs(k: Int, arr: [Int]) -> Int {
    
    let sizeArr = arr.count
    guard sizeArr > 1 else { return 0 }
    let lastIndex: Int = sizeArr - 1
    var countPairs: Int = 0
    
    var newArr = arr.sorted()
    
    var subtr = 0
    var i = lastIndex
    while i > 0 {
        var j = i - 1
            subtr = newArr[i] - newArr[0]
            if(subtr < k) {
            }
            else {
                if(subtr == k) {
                    countPairs += 1
                }
                while j > 0 {
                    subtr = newArr[i] - newArr[j]
                    if(subtr > k) {
                        j = -1
                    }
                    else {
                        if(subtr == k) {
                            countPairs += 1
                        }
                        j -= 1
                    }
                }
            }
        i -= 1
    }
    
    return countPairs
}

let k = 2
let arr = [1, 5, 3, 4, 2]

let result = pairs(k: k, arr: arr)
print(result)
