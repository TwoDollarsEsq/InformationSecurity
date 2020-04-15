//
//  Lmain.cpp
//  Ciphers & Unicode
//
//  Created by Artyom Rudakov on 5/9/18.
//  Copyright © 2018 TwoDollarsEsq. All rights reserved.
//

#include <iostream>

#include "LCaesar.hpp"
#include "LVigenere.hpp"
#include "WorkShop.hpp"

int main() {
    std::string message = "Hello, Dat!";
    std::string name = "";
    
    int cKey = rand();
    std::string vKey = "Randomness";
    
    int answer = -1;
    while (answer) {
        system("clear");
        std::cout << "Programm: " << message << "\n\n";
        
        printf("%-35s %-35s %-35s %-35s\n%-35s %-35s %-35s %-35s\n%-35s %-35s %-35s %-35s\n%-35s %-35s\n",
               " 1. Enter the name and read data.",
               " 2. Print input file.",
               " 3. Print output file.",
               " 4. Write data into file.",
               " 5. Load sample #1.",
               " 6. Load sample #2.",
               " 7. Load sample #3.",
               " 8. Encode with Caesar.",
               " 9. Decode with Caesar.",
               "10. Encode with Vigenere.",
               "11. Decode with Vigenere.",
               "12. Enter Caesar key(only integer).",
               "13. Enter Vigenere key.",
               "14. Get Vigenere key from the file."
               );
        
        std::cout << "\nAnswer = ";
        std::cin >> answer;
        
        system("clear");
        switch (answer) {
            case 0:  std::cout << "Goodbye!\n"; break;
            case 1:  message = name = getTheName(); break;
            case 2:  message = printData(name, true); break;
            case 3:  message = printData(name); break;
            case 4:  message = "Data was written into output file."; writeToFile(name, readFromFile(name)); break;
            case 5:  message = name = "RE1.txt"; break;
            case 6:  message = name = "RE2.txt"; break;
            case 7:  message = name = "RE3.txt"; break;
            case 8:  writeToFile(name, cEncode(readFromFile(name), cKey)); message = printData(name); break;
            case 9:  writeToFile(name, cDecode(readFromFile(getTheName(name, false)), cKey)); message = printData(name); break;
            case 10: writeToFile(name, vEncode(readFromFile(name), vKey)); message = printData(name); break;
            case 11: writeToFile(name, vDecode(readFromFile(getTheName(name, false)), vKey)); message = printData(name); break;
            case 12: std::cout << "Programm: cKey = ";
                std::cin >> cKey;
                message = "cKey = " + std::to_string(cKey);
                break;
            case 13: std::cout << "Programm: vKey = ";
                std::cin.ignore();
                std::getline(std::cin, vKey);
                message = "vKey = " + vKey;
                break;
            case 14:
                vKey = readFromFile(getTheName()); break;
            default:
                message = "Invalid command.";
                break;
        }
        
    }
    
    return 0;
}
