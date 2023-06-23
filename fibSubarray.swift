func fibSubarray(_ start:Int, _ count:Int) -> [Int] {
    var arr = [Int]()
    var found = false
    var c = count
    var s = start
    
    // no count
    if c < 1 {
        return arr
    }
    
    // base cases
    if s == 0 {
        found = true
        arr.append(0)
        s = 1
        c -= 1
    } 
    
    if s == 1 && c > 0 {
        found = true
        arr.append(1)
        c -= 1
    }
    
    var n1 = 0
    var n2 = 1
    
    // find starting position
    while !found {
        var tmp = n2
        n2 += n1
        n1 = tmp
        
        // start found
        if s == n2 {
            found = true
            arr.append(n2)
            c -= 1
        }
        
        // start not in sequence
        else if s < n2 {
            return arr
        }
    }
    
    // get remaining nums in fib seq.
    while c > 0 {
        var tmp = n2
        n2 += n1
        n1 = tmp
        
        arr.append(n2)
        c -= 1
    }
    
    return arr
}