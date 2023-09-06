//
//  SequenceGroupSpec.swift
//  CollectionExtension_Tests
//
//  Created by Nayanda Haberty on 6/9/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import Quick
import Nimble
import CollectionExtension

class SequenceGroupSpec: QuickSpec {
    
    override class func spec() {
        it("should group sequence") {
            let grouped = [1, 2, 2, 3, 3, 3].group { "\($0)" }
            let expected = ["1": [1], "2": [2, 2], "3": [3, 3, 3]]
            expect(grouped).to(equal(expected))
        }
        it("should group sequence using keypath") {
            let grouped = [1, 2, 2, 3, 3, 3].group(by: \.description)
            let expected = ["1": [1], "2": [2, 2], "3": [3, 3, 3]]
            expect(grouped).to(equal(expected))
        }
        it("should transform to dictionary") {
            let dictionary = try [1, 2, 3].transformToDictionary { index, _ in
                return index
            }
            let expected = [0: 1, 1: 2, 2: 3]
            expect(dictionary).to(equal(expected))
        }
        it("should throw error") {
            expect {
                try [1, 2, 2, 3].transformToDictionary { _, element in
                    return element
                }
            }
            .to(throwError(CollectionExtensionError.duplicatedKey))
        }
        it("should transform to dictionary") {
            let dictionary = try [1, 2, 3].transformToDictionary(keyedBy: \.description)
            let expected = ["1": 1, "2": 2, "3": 3]
            expect(dictionary).to(equal(expected))
        }
    }
}
    
