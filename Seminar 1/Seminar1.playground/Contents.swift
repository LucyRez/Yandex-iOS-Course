//1. Свернуть строку: AABBBCRFFA -> A2B3CRF2A
func collapse(_ str: String) -> String{
    guard str != "" else{
        return ""
    }
    
    var res = ""
    var counter = 1

    for index in 1...str.count-1{
        let previous = str.index(str.startIndex, offsetBy: index-1)
        let i = str.index(str.startIndex, offsetBy: index)
        if(str[i] == str[previous]){
            counter+=1
            if(index == str.count-1){
                res.append(str[i])
                res+=String(counter)
            }
        }else{
            if (counter != 1){
                res.append(str[previous])
                res+=String(counter)
                counter = 1
                if(index == str.count-1){
                    res.append(str[i])
                }
            }else{
                res.append(str[previous])
            }
        }
    }
    
    return res
}

collapse("AABBBCRFFA")
collapse("ADCDEEEGHH")
collapse("AAABBEFGGHH")

//2. Количество простых чисел меньше N
func numberOfPrimesLessThan(_ number: Int) -> Int{
    
    guard number != 0 && number != 1 else{
        return 0
    }
    
    var counter = 0
    for i in  2...number{
        var prime = true
        for j in 2...i{
            if(i != j && i%j == 0){
                prime = false
                break
            }
        }
        
        if (prime && i != number){
            counter+=1
        }
    }
    return counter
}

numberOfPrimesLessThan(0)
numberOfPrimesLessThan(2)
numberOfPrimesLessThan(100)
numberOfPrimesLessThan(711)

//3. Есть следующий код:
let info = [
    "Chelsea": ["Kante", "Lukaku", "Werner"],
    "PSG": ["Messi", "Neymar", "Mbappe"],
    "Manchester City": ["Grealish", nil, "Sterling"]
]

func bestPlayers(from playersInfo: [String: [String?]]) -> [String] {
    return playersInfo.values.flatMap{ $0 }.compactMap{ $0 }.filter{$0.count > 5}.sorted(by: <)
}

bestPlayers(from: info)

// Вернуть отсортированный список всех спортсменов у кого больше 5 букв в имени

