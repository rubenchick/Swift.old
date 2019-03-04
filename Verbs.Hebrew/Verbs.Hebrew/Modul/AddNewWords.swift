//
//  AddNewWords.swift
//  Verbs.Hebrew
//
//  Created by Anton Rubenchik on 01/03/2019.
//  Copyright © 2019 Anton Rubenchik. All rights reserved.
//

import Foundation
class AddNewWords {
    //    let newWordsArray : [BlackWord] = []
    //
    
    
    let newWordsArray : [BlackWord] = [
        BlackWord(translation  : "собирать, держать, запасать",
                  infinitive   : "לֶאֱצוֹרлеэцор",
                  presentMS    : "אוֹצֵרоцер",
                  presentFS: "אוֹצֶרֶתоцерет",
                  presentMP: "אוֹצְרִיםоцрим",
                  presentFP: "אוֹצְרוֹתоцрот",
                  past1S: "אָצַרְתִּיацарти",
                  past2MS: "אָצַרְתָּацарта",
                  past2FS: "אָצַרְתְּацарт",
                  past3MS: "אָצַרацар",
                  past3FS: "אָצְרָהацра",
                  past1P: "אָצַרְנוּацарну",
                  past2MP: "*אֲצַרְתֶּםацартем",
                  past2FP: "*אֲצַרְתֶּןацартен",
                  past3P: "אָצְרוּацру",
                  future1S: "אֶאֱצוֹרээцор",
                  future2MS: "תֶּאֱצוֹרтеэцор",
                  future2FS: "תֶּאֶצְרִיтеэцри",
                  future3MS: "יֶאֱצוֹרйеэцор",
                  future3FS: "תֶּאֱצוֹרтеэцор",
                  future1P: "נֶאֱצוֹרнеэцор",
                  future2MP: "תֶּאֶצְרוּтеэцру",
                  future2FP: "תֶּאֶצְרוּтеэцру",
                  future3MP: "יֶאֶצְרוּйеэцру",
                  future3FP: "יֶאֶצְרוּйеэцру",
                  imperativeMS: "אֱצוֹר!‏эцор!",
                  imperativeFS: "אִצְרִי!‏ицри!",
                  imperativeMP: "אִצְרוּ!‏ицру!",
                  imperativeFP: "אִצְרוּ!‏ицру!"),
        BlackWord(translation  : "обходить с фланга",
                  infinitive   : "לְאַגֵּףлеагеф",
                  presentMS    : "מְאַגֵּףмеагеф",
                  presentFS: "מְאַגֶּפֶתмеагефет",
                  presentMP: "מְאַגְּפִיםмеагфим",
                  presentFP: "מְאַגְּפוֹתмеагфот",
                  past1S: "אִגַּפְתִּיигафти",
                  past2MS: "אִגַּפְתָּигафта",
                  past2FS: "אִגַּפְתְּигафт",
                  past3MS: "אִגֵּףигеф",
                  past3FS: "אִגְּפָהигфа",
                  past1P: "אִגַּפְנוּигафну",
                  past2MP: "*אִגַּפְתֶּםигафтем",
                  past2FP: "*אִגַּפְתֶּןигафтен",
                  past3P: "אִגְּפוּигфу",
                  future1S: "אֲאַגֵּףаагеф",
                  future2MS: "תְּאַגֵּףтеагеф",
                  future2FS: "תְּאַגְּפִיтеагфи",
                  future3MS: "יְאַגֵּףйеагеф",
                  future3FS: "תְּאַגֵּףтеагеф",
                  future1P: "נְאַגֵּףнеагеф",
                  future2MP: "תְּאַגְּפוּтеагфу",
                  future2FP: "תְּאַגְּפוּтеагфу",
                  future3MP: "יְאַגְּפוּйеагфу",
                  future3FP: "יְאַגְּפוּйеагфу",
                  imperativeMS: "אַגֵּף!‏агеф!",
                  imperativeFS: "אַגְּפִי!‏агфи!",
                  imperativeMP: "אַגְּפוּ!‏агфу!",
                  imperativeFP: "אַגְּפוּ!‏агфу!"),
        BlackWord(translation  : "испарять; тушить, готовить на пару",
                  infinitive   : "לְאַדּוֹתлеадот",
                  presentMS    : "מְאַדֶּהмеаде",
                  presentFS: "מְאַדָּהмеада",
                  presentMP: "מְאַדִּיםмеадим",
                  presentFP: "מְאַדּוֹתмеадот",
                  past1S: "אִדִּיתִיидити",
                  past2MS: "אִדִּיתָидита",
                  past2FS: "אִדִּיתидит",
                  past3MS: "אִדָּהида",
                  past3FS: "אִדְּתָהидета",
                  past1P: "אִדִּינוּидину",
                  past2MP: "*אִדִּיתֶםидитем",
                  past2FP: "*אִדִּיתֶןидитен",
                  past3P: "אִדּוּиду",
                  future1S: "אֲאַדֶּהааде",
                  future2MS: "תְּאַדֶּהтеаде",
                  future2FS: "תְּאַדִּיтеади",
                  future3MS: "יְאַדֶּהйеаде",
                  future3FS: "תְּאַדֶּהтеаде",
                  future1P: "נְאַדֶּהнеаде",
                  future2MP: "תְּאַדּוּтеаду",
                  future2FP: "תְּאַדּוּтеаду",
                  future3MP: "יְאַדּוּйеаду",
                  future3FP: "יְאַדּוּйеаду",
                  imperativeMS: "אַדֵּה!‏аде!",
                  imperativeFS: "אַדִּי!‏ади!",
                  imperativeMP: "אַדּוּ!‏аду!",
                  imperativeFP: "אַדּוּ!‏аду!"),
        BlackWord(translation  : "устроить засаду кому-л. (ל-)",
                  infinitive   : "לֶאֱרוֹבлеэров",
                  presentMS    : "אוֹרֵבорев",
                  presentFS: "אוֹרֶבֶתоревет",
                  presentMP: "אוֹרְבִיםорвим",
                  presentFP: "אוֹרְבוֹתорвот",
                  past1S: "אָרַבְתִּיаравти",
                  past2MS: "אָרַבְתָּаравта",
                  past2FS: "אָרַבְתְּаравт",
                  past3MS: "אָרַבарав",
                  past3FS: "אָרְבָהарва",
                  past1P: "אָרַבְנוּаравну",
                  past2MP: "*אֲרַבְתֶּםаравтем",
                  past2FP: "*אֲרַבְתֶּןаравтен",
                  past3P: "אָרְבוּарву",
                  future1S: "אֶאֱרוֹבээров",
                  future2MS: "תֶּאֱרוֹבтеэров",
                  future2FS: "תֶּאֶרְבִיтеэрви",
                  future3MS: "יֶאֱרוֹבйеэров",
                  future3FS: "תֶּאֱרוֹבтеэров",
                  future1P: "נֶאֱרוֹבнеэров",
                  future2MP: "תֶּאֶרְבוּтеэрву",
                  future2FP: "תֶּאֶרְבוּтеэрву",
                  future3MP: "יֶאֶרְבוּйеэрву",
                  future3FP: "יֶאֶרְבוּйеэрву",
                  imperativeMS: "אֱרוֹב!‏эров!",
                  imperativeFS: "אִרְבִי!‏ирви!",
                  imperativeMP: "אִרְבוּ!‏ирву!",
                  imperativeFP: "אִרְבוּ!‏ирву!"),
        BlackWord(translation  : "ткать",
                  infinitive   : "לֶאֱרוֹגлеэрог",
                  presentMS    : "אוֹרֵגорег",
                  presentFS: "אוֹרֶגֶתорегет",
                  presentMP: "אוֹרְגִיםоргим",
                  presentFP: "אוֹרְגוֹתоргот",
                  past1S: "אָרַגְתִּיарагти",
                  past2MS: "אָרַגְתָּарагта",
                  past2FS: "אָרַגְתְּарагт",
                  past3MS: "אָרַגараг",
                  past3FS: "אָרְגָהарга",
                  past1P: "אָרַגְנוּарагну",
                  past2MP: "*אֲרַגְתֶּםарагтем",
                  past2FP: "*אֲרַגְתֶּןарагтен",
                  past3P: "אָרְגוּаргу",
                  future1S: "אֶאֱרוֹגээрог",
                  future2MS: "תֶּאֱרוֹגтеэрог",
                  future2FS: "תֶּאֶרְגִיтеэрги",
                  future3MS: "יֶאֱרוֹגйеэрог",
                  future3FS: "תֶּאֱרוֹגтеэрог",
                  future1P: "נֶאֱרוֹגнеэрог",
                  future2MP: "תֶּאֶרְגוּтеэргу",
                  future2FP: "תֶּאֶרְגוּтеэргу",
                  future3MP: "יֶאֶרְגוּйеэргу",
                  future3FP: "יֶאֶרְגוּйеэргу",
                  imperativeMS: "אֱרוֹג!‏эрог!",
                  imperativeFS: "אִרְגִי!‏ирги!",
                  imperativeMP: "אִרְגוּ!‏иргу!",
                  imperativeFP: "אִרְגוּ!‏иргу!"),
        BlackWord(translation  : "упаковывать, связывать",
                  infinitive   : "לֶאֱרוֹזлеэроз",
                  presentMS    : "אוֹרֵזорез",
                  presentFS: "אוֹרֶזֶתорезет",
                  presentMP: "אוֹרְזִיםорзим",
                  presentFP: "אוֹרְזוֹתорзот",
                  past1S: "אָרַזְתִּיаразти",
                  past2MS: "אָרַזְתָּаразта",
                  past2FS: "אָרַזְתְּаразт",
                  past3MS: "אָרַזараз",
                  past3FS: "אָרְזָהарза",
                  past1P: "אָרַזְנוּаразну",
                  past2MP: "*אֲרַזְתֶּםаразтем",
                  past2FP: "*אֲרַזְתֶּןаразтен",
                  past3P: "אָרְזוּарзу",
                  future1S: "אֶאֱרוֹזээроз",
                  future2MS: "תֶּאֱרוֹזтеэроз",
                  future2FS: "תֶּאֶרְזִיтеэрзи",
                  future3MS: "יֶאֱרוֹזйеэроз",
                  future3FS: "תֶּאֱרוֹזтеэроз",
                  future1P: "נֶאֱרוֹזнеэроз",
                  future2MP: "תֶּאֶרְזוּтеэрзу",
                  future2FP: "תֶּאֶרְזוּтеэрзу",
                  future3MP: "יֶאֶרְזוּйеэрзу",
                  future3FP: "יֶאֶרְזוּйеэрзу",
                  imperativeMS: "אֱרוֹז!‏эроз!",
                  imperativeFS: "אִרְזִי!‏ирзи!",
                  imperativeMP: "אִרְזוּ!‏ирзу!",
                  imperativeFP: "אִרְזוּ!‏ирзу!"),
        BlackWord(translation  : "собирать (фиги) (библ.)",
                  infinitive   : "לֶאֱרוֹתлеэрот",
                  presentMS    : "אוֹרֶהоре",
                  presentFS: "אוֹרָהора",
                  presentMP: "אוֹרִיםорим",
                  presentFP: "אוֹרוֹתорот",
                  past1S: "אָרִיתִיарити",
                  past2MS: "אָרִיתָарита",
                  past2FS: "אָרִיתарит",
                  past3MS: "אָרָהара",
                  past3FS: "אָרְתָהарта",
                  past1P: "אָרִינוּарину",
                  past2MP: "*אֲרִיתֶםаритем",
                  past2FP: "*אֲרִיתֶןаритен",
                  past3P: "אָרוּару",
                  future1S: "אֶאֱרֶהээре",
                  future2MS: "תֶּאֱרֶהтеэре",
                  future2FS: "תֶּאֱרִיтеэри",
                  future3MS: "יֶאֱרֶהйеэре",
                  future3FS: "תֶּאֱרֶהтеэре",
                  future1P: "נֶאֱרֶהнеэре",
                  future2MP: "תֶּאֱרוּтеэру",
                  future2FP: "תֶּאֱרוּтеэру",
                  future3MP: "יֶאֱרוּйеэру",
                  future3FP: "יֶאֱרוּйеэру",
                  imperativeMS: "אֱרֵה!‏эре!",
                  imperativeFS: "אֱרִי!‏эри!",
                  imperativeMP: "אֱרוּ!‏эру!",
                  imperativeFP: "אֱרוּ!‏эру!"),
        BlackWord(translation  : "длиться",
                  infinitive   : "לֶאֱרוֹךְлеэрох",
                  presentMS    : "אוֹרֵךְорех",
                  presentFS: "אוֹרֶכֶתорехет",
                  presentMP: "אוֹרְכִיםорхим",
                  presentFP: "אוֹרְכוֹתорхот",
                  past1S: "אָרַכְתִּיарахти",
                  past2MS: "אָרַכְתָּарахта",
                  past2FS: "אָרַכְתְּарахт",
                  past3MS: "אָרַךְарах",
                  past3FS: "אָרְכָהарха",
                  past1P: "אָרַכְנוּарахну",
                  past2MP: "*אֲרַכְתֶּםарахтем",
                  past2FP: "*אֲרַכְתֶּןарахтен",
                  past3P: "אָרְכוּарху",
                  future1S: "אֶאֱרַךְээрах",
                  future2MS: "תֶּאֱרַךְтеэрах",
                  future2FS: "תֶּאֶרְכִיтеэрхи",
                  future3MS: "יֶאֱרַךְйеэрах",
                  future3FS: "תֶּאֱרַךְтеэрах",
                  future1P: "נֶאֱרַךְнеэрах",
                  future2MP: "תֶּאֶרְכוּтеэрху",
                  future2FP: "תֶּאֶרְכוּтеэрху",
                  future3MP: "יֶאֶרְכוּйеэрху",
                  future3FP: "יֶאֶרְכוּйеэрху",
                  imperativeMS: "אֱרַךְ!‏эрах!",
                  imperativeFS: "אִרְכִי!‏ирхи!",
                  imperativeMP: "אִרְכוּ!‏ирху!",
                  imperativeFP: "אִרְכוּ!‏ирху!"),
        BlackWord(translation  : "проклинать (библ.)",
                  infinitive   : "לָאוֹרлаор",
                  presentMS    : "*אוֹרֵרорер",
                  presentFS: "*אוֹרֶרֶתоререт",
                  presentMP: "*אוֹרְרִיםорерим",
                  presentFP: "*אוֹרְרוֹתорерот",
                  past1S: "אָרוֹתִיароти",
                  past2MS: "אָרוֹתָарота",
                  past2FS: "אָרוֹתарот",
                  past3MS: "*אָרַרарар",
                  past3FS: "*אָרְרָהарера",
                  past1P: "אָרוֹנוּарону",
                  past2MP: "אָרוֹתֶםаротем",
                  past2FP: "אָרוֹתֶןаротен",
                  past3P: "*אָרְרוּареру",
                  future1S: "אָאוֹרаор",
                  future2MS: "תָּאוֹרтаор",
                  future2FS: "תָּאוֹרִיтаори",
                  future3MS: "יָאוֹרяор",
                  future3FS: "תָּאוֹרтаор",
                  future1P: "נָאוֹרнаор",
                  future2MP: "תָּאוֹרוּтаору",
                  future2FP: "תָּאוֹרוּтаору",
                  future3MP: "יָאוֹרוּяору",
                  future3FP: "יָאוֹרוּяору",
                  imperativeMS: "",
                  imperativeFS: "",
                  imperativeMP: "",
                  imperativeFP: ""),
        BlackWord(translation  : "грешить, быть виновным (архаич.)",
                  infinitive   : "לֶאְשׁוֹםлеэшом",
                  presentMS    : "אָשֵׁםашем",
                  presentFS: "אֲשֵׁמָהашема",
                  presentMP: "אֲשֵׁמִיםашемим",
                  presentFP: "אֲשֵׁמוֹתашемот",
                  past1S: "אָשַׁמְתִּיашамти",
                  past2MS: "אָשַׁמְתָּашамта",
                  past2FS: "אָשַׁמְתְּашамт",
                  past3MS: "אָשַׁםашам",
                  past3FS: "אָשְׁמָהашма",
                  past1P: "אָשַׁמְנוּашамну",
                  past2MP: "*אֲשַׁמְתֶּםашамтем",
                  past2FP: "*אֲשַׁמְתֶּןашамтен",
                  past3P: "אָשְׁמוּашму",
                  future1S: "אֶאְשַׁםээшам",
                  future2MS: "תֶּאְשַׁםтеэшам",
                  future2FS: "תֶּאְשְׁמִיтеэшми",
                  future3MS: "יֶאְשַׁםйеэшам",
                  future3FS: "תֶּאְשַׁםтеэшам",
                  future1P: "נֶאְשַׁםнеэшам",
                  future2MP: "תֶּאְשְׁמוּтеэшму",
                  future2FP: "תֶּאְשְׁמוּтеэшму",
                  future3MP: "יֶאְשְׁמוּйеэшму",
                  future3FP: "יֶאְשְׁמוּйеэшму",
                  imperativeMS: "",
                  imperativeFS: "",
                  imperativeMP: "",
                  imperativeFP: ""),
        BlackWord(translation  : "изменять, предавать (ב-)",
                  infinitive   : "לִבְגּוֹדливгод",
                  presentMS    : "בּוֹגֵדбогед",
                  presentFS: "בּוֹגֶדֶתбогедет",
                  presentMP: "בּוֹגְדִיםбогдим",
                  presentFP: "בּוֹגְדוֹתбогдот",
                  past1S: "בָּגַדְתִּיбагадети",
                  past2MS: "בָּגַדְתָּбагадета",
                  past2FS: "בָּגַדְתְּбагадет",
                  past3MS: "בָּגַדбагад",
                  past3FS: "בָּגְדָהбагда",
                  past1P: "בָּגַדְנוּбагадну",
                  past2MP: "*בְּגַדְתֶּםбгадетем",
                  past2FP: "*בְּגַדְתֶּןбгадетен",
                  past3P: "בָּגְדוּбагду",
                  future1S: "אֶבְגּוֹדэвгод",
                  future2MS: "תִּבְגּוֹדтивгод",
                  future2FS: "תִּבְגְּדִיтивгеди",
                  future3MS: "יִבְגּוֹדйивгод",
                  future3FS: "תִּבְגּוֹדтивгод",
                  future1P: "נִבְגּוֹדнивгод",
                  future2MP: "תִּבְגְּדוּтивгеду",
                  future2FP: "תִּבְגְּדוּтивгеду",
                  future3MP: "יִבְגְּדוּйивгеду",
                  future3FP: "יִבְגְּדוּйивгеду",
                  imperativeMS: "בְּגוֹד!‏бгод!",
                  imperativeFS: "בִּגְדִי!‏бигди!",
                  imperativeMP: "בִּגְדוּ!‏бигду!",
                  imperativeFP: "בִּגְדוּ!‏бигду!"),
        BlackWord(translation  : "выдумывать",
                  infinitive   : "לִבְדּוֹאливдо",
                  presentMS    : "בּוֹדֵאбоде",
                  presentFS: "בּוֹדֵאתбодет",
                  presentMP: "בּוֹדְאִיםбодъим",
                  presentFP: "בּוֹדְאוֹתбодъот",
                  past1S: "בָּדָאתִיбадати",
                  past2MS: "בָּדָאתָбадата",
                  past2FS: "בָּדָאתбадат",
                  past3MS: "בָּדָאбада",
                  past3FS: "בָּדְאָהбадъа",
                  past1P: "בָּדָאנוּбадану",
                  past2MP: "*בְּדָאתֶםбдатем",
                  past2FP: "*בְּדָאתֶןбдатен",
                  past3P: "בָּדְאוּбадъу",
                  future1S: "אֶבְדָּאэвда",
                  future2MS: "תִּבְדָּאтивда",
                  future2FS: "תִּבְדְּאִיтивдеи",
                  future3MS: "יִבְדָּאйивда",
                  future3FS: "תִּבְדָּאтивда",
                  future1P: "נִבְדָּאнивда",
                  future2MP: "תִּבְדְּאוּтивдеу",
                  future2FP: "תִּבְדְּאוּтивдеу",
                  future3MP: "יִבְדְּאוּйивдеу",
                  future3FP: "יִבְדְּאוּйивдеу",
                  imperativeMS: "בְּדָא!‏бда!",
                  imperativeFS: "בִּדְאִי!‏бидъи!",
                  imperativeMP: "בִּדְאוּ!‏бидъу!",
                  imperativeFP: "בִּדְאוּ!‏бидъу!"),
        BlackWord(translation  : "проверять",
                  infinitive   : "לִבְדּוֹקливдок",
                  presentMS    : "בּוֹדֵקбодек",
                  presentFS: "בּוֹדֶקֶתбодекет",
                  presentMP: "בּוֹדְקִיםбодким",
                  presentFP: "בּוֹדְקוֹתбодкот",
                  past1S: "בָּדַקְתִּיбадакти",
                  past2MS: "בָּדַקְתָּбадакта",
                  past2FS: "בָּדַקְתְּбадакт",
                  past3MS: "בָּדַקбадак",
                  past3FS: "בָּדְקָהбадка",
                  past1P: "בָּדַקְנוּбадакну",
                  past2MP: "*בְּדַקְתֶּםбдактем",
                  past2FP: "*בְּדַקְתֶּןбдактен",
                  past3P: "בָּדְקוּбадку",
                  future1S: "אֶבְדּוֹקэвдок",
                  future2MS: "תִּבְדּוֹקтивдок",
                  future2FS: "תִּבְדְּקִיтивдеки",
                  future3MS: "יִבְדּוֹקйивдок",
                  future3FS: "תִּבְדּוֹקтивдок",
                  future1P: "נִבְדּוֹקнивдок",
                  future2MP: "תִּבְדְּקוּтивдеку",
                  future2FP: "תִּבְדְּקוּтивдеку",
                  future3MP: "יִבְדְּקוּйивдеку",
                  future3FP: "יִבְדְּקוּйивдеку",
                  imperativeMS: "בְּדוֹק!‏бдок!",
                  imperativeFS: "בִּדְקִי!‏бидки!",
                  imperativeMP: "בִּדְקוּ!‏бидку!",
                  imperativeFP: "בִּדְקוּ!‏бидку!"),
        BlackWord(translation  : "уставиться, смотреть (на что-либо) (ב־)",
                  infinitive   : "לִבְהוֹתливhот",
                  presentMS    : "בּוֹהֶהбоhе",
                  presentFS: "בּוֹהָהбоhа",
                  presentMP: "בּוֹהִיםбоhим",
                  presentFP: "בּוֹהוֹתбоhот",
                  past1S: "בָּהִיתִיбаhити",
                  past2MS: "בָּהִיתָбаhита",
                  past2FS: "בָּהִיתбаhит",
                  past3MS: "בָּהָהбаhа",
                  past3FS: "בָּהֲתָהбаhата",
                  past1P: "בָּהִינוּбаhину",
                  past2MP: "*בְּהִיתֶםбеhитем",
                  past2FP: "*בְּהִיתֶןбеhитен",
                  past3P: "בָּהוּбаhу",
                  future1S: "אֶבְהֶהэвhе",
                  future2MS: "תִּבְהֶהтивhе",
                  future2FS: "תִּבְהִיтивhи",
                  future3MS: "יִבְהֶהйивhе",
                  future3FS: "תִּבְהֶהтивhе",
                  future1P: "נִבְהֶהнивhе",
                  future2MP: "תִּבְהוּтивhу",
                  future2FP: "תִּבְהוּтивhу",
                  future3MP: "יִבְהוּйивhу",
                  future3FP: "יִבְהוּйивhу",
                  imperativeMS: "בְּהֵה!‏беhе!",
                  imperativeFS: "בְּהִי!‏беhи!",
                  imperativeMP: "בְּהוּ!‏беhу!",
                  imperativeFP: "בְּהוּ!‏беhу!"),
        BlackWord(translation  : "блестеть",
                  infinitive   : "לִבְהוֹקливhок",
                  presentMS    : "בּוֹהֵקбоhек",
                  presentFS: "בּוֹהֶקֶתбоhекет",
                  presentMP: "בּוֹהֲקִיםбоhаким",
                  presentFP: "בּוֹהֲקוֹתбоhакот",
                  past1S: "בָּהַקְתִּיбаhакти",
                  past2MS: "בָּהַקְתָּбаhакта",
                  past2FS: "בָּהַקְתְּбаhакт",
                  past3MS: "בָּהַקбаhак",
                  past3FS: "בָּהֲקָהбаhака",
                  past1P: "בָּהַקְנוּбаhакну",
                  past2MP: "*בְּהַקְתֶּםбеhактем",
                  past2FP: "*בְּהַקְתֶּןбеhактен",
                  past3P: "בָּהֲקוּбаhаку",
                  future1S: "אֶבְהַקэвhак",
                  future2MS: "תִּבְהַקтивhак",
                  future2FS: "תִּבְהֲקִיтивhаки",
                  future3MS: "יִבְהַקйивhак",
                  future3FS: "תִּבְהַקтивhак",
                  future1P: "נִבְהַקнивhак",
                  future2MP: "תִּבְהֲקוּтивhаку",
                  future2FP: "תִּבְהֲקוּтивhаку",
                  future3MP: "יִבְהֲקוּйивhаку",
                  future3FP: "יִבְהֲקוּйивhаку",
                  imperativeMS: "בְּהַק!‏беhак!",
                  imperativeFS: "בַּהֲקִי!‏баhаки!",
                  imperativeMP: "בַּהֲקוּ!‏баhаку!",
                  imperativeFP: "בַּהֲקוּ!‏баhаку!"),
        BlackWord(translation  : "приходить",
                  infinitive   : "לָבוֹאлаво",
                  presentMS    : "בָּאба",
                  presentFS: "*בָּאָהбаа",
                  presentMP: "בָּאִיםбаим",
                  presentFP: "בָּאוֹתбаот",
                  past1S: "בָּאתִיбати",
                  past2MS: "בָּאתָбата",
                  past2FS: "בָּאתбат",
                  past3MS: "בָּאба",
                  past3FS: "בָּאָהбаа",
                  past1P: "בָּאנוּбану",
                  past2MP: "*בָּאתֶםбатем",
                  past2FP: "*בָּאתֶןбатен",
                  past3P: "בָּאוּбау",
                  future1S: "אָבוֹאаво",
                  future2MS: "תָּבוֹאтаво",
                  future2FS: "תָּבוֹאִיтавои",
                  future3MS: "יָבוֹאяво",
                  future3FS: "תָּבוֹאтаво",
                  future1P: "נָבוֹאнаво",
                  future2MP: "תָּבוֹאוּтавоу",
                  future2FP: "תָּבוֹאוּтавоу",
                  future3MP: "יָבוֹאוּявоу",
                  future3FP: "יָבוֹאוּявоу",
                  imperativeMS: "בּוֹא!‏бо!",
                  imperativeFS: "בּוֹאִי!‏бои!",
                  imperativeMP: "בּוֹאוּ!‏боу!",
                  imperativeFP: "בּוֹאוּ!‏боу!"),
        BlackWord(translation  : "презирать кого-либо (ל־)",
                  infinitive   : "לָבוּזлавуз",
                  presentMS    : "בָּזбаз",
                  presentFS: "*בָּזָהбаза",
                  presentMP: "בָּזִיםбазим",
                  presentFP: "בָּזוֹתбазот",
                  past1S: "בַּזְתִּיбазти",
                  past2MS: "בַּזְתָּбазта",
                  past2FS: "בַּזְתְּбазт",
                  past3MS: "בָּזбаз",
                  past3FS: "בָּזָהбаза",
                  past1P: "בַּזְנוּбазну",
                  past2MP: "*בַּזְתֶּםбазтем",
                  past2FP: "*בַּזְתֶּןбазтен",
                  past3P: "בָּזוּбазу",
                  future1S: "אָבוּזавуз",
                  future2MS: "תָּבוּזтавуз",
                  future2FS: "תָּבוּזִיтавузи",
                  future3MS: "יָבוּזявуз",
                  future3FS: "תָּבוּזтавуз",
                  future1P: "נָבוּזнавуз",
                  future2MP: "תָּבוּזוּтавузу",
                  future2FP: "תָּבוּזוּтавузу",
                  future3MP: "יָבוּזוּявузу",
                  future3FP: "יָבוּזוּявузу",
                  imperativeMS: "בּוּז!‏буз!",
                  imperativeFS: "בּוּזִי!‏бузи!",
                  imperativeMP: "בּוּזוּ!‏бузу!",
                  imperativeFP: "בּוּזוּ!‏бузу!"),
        BlackWord(translation  : "стыдиться",
                  infinitive   : "לֵבוֹשׁлевош",
                  presentMS    : "בּוֹשׁбош",
                  presentFS: "*בּוֹשָׁהбоша",
                  presentMP: "בּוֹשִׁיםбошим",
                  presentFP: "בּוֹשׁוֹתбошот",
                  past1S: "בּוֹשְׁתִּיбошти",
                  past2MS: "בּוֹשְׁתָּбошта",
                  past2FS: "בּוֹשְׁתְּбошт",
                  past3MS: "בּוֹשׁбош",
                  past3FS: "בּוֹשָׁהбоша",
                  past1P: "בּוֹשְׁנוּбошну",
                  past2MP: "*בּוֹשְׁתֶּםбоштем",
                  past2FP: "*בּוֹשְׁתֶּןбоштен",
                  past3P: "בּוֹשׁוּбошу",
                  future1S: "אֵבוֹשׁэвош",
                  future2MS: "תֵּבוֹשׁтевош",
                  future2FS: "תֵּבוֹשִׁיтевоши",
                  future3MS: "יֵבוֹשׁйевош",
                  future3FS: "תֵּבוֹשׁтевош",
                  future1P: "נֵבוֹשׁневош",
                  future2MP: "תֵּבוֹשׁוּтевошу",
                  future2FP: "תֵּבוֹשׁוּтевошу",
                  future3MP: "יֵבוֹשׁוּйевошу",
                  future3FP: "יֵבוֹשׁוּйевошу",
                  imperativeMS: "בּוֹשׁ!‏бош!",
                  imperativeFS: "בּוֹשִׁי!‏боши!",
                  imperativeMP: "בּוֹשׁוּ!‏бошу!",
                  imperativeFP: "בּוֹשׁוּ!‏бошу!"),
        BlackWord(translation  : "грабить, мародерствовать",
                  infinitive   : "לִבְזוֹזливзоз",
                  presentMS    : "בּוֹזֵזбозез",
                  presentFS: "בּוֹזֶזֶתбозезет",
                  presentMP: "בּוֹזְזִיםбозезим",
                  presentFP: "בּוֹזְזוֹתбозезот",
                  past1S: "בָּזַזְתִּיбазазти",
                  past2MS: "בָּזַזְתָּбазазта",
                  past2FS: "בָּזַזְתְּбазазт",
                  past3MS: "בָּזַזбазаз",
                  past3FS: "בָּזְזָהбазеза",
                  past1P: "בָּזַזְנוּбазазну",
                  past2MP: "*בְּזַזְתֶּםбзазтем",
                  past2FP: "*בְּזַזְתֶּןбзазтен",
                  past3P: "בָּזְזוּбазезу",
                  future1S: "אֶבְזוֹזэвзоз",
                  future2MS: "תִּבְזוֹזтивзоз",
                  future2FS: "תִּבְזְזִיтивзези",
                  future3MS: "יִבְזוֹזйивзоз",
                  future3FS: "תִּבְזוֹזтивзоз",
                  future1P: "נִבְזוֹזнивзоз",
                  future2MP: "תִּבְזְזוּтивзезу",
                  future2FP: "תִּבְזְזוּтивзезу",
                  future3MP: "יִבְזְזוּйивзезу",
                  future3FP: "יִבְזְזוּйивзезу",
                  imperativeMS: "בְּזוֹז!‏бзоз!",
                  imperativeFS: "בִּזְזִי!‏бизези!",
                  imperativeMP: "בִּזְזוּ!‏бизезу!",
                  imperativeFP: "בִּזְזוּ!‏бизезу!"),
        BlackWord(translation  : "разбрызгивать, насыпать",
                  infinitive   : "לִבְזוֹקливзок",
                  presentMS    : "בּוֹזֵקбозек",
                  presentFS: "בּוֹזֶקֶתбозекет",
                  presentMP: "בּוֹזְקִיםбозким",
                  presentFP: "בּוֹזְקוֹתбозкот",
                  past1S: "בָּזַקְתִּיбазакти",
                  past2MS: "בָּזַקְתָּбазакта",
                  past2FS: "בָּזַקְתְּбазакт",
                  past3MS: "בָּזַקбазак",
                  past3FS: "בָּזְקָהбазка",
                  past1P: "בָּזַקְנוּбазакну",
                  past2MP: "*בְּזַקְתֶּםбзактем",
                  past2FP: "*בְּזַקְתֶּןбзактен",
                  past3P: "בָּזְקוּбазку",
                  future1S: "אֶבְזוֹקэвзок",
                  future2MS: "תִּבְזוֹקтивзок",
                  future2FS: "תִּבְזְקִיтивзеки",
                  future3MS: "יִבְזוֹקйивзок",
                  future3FS: "תִּבְזוֹקтивзок",
                  future1P: "נִבְזוֹקнивзок",
                  future2MP: "תִּבְזְקוּтивзеку",
                  future2FP: "תִּבְזְקוּтивзеку",
                  future3MP: "יִבְזְקוּйивзеку",
                  future3FP: "יִבְזְקוּйивзеку",
                  imperativeMS: "בְּזוֹק!‏бзок!",
                  imperativeFS: "בִּזְקִי!‏бизки!",
                  imperativeMP: "בִּזְקוּ!‏бизку!",
                  imperativeFP: "בִּזְקוּ!‏бизку!"),
        BlackWord(translation  : "испытывать отвращение к (ב-)",
                  infinitive   : "לִבְחוֹלливхоль",
                  presentMS    : "בּוֹחֵלбохель",
                  presentFS: "בּוֹחֶלֶתбохелет",
                  presentMP: "בּוֹחֲלִיםбохалим",
                  presentFP: "בּוֹחֲלוֹתбохалот",
                  past1S: "בָּחַלְתִּיбахальти",
                  past2MS: "בָּחַלְתָּбахальта",
                  past2FS: "בָּחַלְתְּбахальт",
                  past3MS: "בָּחַלбахаль",
                  past3FS: "בָּחֲלָהбахала",
                  past1P: "בָּחַלְנוּбахальну",
                  past2MP: "*בְּחַלְתֶּםбхальтем",
                  past2FP: "*בְּחַלְתֶּןбхальтен",
                  past3P: "בָּחֲלוּбахалу",
                  future1S: "אֶבְחַלэвхаль",
                  future2MS: "תִּבְחַלтивхаль",
                  future2FS: "תִּבְחֲלִיтивхали",
                  future3MS: "יִבְחַלйивхаль",
                  future3FS: "תִּבְחַלтивхаль",
                  future1P: "נִבְחַלнивхаль",
                  future2MP: "תִּבְחֲלוּтивхалу",
                  future2FP: "תִּבְחֲלוּтивхалу",
                  future3MP: "יִבְחֲלוּйивхалу",
                  future3FP: "יִבְחֲלוּйивхалу",
                  imperativeMS: "בְּחַל!‏бхаль!",
                  imperativeFS: "בַּחֲלִי!‏бахали!",
                  imperativeMP: "בַּחֲלוּ!‏бахалу!",
                  imperativeFP: "בַּחֲלוּ!‏бахалу!"),
        BlackWord(translation  : "проверять, экзаменовать",
                  infinitive   : "לִבְחוֹןливхон",
                  presentMS    : "בּוֹחֵןбохен",
                  presentFS: "בּוֹחֶנֶתбохенет",
                  presentMP: "בּוֹחֲנִיםбоханим",
                  presentFP: "בּוֹחֲנוֹתбоханот",
                  past1S: "בָּחַנְתִּיбаханти",
                  past2MS: "בָּחַנְתָּбаханта",
                  past2FS: "בָּחַנְתְּбахант",
                  past3MS: "בָּחַןбахан",
                  past3FS: "בָּחֲנָהбахана",
                  past1P: "בָּחַנּוּбаханну",
                  past2MP: "*בְּחַנְתֶּםбхантем",
                  past2FP: "*בְּחַנְתֶּןбхантен",
                  past3P: "בָּחֲנוּбахану",
                  future1S: "אֶבְחַןэвхан",
                  future2MS: "תִּבְחַןтивхан",
                  future2FS: "תִּבְחֲנִיтивхани",
                  future3MS: "יִבְחַןйивхан",
                  future3FS: "תִּבְחַןтивхан",
                  future1P: "נִבְחַןнивхан",
                  future2MP: "תִּבְחֲנוּтивхану",
                  future2FP: "תִּבְחֲנוּтивхану",
                  future3MP: "יִבְחֲנוּйивхану",
                  future3FP: "יִבְחֲנוּйивхану",
                  imperativeMS: "בְּחַן!‏бхан!",
                  imperativeFS: "בַּחֲנִי!‏бахани!",
                  imperativeMP: "בַּחֲנוּ!‏бахану!",
                  imperativeFP: "בַּחֲנוּ!‏бахану!"),
        BlackWord(translation  : "растирать в пыль",
                  infinitive   : "לְאַבֵּקлеабек",
                  presentMS    : "מְאַבֵּקмеабек",
                  presentFS: "מְאַבֶּקֶתмеабекет",
                  presentMP: "מְאַבְּקִיםмеабким",
                  presentFP: "מְאַבְּקוֹתмеабкот",
                  past1S: "אִבַּקְתִּיибакти",
                  past2MS: "אִבַּקְתָּибакта",
                  past2FS: "אִבַּקְתְּибакт",
                  past3MS: "אִבֵּקибек",
                  past3FS: "אִבְּקָהибка",
                  past1P: "אִבַּקְנוּибакну",
                  past2MP: "*אִבַּקְתֶּםибактем",
                  past2FP: "*אִבַּקְתֶּןибактен",
                  past3P: "אִבְּקוּибку",
                  future1S: "אֲאַבֵּקаабек",
                  future2MS: "תְּאַבֵּקтеабек",
                  future2FS: "תְּאַבְּקִיтеабки",
                  future3MS: "יְאַבֵּקйеабек",
                  future3FS: "תְּאַבֵּקтеабек",
                  future1P: "נְאַבֵּקнеабек",
                  future2MP: "תְּאַבְּקוּтеабку",
                  future2FP: "תְּאַבְּקוּтеабку",
                  future3MP: "יְאַבְּקוּйеабку",
                  future3FP: "יְאַבְּקוּйеабку",
                  imperativeMS: "אַבֵּק!‏абек!",
                  imperativeFS: "אַבְּקִי!‏абки!",
                  imperativeMP: "אַבְּקוּ!‏абку!",
                  imperativeFP: "אַבְּקוּ!‏абку!"),
        BlackWord(translation  : "связывать, объединять",
                  infinitive   : "לְאַגֵּדлеагед",
                  presentMS    : "מְאַגֵּדмеагед",
                  presentFS: "מְאַגֶּדֶתмеагедет",
                  presentMP: "מְאַגְּדִיםмеагдим",
                  presentFP: "מְאַגְּדוֹתмеагдот",
                  past1S: "אִגַּדְתִּיигадети",
                  past2MS: "אִגַּדְתָּигадета",
                  past2FS: "אִגַּדְתְּигадет",
                  past3MS: "אִגֵּדигед",
                  past3FS: "אִגְּדָהигда",
                  past1P: "אִגַּדְנוּигадну",
                  past2MP: "*אִגַּדְתֶּםигадетем",
                  past2FP: "*אִגַּדְתֶּןигадетен",
                  past3P: "אִגְּדוּигду",
                  future1S: "אֲאַגֵּדаагед",
                  future2MS: "תְּאַגֵּדтеагед",
                  future2FS: "תְּאַגְּדִיтеагди",
                  future3MS: "יְאַגֵּדйеагед",
                  future3FS: "תְּאַגֵּדтеагед",
                  future1P: "נְאַגֵּדнеагед",
                  future2MP: "תְּאַגְּדוּтеагду",
                  future2FP: "תְּאַגְּדוּтеагду",
                  future3MP: "יְאַגְּדוּйеагду",
                  future3FP: "יְאַגְּדוּйеагду",
                  imperativeMS: "אַגֵּד!‏агед!",
                  imperativeFS: "אַגְּדִי!‏агди!",
                  imperativeMP: "אַגְּדוּ!‏агду!",
                  imperativeFP: "אַגְּדוּ!‏агду!"),
        ]
    
    
}
/*
 let newWordsArray : [BlackWord] = [
 BlackWord(translation  : "",
 infinitive   : "",
 presentMS    : "",
 presentFS    : "",
 presentMP    : "",
 presentFP    : "",
 past1S       : "",
 past2MS      : "",
 past2FS      : "",
 past3MS      : "",
 past3FS      : "",
 past1P       : "",
 past2MP      : "",
 past2FP      : "",
 past3P       : "",
 futer1S      : "",
 future2MS    : "",
 future2FS    : "",
 future3MS    : "",
 future3FS    : "",
 future1P     : "",
 future2MP    : "",
 future2FP    : "",
 future3MP    : "",
 future3FP    : "",
 imperativeMS : "",
 imperativeFS : "",
 imperativeMP : "",
 imperativeFP : ""
 )
 ]
 */
