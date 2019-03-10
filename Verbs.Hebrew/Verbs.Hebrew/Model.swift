//
//  Model.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 01/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

import Foundation

struct Word {

    var infinitive   : String = ""
    var infinitiveP  : Translation?
    var typeOfVerb : TypeOfVerb = TypeOfVerb.paal
    var preposition  : String = ""
    var translation  : Translation?
    var presentTense : PresentTense?
    var pastTense    : PastTense?
    var futureTense  : FutureTense?
    var imperative   : Imperative?
    var reserve1     : String = ""
    var reserve2     : String = ""
    
}
struct WordInTense {
    var body        : String = ""
    var word        : String = ""
    var translation : String = ""
}

struct Translation {
    var russian     : String = ""
    var english     : String = ""
    var spanish     : String = ""
}

struct PresentTense {
    var masculineSingular   : String = ""
    var feminineSingular    : String = ""
    var masculinePlural     : String = ""
    var femininePlural      : String = ""
    var masculineSingularPr : Translation?
    var feminineSingularPr  : Translation?
    var masculinePluralPr   : Translation?
    var femininePluralPr    : Translation?
}

struct PastTense {
    var singular1st             : String = ""
    var masculineSingular2nd    : String = ""
    var feminineSingular2nd     : String = ""
    var masculineSingular3nd    : String = ""
    var feminineSingular3nd     : String = ""
    var plural1st               : String = ""
    var masculinePlural2nd      : String = ""
    var femininePlural2nd       : String = ""
    var plural3nd               : String = ""
    var singular1stPr           : Translation?
    var masculineSingular2ndPr  : Translation?
    var feminineSingular2ndPr   : Translation?
    var masculineSingular3ndPr  : Translation?
    var feminineSingular3ndPr   : Translation?
    var plural1stPr             : Translation?
    var masculinePlural2ndPr    : Translation?
    var femininePlural2ndPr     : Translation?
    var plural3ndPr             : Translation?
}

struct FutureTense {
    var singular1st             : String = ""
    var masculineSingular2nd    : String = ""
    var feminineSingular2nd     : String = ""
    var masculineSingular3nd    : String = ""
    var feminineSingular3nd     : String = ""
    var plural1st               : String = ""
    var masculinePlural2nd      : String = ""
    var femininePlural2nd       : String = ""
    var plural3nd               : String = ""
    var singular1stPr           : Translation?
    var masculineSingular2ndPr  : Translation?
    var feminineSingular2ndPr   : Translation?
    var masculineSingular3ndPr  : Translation?
    var feminineSingular3ndPr   : Translation?
    var plural1stPr             : Translation?
    var masculinePlural2ndPr    : Translation?
    var femininePlural2ndPr     : Translation?
    var plural3ndPr             : Translation?
}

struct Imperative {
    var masculineSingular   : String = ""
    var feminineSingular    : String = ""
    var plural              : String = ""
    var masculineSingularPr : Translation?
    var feminineSingularPr  : Translation?
    var pluralPr            : Translation?
}

struct BlackWord {
    var translation  : String = ""
    var infinitive   : String = ""
    var presentMS    : String = ""
    var presentFS    : String = ""
    var presentMP    : String = ""
    var presentFP    : String = ""
    var past1S       : String = ""
    var past2MS      : String = ""
    var past2FS      : String = ""
    var past3MS      : String = ""
    var past3FS      : String = ""
    var past1P       : String = ""
    var past2MP      : String = ""
    var past2FP      : String = ""
    var past3P       : String = ""
    var future1S     : String = ""
    var future2MS    : String = ""
    var future2FS    : String = ""
    var future3MS    : String = ""
    var future3FS    : String = ""
    var future1P     : String = ""
    var future2MP    : String = ""
    var future2FP    : String = ""
    var future3MP    : String = ""
    var future3FP    : String = ""
    var imperativeMS : String = ""
    var imperativeFS : String = ""
    var imperativeMP : String = ""
    var imperativeFP : String = ""
    
}


// delete
struct WordForLearning {
    var foreign : String = ""
    var original: String = ""
    var isLearned: Bool = false
    var levelOfLearning: Int = 0
    var nextContact: Date? = nil
    var dontWantToLearn : Bool = false
    var image : String = ""
    var mistake : Int = 0
    var discription: String? = ""
    var simple: String? = ""
}

