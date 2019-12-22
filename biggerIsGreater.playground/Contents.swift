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
    let key = i-1
    var j = lastIndex
    while ((j > i) && (charArray[key] >= charArray[j])) {
        j -= 1
    }
    charArray.swapAt(key, j)
    let result = String(charArray[0...key]) + String(charArray[i...lastIndex].reversed())
    return result
}

var x = "abccc"
for _ in 0...100 {
    print(x)
    x = biggerIsGreater(w: x)
    if (x == "no answre") { break }
}

