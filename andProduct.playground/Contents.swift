import UIKit

var str = "Hello, playground"

func andProduct(a: Int, b: Int) -> Int {
    
    var result = a
    let start = a + 1
    for item in start...b {
        result = result & item
    }
    return result
}

let a = 2
let b = 3

    let result = andProduct(a: a, b: b)
    
print(result)

