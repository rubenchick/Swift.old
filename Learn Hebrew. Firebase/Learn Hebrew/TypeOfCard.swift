

import Foundation

enum TypeOfCard : Int {
    case meeting = 0
    case trueOrFalse
    case pictureChooseWrite
    case pictureChooseTranslate
    case pictureAndTranslateChooseWrite
    case prononceChooseWrite
    case prononceChoosePicture
    case writeChoosePicture
    case prononceAndWriteChooseTranslate
    case createFromLetter
    case prononceChooseTranslate
    case writeFromPrononce
    case writeFromTranslate
}

enum TypeOfButton : Int{
    case next = 0
    case choose
    case remember
    case forget
    case pronunciationBig
    case pronunciationNormal
    case choosePicture
    case edit
    case add
}

enum TypeOfPicture : Int{
    case main = 0
    case choose
}

enum TypeOfRequest : Int {
    case all = 0
    case actual
}

