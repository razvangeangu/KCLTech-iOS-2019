import Foundation

/*:
 # Recap quiz
 Let's see how much you remember from our first session (101). Complete the next set of challenges and ask for any help if you encounter any difficulties.
 */
/*:
 ## Constants
 Find what the permeability of free space is (and its' symbol) and declare a constant that store that value. Finally, print it on the screen and include its' measurement units in the string.
 */
/* Your code goes here */
let µ = 4 * .pi * pow(10, -6)
print("The physical constant \(µ) H/m commonly called vacuum permeability or magnetic constant is an ideal constant used to define the through Maxwell's equations the free space.")
/*:
 ## Dictionaries
 Use a data structure to represent the houses you belong to in the Department of Informatics. It should map the name of the house to some names of people representing that house. (hint: Răzvan belongs to Lovelace) Feel free to ask around who belongs to which house.
 */
/* Your code goes here */
let houses = ["Lovelace": ["Răzvan", "Martin"], "Babbage": ["Andrew"], "Turing": ["Alex"]]
/*:
 ## Loops
 Complete the following code to be able to print the name of the house and the number of people  belonging to it. Use the words "to be" and "student/s" in your string and articulate them based on the number of people in a house. If Răzvan appears to be in a house, print something of your choice.
 */
/* Your code goes here */
for house in houses {
    let peopleCount = house.value.count
    print("For \(house.key) there \(peopleCount > 1 ? "are" : "is") \(house.value.count) \(peopleCount > 1 ? "students" : "student").")
    
    guard house.value.firstIndex(of: "Răzvan") != nil else { continue }
    print("Răzvan belongs to \(house.key)")
}
/*:
 ## Functions
 Create a function that verifies if a string is a palindrome. A string is a palindrome if its' mirror is effectively equal to the original (e.g. Madam, I'm Adam)
 */
/* Your code goes here */
func isPalindrome(_ string: String) -> Bool {
    let filteredString = string.lowercased().filter({ NSCharacterSet.lowercaseLetters.contains($0.unicodeScalars.first!) })
    return filteredString == String(filteredString.reversed())
}

isPalindrome("Madam, I'm Adam")