/*
 let newWordsArray : [BlackWord] = [
 BlackWord(translation  : "потеряться, пропасть",
 infinitive   : """
 לֶאֱבוֹד
 леэвод
 """,
 presentMS    : """
 "אוֹבֵד
 овед"
 """,              presentFS    : """
 "אוֹבֶדֶת
 оведет"
 """,
 presentMP    : """
 אוֹבְדִים
 овдим
 """,
 presentFP    : """
 "אוֹבְדוֹת
 овдот"
 """,
 past1S       : """
 "אָבַדְתִּי
 авадети"
 """,
 past2MS      : """
 "אָבַדְתָּ
 авадета"
 """,
 past2FS      : """
 "אָבַדְתְּ
 авадет"
 """,
 past3MS      : """
 "אָבַד
 авад"
 """,
 past3FS      : """
 "אָבְדָה
 авда"
 """,
 past1P       : """
 "אָבַדְנוּ
 авадну"
 """,
 past2MP      : """
 "*אֲבַדְתֶּם
 авадетем"
 """,
 past2FP      : """
 "*אֲבַדְתֶּן
 авадетен"
 """,
 past3P       : """
 "אָבְדוּ
 авду"
 """,
 futer1S      : """
 "אָבְדוּ
 авду"
 """,
 future2MS    : """
 "אוֹבַד
 овад"
 """,
 future2FS    : """
 "תֹּאבַד
 товад"
 """,
 future3MS    : """
 "תֹּאבְדִי
 товди"
 """,
 future3FS    : """
 "יֹאבַד
 йовад"
 """,
 future1P     : """
 "תֹּאבַד
 товад"
 """,
 future2MP    : """
 "נֹאבַד
 новад"
 """,
 future2FP    : """
 "תֹּאבְדוּ
 товду"
 """,
 future3MP    : """
 "*תֹּאבַדְנָה
 товадна"
 """,
 future3FP    : """
 "יֹאבְדוּ
 йовду"
 """,
 imperativeMS : """
 "אֱבוֹד!‏
 эвод!"
 """,
 imperativeFS : """
 "אִבְדִי!‏
 ивди!"
 """,
 imperativeMP : """
 "אִבְדוּ!‏
 ивду!"
 """,
 imperativeFP : """
 "*אֱבוֹדְנָה!‏
 эводна!"
 """
 )
 ]
 */