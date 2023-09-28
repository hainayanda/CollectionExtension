# CollectionExtension

Collection of Array, Sequence, and any Collection extensions

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

### Only Swift Package Manager

- macOS 10.0 or higher
- tvOS 10.10 or higher

## Installation

### Cocoapods

CollectionExtension is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CollectionExtension'
```

### Swift Package Manager from XCode

- Add it using XCode menu **File > Swift Package > Add Package Dependency**
- Add **<https://github.com/hainayanda/CollectionExtension.git>** as Swift Package URL
- Set rules at **version**, with **Up to Next Major** option and put **1.0.0** as its version
- Click next and wait

### Swift Package Manager from Package.swift

Add as your target dependency in **Package.swift**

```swift
dependencies: [
  .package(url: "https://github.com/hainayanda/CollectionExtension.git", .upToNextMajor(from: "1.0.0"))
]
```

Use it in your target as `CollectionExtension`

```swift
 .target(
    name: "MyModule",
    dependencies: ["CollectionExtension"]
)
```

## Author

hainayanda, hainayanda@outlook.com

## License

CollectionExtension is available under the MIT license. See the LICENSE file for more info.

---

## Basic Usage

`CollectionExtension` is a collection of Array, Dictionary, Sequence, and Collection extensions that can be used for more complex operations. Here is the list of extension functionality that is included in this library.

### Safe subscript (Array and any Collection except the set part, only available in Array)

A subscript but will return nil if the index is out of bounds:

```swift
// if the array count is less than 100, it will return a nil
let safeResult = myArray[safe: 100]

// if the array count is less than 100, it will do nothing
myArray[safe: 100] = someValue

// if 10 is in bounds, it will remove the value at index 10
myArray[safe: 10] = nil

// if 10 is the same as count, it will do append instead
myArray[safe: 10] = someValue
```

### Type erase (any Sequence and LazySequence)

Type erasing `Sequence` is now easier with functional style:

```swift
let typeErased: AnySequence<Some> = myArray.eraseToAnySequence()

let lazyTypeErased: AnyLazySequence<Some> = myArray.lazy.eraseToAnyLazySequence()
```

### Distinction (any Sequence and LazySequence)

Filtering duplicated elements from `Sequence` is now easier without compromising performance while keeping its order:

```swift
let myArray = [1, 1, 2, 3, 4, 4]

// will contain [1, 2, 3, 4]
let uniqueArray = myArray.unique
```

If your element is not equatable, you can use the `distinct` method with KeyPath, projection, or closure comparison instead:

```swift
// using projection
let uniqueArray = myArray.distinct { $0.identifier }

// using closure
let uniqueArray = myArray.distinct { $0.identifier == $1.identifier }

// using keypath
let uniqueArray = myArray.distinct(by: \.identifier)

// using object identifier if the element is a class instance
let uniqueArray = myArray.uniqueInstances
```

### Create a new array with an added element (Array)

Instead of appending the original array, using added will create a new array that contains the original array added with a new element:

```swift
let myArray = [1, 2]

// [1, 2, 3]
let oneToThree = myArray.added(with: 3)

// [1, 2, 3, 4, 5]
let oneToFive = myArray.added(withContentsOf: [4, 5])
```

### Append and Insert distinct element (Array)

Appending and inserting distinct elements will be easier without compromising performance while keeping its order:

```swift
let myArray = [3, 4]

// will still contain [3, 4]
myArray.appendIfDistinct(4)

// will contain [3, 4, 5]
myArray.appendAllDistinct(in: [3, 4, 5])

// will contain [3, 4, 5]
myArray.insertIfDistinct(4, at: 0)

// will contain [1, 2, 3, 4, 5]
myArray.insertAllDistinct(in: [1, 2, 3, 4], at: 0)
```

If you prefer to create a new array instead of appending the original array, use addedIfDistinct/addedAllDistinct or insertedIfDistinct/insertedAllDistinct instead. Example:

```swift
let addedArray = myArray.addedIfDistinct(4)
```

If your element is not equatable, you can use KeyPath, projection, or closure comparison instead. It applies to addedIfDistinct/addedAllDistinct or insertedIfDistinct/insertedAllDistinct too:

```swift
// using projection
myArray.appendIfDistinct(some) { $0.identifier }

// using closure
myArray.appendIfDistinct(some) { $0.identifier == $1.identifier }

// using keypath
myArray.appendIfDistinct(some, using: \.identifier)

// using object identifier if the element is a class instance
myArray.appendIfDistinctInstance(some)
```

### Substract, Intersection, Symmetric Difference (any Sequence and LazySequence)

Subtracting, Intersecting, and getting symmetric differences between sequences is very easy:

```swift
let left = [1, 2, 3, 4]
let right = [3, 4, 5, 6]

// [1, 2]
let substracted = left.substract(by: right)

// [3, 4]
let intersect = left.intersect(by: right)

// [1, 2, 5, 6]
let symetricDifference = left.symetricDifference(with: right)
```

As with any other extensions here, if the element is not equatable, simply use KeyPath, projection, or closure comparison instead. Example:

```swift
// using projection
let substracted myArray.substract(by: some) { $0.identifier }

