//
//  WordModel.swift
//  UIKitDynamicsApp
//
//  Created by GEORGE QUENTIN on 13/04/2016.
//  Copyright © 2016 RealEx. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

extension String {
    
    
    public static func randomVowels(excludedVowelsCharacter: Character? = nil) -> String {
        
        let vowels = "aeiou"
        let filtered = String(vowels
            .characters
            .filter { char in char != excludedVowelsCharacter }
        )
        
        let allowedVowelsCount = filtered.characters.count
        let randomNum = Int.random(0, max: allowedVowelsCount-1) 
        let randomVowel = String(filtered[filtered.startIndex.advancedBy(randomNum)])
        
        return  randomVowel
        
    }
    
    public static func randomConsonants(excludedConsonantCharacter: Character? = nil) -> String {
        
        let consonants = "bcdfghjklmnpqrstvwxyz"
        let filtered = String(consonants
            .characters
            .filter { char in char != excludedConsonantCharacter }
        )
        
        let allowedConsonantsCount = filtered.characters.count
        let randomNum = Int.random(0,max:allowedConsonantsCount-1)
        let randomConsonant = String(filtered[filtered.startIndex.advancedBy(randomNum)])
        
        return randomConsonant
    }
   
    
    public static func wordList(word:String) -> [String]
    {
        var wordArr = [String]()
        word.enumerateSubstringsInRange(word.startIndex..<word.endIndex, options: .ByWords) { 
            ss, r, r2, stop in
            wordArr.append(ss!)
        }
        return wordArr
    }
    
}

