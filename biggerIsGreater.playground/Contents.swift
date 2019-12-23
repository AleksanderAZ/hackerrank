import UIKit
import Foundation

func biggerIsGreater(w: String) -> String {
    let size = w.count
    guard size > 1 else { return "no answer" }
    
    var i = 1
    var pref = w.prefix(size - 1)
    var suff = w.suffix(1)
    var suffPref = pref.suffix(1)
    var prefSuff = suff.prefix(1)
    if(suffPref >= prefSuff) {
        i += 1
        while (i<=size) {
            pref = w.prefix(size - i)  // head
            suff = w.suffix(i)         // xbost
            suffPref = pref.suffix(1)  // key
            prefSuff = suff.prefix(1)
            if(suffPref < prefSuff) {
                break
            }
            i += 1
        }
    }
    if i >= size { return "no answer" }
    
   
    
    let key = suffPref.first ?? " "
    let changIndex = suff.lastIndex() {(c) in c < key }  ?? suff.startIndex
    // print("-------",i,size,"   ", " ;  ", pref,";",suffPref,";",suff, " = ", prefSuff,";")
    let s = suff[...changIndex]
    let p = suff.suffix(from: changIndex)
    
    let xv = (s.count > 0 ? s.prefix(s.count-1) : "") + suffPref + (p.count > 0 ? p.suffix(p.count-1) : "")
    
    let result = String(pref.count > 1 ? pref.prefix(pref.count-1) : "") + String(suff[changIndex]) + String(xv.reversed())
 print(key," ;  ", s," ;  ", p, "-------",i,size,"  || ",suff[changIndex], " ;-  ", pref,";",suffPref,";",suff, " = ", prefSuff,";", xv)
    return result
}

//------------------------------------------------------

func biggerIsGreater2(w: String) -> String {
    let size = w.count
    guard size > 1 else { return "no answer" }
    let lastIndex = size - 1
    var i = 1
    var pref = w.prefix(size - 1)
    var suff = w.suffix(1)
    var suffPref = pref.suffix(1)
    var prefSuff = suff.prefix(1)
    if(suffPref >= prefSuff) {
        i += 1
    
        while (i<size) {
            pref = w.prefix(size - i)  // head
            suff = w.suffix(i)         // xbost
            suffPref = pref.suffix(1)  // key
            prefSuff = suff.prefix(1)
            if(suffPref < prefSuff) {
                break
            }
        i += 1
        }
    }
    if i >= size { return "no answer" }
    
    print("-------",pref,suffPref,suff)
    
    var j = 1
    let lastIndexSuff = suff.count
    prefSuff = suff.prefix(lastIndexSuff - 1)
    var suffSuff = suff.suffix(1)
    var suffPrefSuff = suffSuff.prefix(1)
    if(suffPref >= suffPrefSuff) {
        j += 1
        while (j<lastIndexSuff-i) {
            prefSuff = suff.prefix(lastIndexSuff - j)
            var suffSuff = suff.suffix(j)
            var suffPrefSuff = suffSuff.prefix(1)
            if(suffPref < suffPrefSuff) {
              break
            }
            j += 1
        }
    }
    
    print("-------",pref,suffPref,suff, " = ", prefSuff, suffPrefSuff, suffSuff)
   // if (suff.count < 2) {
   //     let result = String(pref.prefix(pref.count-1)) + String(suff) + String(suffPref)
  //      return result
  //  }
  //  else {
        let xvost = String(prefSuff) + String(suffPref) + String(suffSuff.count > 1 ? suffSuff.suffix(suffSuff.count-1) : "")
        let result = String(pref.prefix(pref.count-1)) + String(suffPrefSuff) + String(xvost.reversed())
        return result
  //  }
}

// Complete the biggerIsGreater function below.
func biggerIsGreater1(w: String) -> String {
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

var x = "cdhk"
for _ in 0...100 {
    let q = biggerIsGreater(w: x)
    let w = biggerIsGreater1(w: x)
    print(x, q, w, q == w)
    x = w
    if (x == "no answre") { break }
}