// using closure
let substracted myArray.substract(by: some) { $0.identifier == $1.identifier }

// using keypath
let substracted myArray.substract(by: some, by: \.identifier)

// using object identifier if the element is class instance
let substracted myArray.substractInstances(some)
```

### Dropping the element (any Sequence and LazySequence)

Dropping the element until/after the element is found is very easy:

```swift
let array = [1, 2, 3, 4, 5]

// [3, 4, 5]
let substracted = left.dropAllUntil { $0 == 3 }

// [1, 2, 3]
let substracted = left.dropAllAfter { $0 == 3 }
```

if the element is equatable you can do this instead:

```swift
let array = [1, 2, 3, 4, 5]

// [3, 4, 5]
let substracted = left.dropAllUntil(find: 3)

// [1, 2, 3]
let substracted = left.dropAllAfter(find: 3)
```

### Statistic (any Collection)

Some extensions can be used to perform a basic statistic operation, like sum, median, average, etc:

```swift
let array = [1, 2, 3, 4, 5]

// will produce .single(3)
let median: Median<Int> = array.median 

// will produce 15
let sum = array.sum 

// will produce 3
let sum = array.average 

// will produce 1
let smallest = array.smallest 

// will produce 5
let biggest = array.biggest 
```

We can count elements like modus and frequency too:

```swift
let array = [1, 1, 1, 2, 2, 3, 3, 3, 3]

// will produce 3
let modus = array.modus 

// will produce 2
let twoCount = array.elementCount(2) 

// will produce [1: 2, 2: 2, 3: 4]
let group = array.groupedByFrequency()
```

Of course, if the element is not equatable we can simply use KeyPath, projection, or closure comparison instead. Example:

```swift
// using projection
myArray.modus { $0.identifier }

// using closure
myArray.modus { $0.identifier == $1.identifier }

// using keypath
myArray.modus(by: \.identifier)

// using object identifier if the element is a class instance
myArray.modusInstances
```

### Grouping element (any Sequence)

We can group elements into the dictionary of the array element:

```swift
let array = [1, 2, 3, 4, 5]

// will produce ["even": [2, 4], "odd": [1, 3, 5]]
let group = array.group { $0 % 2 == 0 ? "even": "odd" }
```

Or using keyPath:

```swift
let group = array.group(by: \.someProperty)
```

### Transform to a dictionary (any Sequence)

You can transform any sequence to a dictionary similar to grouping the elements, but the value will be an element instead of an array of elements:

```swift
// using closure
let group = try array.transformToDictionary { $0.identifier }

// using keypath
let group = try array.transformToDictionary(keyedBy: \.identifier)
```

The only drawback here is, if the key is duplicated, it will throw `CollectionExtensionError.duplicatedKey`

### Map Keys and Values (any Dictionary)

You can transform any Dictionary to another with different keys but the same value using the `mapKeys` method:

```swift
let result = myDictionary.mapKeys { $0.identifier }
```

Keep in mind that if the key is duplicated, it will throw `CollectionExtensionError.duplicatedKey`

If you want to overwrite the duplicated key with the next value found, use `overwriteMapKeys` instead:

```swift
let result = myDictionary.overwriteMapKeys { $0.identifier }
```

You can use `compactMapKeys` if you want to ignore the key that cannot produce a value:

```swift
let result = myDictionary.compactMapKeys { $0.identifier }
```

Keep in mind that if the key is duplicated, it will throw `CollectionExtensionError.duplicatedKey`

If you want to overwrite the duplicated key with the next value found while using `compactMapKeys`, use `overwriteCompactMapKeys` instead:

```swift
let result = myDictionary.overwriteCompactMapKeys { $0.identifier }
```

If you need a key and value to produce a new key, use:
- `mapKeyValues` instead of `mapKeys`
- `overwriteMapKeysValues` instead of `overwriteMapKeys`
- `compactMapKeysValues` instead of `compactMapKeys`
- `overwriteCompactMapKeysValues` instead of `overwriteCompactMapKeys`

### Async iteration (any Sequence)

Sometimes you want to iterate using forEach or map but the operation is async and you need to keep the sequence order. This can be done with this library:

```swift
// regular
array.asyncForEach { element in
    await element.someTask()
}

// keep iterating even if there's an error in some task
array.asyncForEachIgnoreError { element in
    try await element.someTaskWithError()
}

// regular, if needed you can use asyncCompactMap
array.asyncMap { element in
    await element.produceSomeValue()
}

// keep iterating even if there's an error in some task, if needed you can use asyncCompactMapSkipError
array.asyncMapSkipError { element in
    try await element.produceSomeValueWithError()
}
```

If you prefer using Combine Future instead of Async Await, use:
- `futureForEach` instead of `asyncForEach`
- `futureForEachIgnoreError` instead of `asyncForEachIgnoreError`
- `futureMap` instead of `asyncMap`
- `futureMapSkipError` instead of `asyncMapSkipError`
- `futureCompactMap` instead of `asyncCompactMap`
- `futureCompactMapSkipError` instead of `asyncCompactMapSkipError`

### Extra

`DoublyLinkedList` class to use if needed which implements `Sequence` and `Collection`

---

## Contribute

You know-how. Just clone and do a pull request
