# CollectionExtension

**CollectionExtension** is a versatile collection of extensions and utilities for arrays, dictionaries, sequences, and various collection types in Swift. These extensions offer added functionality for performing various operations on collections.

[![Codacy Badge](https://app.codacy.com/project/badge/Grade/64f3d05c9de64449b767a506097e52a2)](https://app.codacy.com/gh/hainayanda/CollectionExtension/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
![build](https://github.com/hainayanda/CollectionExtension/workflows/build/badge.svg)
![test](https://github.com/hainayanda/CollectionExtension/workflows/test/badge.svg)
[![SwiftPM Compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen)](https://swift.org/package-manager/)
[![Version](https://img.shields.io/cocoapods/v/CollectionExtension.svg?style=flat)](https://cocoapods.org/pods/CollectionExtension)
[![License](https://img.shields.io/cocoapods/l/CollectionExtension.svg?style=flat)](https://cocoapods.org/pods/CollectionExtension)
[![Platform](https://img.shields.io/cocoapods/p/CollectionExtension.svg?style=flat)](https://cocoapods.org/pods/CollectionExtension)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Swift 5.0 or higher (or 5.3 when using Swift Package Manager)
- iOS 10.0 or higher
- macOS 10.0 or higher (for Swift Package Manager)
- tvOS 10.10 or higher (for Swift Package Manager)

## Installation

### Cocoapods

CollectionExtension is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'CollectionExtension'
```

### Swift Package Manager (Xcode)

To install using Xcode's Swift Package Manager, follow these steps:

- Go to **File > Swift Package > Add Package Dependency**
- Enter the URL: **<https://github.com/hainayanda/CollectionExtension.git>**
- Choose **Up to Next Major** for the version rule and set the version to **1.0.0**.
- Click "Next" and wait for the package to be fetched.

### Swift Package Manager (Package.swift)

If you prefer using Package.swift, add CollectionExtension as a dependency in your **Package.swift** file:

```swift
dependencies: [
    .package(url: "https://github.com/hainayanda/CollectionExtension.git", .upToNextMajor(from: "1.0.0"))
]
```

Then, include it in your target:

```swift
 .target(
    name: "MyModule",
    dependencies: ["CollectionExtension"]
)
```

## Usage

### Safe Subscript (Array and Any Collection)

The safe subscript allows you to access elements with an index, returning nil if the index is out of bounds:

```swift
let safeResult = myArray[safe: 100] // Returns nil if out of bounds
myArray[safe: 100] = someValue // Safely sets the value, does nothing if out of bounds or appends if index equals count
myArray[safe: 10] = nil // Safely removes the element
```

### Type Erase (Any Sequence and Lazy Sequence)

Type erasing a sequence is made easy:

```swift
let typeErased: AnySequence<Some> = myArray.eraseToAnySequence()
let lazyTypeErased: AnyLazySequence<Some> = myArray.lazy.eraseToAnyLazySequence()
```

### Distinction (Any Sequence and Lazy Sequence)

Easily filter duplicated elements from a sequence while preserving order:

```swift
let uniqueArray = myArray.unique // Removes duplicates and keeps order
```

You can also specify custom comparison logic if your elements are not equatable:

```swift
let uniqueArray = myArray.distinct { $0.identifier } // Using projection
let uniqueArray = myArray.distinct { $0.identifier == $1.identifier } // Using closure
let uniqueArray = myArray.distinct(by: \.identifier) // Using keypath
let uniqueArray = myArray.uniqueInstances // Using object identifier
```

### Create a New Array with an Added Element (Array)

Create a new array by adding an element:

```swift
let myArray = [1, 2]
let oneToThree = myArray.added(with: 3) // [1, 2, 3]
let oneToFive = myArray.added(withContentsOf: [4, 5]) // [1, 2, 3, 4, 5]
```

### Append and Insert Distinct Elements (Array)

Append or insert distinct elements while maintaining order:

```swift
let myArray = [3, 4]
myArray.appendIfDistinct(4) // Appends 4 if not already present
myArray.appendAllDistinct(in: [4, 5]) // Appends all distinct elements
myArray.insertIfDistinct(4, at: 0) // Inserts 4 if not already present
myArray.insertAllDistinct(in: [1, 2, 3, 4], at: 0) // Inserts all distinct elements
```

You can also create new arrays instead of modifying the original:

```swift
let addedArray = myArray.addedIfDistinct(4)
```

You can also specify custom comparison logic if your elements are not equatable:

```swift
myArray.appendIfDistinct(some) { $0.identifier } // Using projection
myArray.appendIfDistinct(some) { $0.identifier == $1.identifier } // Using closure
myArray.appendIfDistinct(some, using: \.identifier) // Using keypath
myArray.appendIfDistinctInstance(some) // Using object identifier
```

### Subtract, Intersect, and Get Symmetric Difference (Any Sequence and Lazy Sequence)

Perform set operations with ease while maintaining order:

```swift
let subtracted = left.subtract(by: right) // Subtract elements from left
let intersect = left.intersect(by: right) // Get the intersection of elements
let symmetricDifference = left.symmetricDifference(with: right) // Get symmetric difference
```

You can also specify custom comparison logic if your elements are not equatable:

```swift
let substracted myArray.substract(by: some) { $0.identifier } // Using projection
let substracted myArray.substract(by: some) { $0.identifier == $1.identifier } // Using closure
let substracted myArray.substract(by: some, by: \.identifier) // Using keypath
let substracted myArray.substractInstances(some) // Using object identifier
```

### Drop Elements Until and After a Condition (Any Sequence and Lazy Sequence)

Drop elements until or after a specific condition is met:

```swift
let array = [1, 2, 3, 4, 5]
let subtracted = left.dropAllUntil { $0 == 3 } // Drops until condition is met
let subtracted = left.dropAllAfter { $0 == 3 } // Drops after condition is met
```

if the element is equatable you can do this:

```swift
let array = [1, 2, 3, 4, 5]
let substracted1 = left.dropAllUntil(find: 3)
let substracted2 = left.dropAllAfter(find: 3)
```

### Statistics (Any Collection)

Calculate basic statistics like sum, median, average, and more:

```swift
let array = [1, 2, 3, 4, 5]
let median: Median<Int> = array.median // Calculate median (.single(3))
let sum = array.sum // Calculate sum (15)
let average = array.average // Calculate average (3)
let smallest = array.smallest // Find the smallest element (1)
let biggest = array.biggest // Find the largest element (5)
```

We can count elements like modus and frequency too:

```swift
let array = [1, 1, 1, 2, 2, 3, 3, 3, 3]
let modus = array.modus // Search modus
let twoCount = array.elementCount(2) // Calculate count of 2
let group = array.groupedByFrequency() // Group by frequency ([1: 2, 2: 2, 3: 4])
```

You can also specify custom comparison logic if your elements are not equatable:

```swift
// using projection
myArray.modus { $0.identifier } // Using projection
myArray.modus { $0.identifier == $1.identifier } // Using closure
myArray.modus(by: \.identifier) // Using keypath
myArray.modusInstances // Using object identifier
```

### Grouping Elements (Any Sequence)

Group elements based on a condition:

```swift
let array = [1, 2, 3, 4, 5]
let group = array.group { $0 % 2 == 0 ? "even": "odd" } // Group by condition (["even": [2, 4], "odd": [1, 3, 5]])
```

Or using keyPath:

```swift
let group = array.group(by: \.someProperty)
```

### Transform to a Dictionary (Any Sequence)

Transform a sequence into a dictionary:

```swift
let group1 = try array.transformToDictionary { $0.identifier } // Using closure
let group2 = try array.transformToDictionary(keyedBy: \.identifier) // Using keypath
```

If the key is duplicated, it will throw `CollectionExtensionError.duplicatedKey`

### Map Keys and Values (any Dictionary)

Transform dictionary keys while keeping the values:

```swift
let result = myDictionary.mapKeys { $0.identifier } // Map keys
```

If the key is duplicated, it will throw `CollectionExtensionError.duplicatedKey`

If you want to overwrite the duplicated key with the next value found, use `overwriteMapKeys` instead:

```swift
let result = myDictionary.overwriteMapKeys { $0.identifier }
```

You can use `compactMapKeys` if you want to ignore the key that cannot produce a value:

```swift
let result = myDictionary.compactMapKeys { $0.identifier }
```

If the key is duplicated, it will throw `CollectionExtensionError.duplicatedKey`

If you want to overwrite the duplicated key with the next value found while using `compactMapKeys`, use `overwriteCompactMapKeys` instead:

```swift
let result = myDictionary.overwriteCompactMapKeys { $0.identifier }
```

If you need a key and value to produce a new key, use:

- `mapKeyValues` instead of `mapKeys`
- `overwriteMapKeysValues` instead of `overwriteMapKeys`
- `compactMapKeysValues` instead of `compactMapKeys`
- `overwriteCompactMapKeysValues` instead of `overwriteCompactMapKeys`

### Asynchronous Iteration (Any Sequence)

Iterate asynchronously while preserving sequence order:

```swift
array.asyncForEach { element in
    await element.someTask()
}

array.asyncForEachIgnoreError { element in
    try await element.someTaskWithError()
}

array.asyncMap { element in
    await element.produceSomeValue()
}

array.asyncMapSkipError { element in
    try await element.produceSomeValueWithError()
}
```

You can also use Combine Future instead of async/await:

- `futureForEach` instead of `asyncForEach`
- `futureForEachIgnoreError` instead of `asyncForEachIgnoreError`
- `futureMap` instead of `asyncMap`
- `futureMapSkipError` instead of `asyncMapSkipError`
- `futureCompactMap` instead of `asyncCompactMap`
- `futureCompactMapSkipError` instead of `asyncCompactMapSkipError`

### Doubly Linked List

The library provides a DoublyLinkedList class for further collection management.

---

## Contribute

Feel free to contribute by cloning the repository and creating pull requests.

## Author

Nayanda Haberty, <hainayanda@outlook.com>

## License

CombineAsync is available under the MIT license. See the LICENSE file for more info.
