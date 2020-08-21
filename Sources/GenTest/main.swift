import Foundation

func ...(lhs: CountableClosedRange<Int>, rhs: Int) -> [Int] {
    let downwards = (rhs ..< lhs.upperBound).reversed()
    return Array(lhs) + downwards
}

precedencegroup RangeFormationPrecedence {
    higherThan: CastingPrecedence
    associativity: left
}

infix operator ... : RangeFormationPrecedence

let range = 1...10...1
print(range)

let greetPerson = {
    print("Hello THere!")
}
greetPerson()

let greatCopy = greetPerson

greatCopy()

func runSomeClosure(_ closure: ()->Void) {
    closure()
}

runSomeClosure(greetPerson)

let greetSpecificPerson  = { (someName: String)->Void in
    print("Hello \(someName)")
}

greetSpecificPerson("Santhosh")

let greetSpecificPerson1 = { (name: String) in
    print("Hello \(name)")
}

greetSpecificPerson1("Snow")

func runSomeClosureWithParam(_ closure: (String)->Void) -> Void {
    closure("Santhosh")
}

runSomeClosureWithParam(greetSpecificPerson1)

// Capturing

func testCapture() -> () -> Void {
    var counter = 0
    return {
        counter += 1
        print("Counter is now \(counter)")
    }
}

let count1 = testCapture()
count1()
count1()
count1()

let countCopy = count1
countCopy()
countCopy()
countCopy()


let names = ["Sant Snow", "Sant sant", "Sweta Sant", "Snow snow"]

let result1 = names.filter({ (name:String)-> Bool in
    if name.hasPrefix("Snow") {
        return true
    } else {
        return false
    }
})
print("\(result1)")


let result2 = names.filter({ name in
    if name.hasPrefix("Snow") {
        return true
    } else {
        return false
    }
})
print("\(result2)")

let result3 = names.filter({ name in
    return name.hasPrefix("Santhosh")
})


let result4 = names.filter{ name in
    return name.hasPrefix("Santhosh")
}

let result5 = names.filter{ name in
    name.hasPrefix("Santhosh")
}

let result6 = names.filter { $0.hasPrefix("Santhosh")}

let numbers = [1,2,3,4,5]
let val = numbers.reduce(0) { (int1, int2) -> Int in
    return int1 + int2
}
print(val)

let numbers1 = [1,2,3,4,5]
let val1 = numbers1.reduce(0, +)
print(val)

var queedClousures : [()->Void] = []

func queueClousure(_ closure: @escaping ()->Void) {
    queedClousures.append(closure)
}

queueClousure({print("Running closure1")})
queueClousure({print("Running closure2")})
queueClousure({print("Running closure3")})

func executeQueuedClosures() {
    for closure in queedClousures {
        closure()
    }
}

executeQueuedClosures()

// Autoclosure

func printTest(_ result: ()->Void) {
    print("Before")
    result()
    print("After")
}

printTest({print("Hello")})

// Before
// Hello
// After


func printTestAutoClosure(_ result: @autoclosure ()->Void) {
    print("Before")
    result()
    print("After")
}
// Notice that there is no "{}"
printTestAutoClosure(print("Hello"))

// Before
// Hello
// After

let names1 = ["Taylor", "Paul", "Adel"]

let count = names1.reduce(0) { $0+$1.count}
print(count)

let num: [[Int]] = [[1,1,1], [2,2,2], [3,3,3]]

let flat1 = num.reduce([]) {$0 + $1}
print(flat1)

let flat2 = num.compactMap { $0 }
print(" comapt map \(flat2) ")

let flat3 = Array(num.joined())
print(flat3)

let optStr: [String?] = ["Santhosh", nil , "Sweta"]
let compactOptStr = optStr.compactMap {$0}
print(compactOptStr)

let scores = [100, 200, 89, 8 ]
let sum = scores.reduce(0, +)
let sum1 = scores.reduce(0) { $0 + $1}

let resultStr = scores.reduce("") { $0 + String($1)}
print("String version after reduec = \(resultStr)")

let greater = scores.reduce(0) {$0 + (($1 > 30) ? 1 : 0)}
print(greater)

extension Int {
    init(_ boolean:Bool) {
        self = boolean ? 1 : 0
    }
}

let greater1 = scores.reduce(0) {$0 + Int($1 > 30)}
print(greater1)

let v = scores.prefix(upTo: 1)
print(v)

let u = scores.prefix(through: 1)
print(u)

let t = scores.prefix(5)
print(t)

extension BinaryInteger {
    /*
    func clamp(low:Self, high:Self) -> Self{
        if self < low {
            return low
        } else if self > high {
            return high
        } else {
            return self
        }
    } */
    func clamp(low: Self, high:Self) -> Self {
        return min(max(self, low), high)
    }
}

print(8.clamp(low: 5, high: 10))
print(3.clamp(low: 5, high: 10))
print(800.clamp(low: 5, high: 100))

extension BinaryInteger {
    func compare(array:[Self]) -> Bool {
        for item in array {
            if item != self {
                return false
            }
        }
        return true
    }
}

print(2.compare(array: [2,2,2,2]))
print(2.compare(array: [2,2,2,3]))

extension Comparable {
    func lessThan(array:[Self]) -> Bool {
        for item in array {
            if self >= item {
                return false
            }
        }
        return true
    }
}

print(5.lessThan(array:[6,7,8]))
print(5.lessThan(array:[5,7,8]))
print("cat".lessThan(array:["dog", "fish"]))


//extension Collection where Iterator.Element: Equatable {
extension Collection where Iterator.Element: Equatable{
    func myContains(element: Iterator.Element) -> Bool {
        for item in self {
            if item == element {
                return true
            }
        }
        return false
    }
}

let a = Array(1...10)
print("mycontains \(a.myContains(element: 5))")

extension Collection where Iterator.Element: Comparable {
    func fuzzyMatches(_ other: Self) -> Bool {
        let usSorted = self.sorted()
        let otherSorted = other.sorted()
        return usSorted == otherSorted
    }
}

print([1,2,3].fuzzyMatches([1,2,3]))
print([1,2,3].fuzzyMatches([2,3,1]))
print([1,2,3].fuzzyMatches([3,1]))

extension Collection where Iterator.Element == Int {
    func numberof5s() -> Int {
        var count = 0
        for item in self {
            let str = String(item)
            for c in str {
                if c == "5" {
                    count += 1
                }
            }
        }
        return count
    }
}

let q = [1,2,3,5,15,53].numberof5s()
print(q)

extension Array where Element: Comparable {
    func isSorted() -> Bool {
        return self == self.sorted()
    }
}