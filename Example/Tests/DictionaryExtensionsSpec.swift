//
//  DictionaryExtensionsSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 23/8/23.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class DictionaryExtensionsSpec: QuickSpec {
    
    // swiftlint:disable function_body_length
    override class func spec() {
        let dictionary = [1: "one", 2: "two", 3: "three", 4: "four", 5: "five"]
        it("should map dictionary keys") {
            let newDictionary = try dictionary.mapKeys { "\($0)" }
            expect(newDictionary).to(equal(["1": "one", "2": "two", "3": "three", "4": "four", "5": "five"]))
        }
        it("should error map to dictionary on duplicated") {
            expect(try dictionary.mapKeys { _ in "1" }).to(throwError())
        }
        it("should overwrite map to dictionary on duplicated") {
            let newDictionary = dictionary.overwriteMapKeys { "\($0%2)" }
            expect(newDictionary["0"]).toNot(beNil())
            expect(newDictionary["1"]).toNot(beNil())
            expect(newDictionary["2"]).to(beNil())
            expect(newDictionary["3"]).to(beNil())
            expect(newDictionary["4"]).to(beNil())
            expect(newDictionary["5"]).to(beNil())
        }
        it("should compact map dictionary keys") {
            let newDictionary = try dictionary.compactMapKeys { $0 < 5 ? "\($0)": nil }
            expect(newDictionary).to(equal(["1": "one", "2": "two", "3": "three", "4": "four"]))
        }
        it("should error compact map to dictionary on duplicated") {
            expect(try dictionary.compactMapKeys { _ in "1" }).to(throwError())
        }
        it("should overwrite map to dictionary on duplicated") {
            let newDictionary = dictionary.overwriteCompactMapKeys { $0 < 2 ? "0": "1" }
            expect(newDictionary["0"]).toNot(beNil())
            expect(newDictionary["1"]).toNot(beNil())
            expect(newDictionary["2"]).to(beNil())
            expect(newDictionary["3"]).to(beNil())
            expect(newDictionary["4"]).to(beNil())
            expect(newDictionary["5"]).to(beNil())
        }
        it("should map dictionary keys and value") {
            let newDictionary = try dictionary.mapKeyValues { ($1, $0) }
            expect(newDictionary).to(equal(["one": 1, "two": 2, "three": 3, "four": 4, "five": 5]))
        }
        it("should overwrite map dictionary keys and value") {
            let newDictionary = dictionary.overwriteMapKeyValues { key, _ in ("\(key%2)", key) }
            expect(newDictionary.count).to(equal(2))
        }
        it("should error map to dictionary on duplicated") {
            expect(try dictionary.mapKeyValues { _, _ in ("1", 1) }).to(throwError())
        }
        it("should compact map dictionary keys and value") {
            let newDictionary = try dictionary.compactMapKeyValues { $0 < 5 ? ($1, $0): nil }
            expect(newDictionary).to(equal(["one": 1, "two": 2, "three": 3, "four": 4]))
        }
        it("should error compact map to dictionary on duplicated") {
            expect(try dictionary.compactMapKeyValues { _, _ in ("1", 1) }).to(throwError())
        }
        it("should overwrite compact map dictionary keys and value") {
            let newDictionary = dictionary.overwriteCompactMapKeyValues { key, _ in ("\(key%2)", key) }
            expect(newDictionary.count).to(equal(2))
        }
        it("should return true if contains key") {
            expect(dictionary.contains(key: 1)).to(beTrue())
        }
        it("should return false if not contains key") {
            expect(dictionary.contains(key: 6)).to(beFalse())
        }
        it("should return true if contains value") {
            expect(dictionary.contains(value: "one")).to(beTrue())
        }
        it("should return false if not contains value") {
            expect(dictionary.contains(value: "six")).to(beFalse())
        }
    }
    // swiftlint:enable function_body_length
}
