import UIKit

import Foundation

// Complete the biggerIsGreater function below.
func biggerIsGreater(w: String) -> String {
    let size = w.count
    let lastIndex = size - 1
    var charArray = Array(w)
    var i = lastIndex
    guard i > 0 else { return "no answer" }
    while (charArray[i-1] >= charArray[i]) {
        i -= 1
        guard i > 0 else { return "no answer" }
    }
    var j = lastIndex
    let key = i-1
    var chang = i
    print(key, i, chang, j, charArray)
    if (i < lastIndex - 2 ) {
        print("----", key, i, chang, j, charArray)
        while ((j > i) && (charArray[key] >= charArray[j])) {
            print("-1--", key, i, chang, j, charArray)
            if (charArray[key] > charArray[j]) {
                print("-11-", key, i, chang, j, charArray)
                charArray.swapAt(chang, j)
                chang += 1
            }
            
            j -= 1
            print("-12-", key, i, chang, j, charArray)
        }
        
        print("-2--", key, i, chang, j, charArray)
        charArray.swapAt(key, j)
        print("-3--", key, i, chang, j, charArray)
    }
    else {
        while ((j > i) && (charArray[key] >= charArray[j])) {
            print("-7--", key, i, chang, j, charArray)
            j -= 1
        }
        print("-4--", key, i, chang, j, charArray)
        charArray.swapAt(key, j)
        print("-5--", key, i, chang, j, charArray)
        if (i < lastIndex) {
        print("-6--", key, i, chang, j, charArray)
            charArray.swapAt(i, lastIndex)
        }
    }
    let result = String(charArray)
    return result
}

let ws = [
    "aaasssa",
    "bb",
    "hefg",
    "dhck",
    "dkhc"]

/*
 ba
 no answer
 hegf
 dhkc
 hcdk
 */
    /*"lmno",
    "dcba",
    "dcbb",
    "abdc",
    "abcd",
    "fedcbabcd"]

 lmon
 no answer
 no answer
 acbd
 abdc
 fedcbabdc
 */
for w in ws {
    print(w, biggerIsGreater(w: w))
}
print("----------------")

var x = "aaaasss"
for i in 0...100 {
    print(x)
    x = biggerIsGreater(w: x)
    if (x == "no answre") { break }
}

