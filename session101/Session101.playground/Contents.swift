import UIKit

var str = "Hello, playground"

//: #  Variables
var π: Double = Double.pi
var isRainy: Bool = true

//: # Type Inference
var _π = 3.14
var _isRainy = false


//: # Constants
let name: String = "Razvan"

//: # Conditional Statements
if isRainy {
    print("Who loves rain..")
}

print(isRainy ? "Today is going to rain.." : "Nice weather coming up!")

//: # Arrays
var students = [String]()

// Adding to an array
students.append("Răzvan")
students.append("Tania")
students.append(contentsOf: ["Alex", "Mahyad"])

// Slicing an array
students[...1]

// Number of elements
students.count


//: # Dictionaries
var societies = ["NMS": ["KCL Tech", "KCL Robotics"], "Physics": ["Maxwell"]]
societies["NMS"]

print(societies["NMS"] ?? "No socities for NMS") // Optional value

//: # For Loops
for i in 0...10 {
    print(i)
}

for i in 0..<10 {
    print(i)
}

for i in stride(from: 10, to: 0, by: -1) {
    print(i)
}

for student in students {
    print(student)
}

for item in societies {
    print(item.key)
    print(item.value)
}

for (index, item) in societies.enumerated() {
    print(index, item)
}

//: # While Loops
isRainy = false
while isRainy {
    // Checking the condition before running the code
    print("It is going to rain...")
}

isRainy = true
repeat {
    // Checking the condition after running the code
    print("It will stop raining")
    isRainy = false
} while isRainy

//: # Structs
struct userLocation {
    var name: String
    var latitude: Double
    var longitude: Double
}

var myLocation = userLocation(name: "Răzvan", latitude: -0.1171557, longitude: 51.5127029)

print("\(myLocation.name) can be found at lat: \(myLocation.latitude) and long: \(myLocation.longitude)")

//: # Enums
enum Direction {
    case north
    case south
    case east
    case west
    case other
}

let răzvansDirection: Direction = .north

//: # Switch
switch răzvansDirection {
case .north:
    print("Răzvan is moving to the front")
case .south:
    print("Răzvan is moving to the back")
case .east:
    print("Răzvan is moving to the right")
case .west:
    print("Răzvan is moving to the left")
default:
    print("To the left.. to the left.. to the right.. to the right.. Hit it Beyoncé")
}

//: # Functions
func reverseNumber(number: Int, _ temp: Int) -> Int {
    return number == 0 ? temp : reverseNumber(number: number / 10, (temp * 10) + (number % 10))
}

func isPalindrome(number: Int) -> Bool {
    return reverseNumber(number: number, 0) == number
}

// Calling a function
isPalindrome(number: 121)

// Void
func runMe() {
    var palindromes = [Int]()
    for i in 100...1000 {
        if isPalindrome(number: i) {
            palindromes.append(i)
        }
    }
    
    print(palindromes)
}

runMe()
