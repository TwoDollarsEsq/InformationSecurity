//
//  WorkShop.hpp
//  Ciphers & Unicode
//
//  Created by Artyom Rudakov on 5/9/18.
//  Copyright © 2020 TwoDollarsEsq. All rights reserved.
//
//  Тут знаходяться допоміжні утіліти. В більшій степені — це робота з файлами.

#pragma once

std::string getTheName(std::string sourceName = "", bool source = true) {
    
    std::string name;
    if (source) {
        std::ifstream check(name.c_str());
        while (!check) {
            printf("Enter correct name: ");
            std::cin >> name;
            check.close();
            check = std::ifstream(name.c_str());
        }
        check.close();
    } else {
        if (sourceName.length() == 5)
            name = sourceName.substr(0,1) + "_out.txt";
        else if (sourceName.length() == 6)
            name = sourceName.substr(0,2) + "_out.txt";
        else
            name = sourceName.substr(0,3) + "_out.txt";
    }
    
    return name;
    
}

std::string readFromFile(std::string name) {
    
    std::ifstream file(name.c_str());
    std::string data((std::istreambuf_iterator<char>(file)), std::istreambuf_iterator<char>());
    
    return data;
    
}

void writeToFile(std::string name, std::string data) {
    
    std::string outPutName = getTheName(name, false);
    std::ofstream write(outPutName.c_str(), std::fstream::out);
    write << data;
    write.close();
    
}

std::string printData(std::string name, bool source = false) {
    
    std::string exactName = std::string(source ? name : getTheName(name, false));
    std::string message = std::string(source ? "Input" : "Output") + " file '" + exactName + "': \n";
    std::string data = readFromFile(exactName);
    
    return message + data;
    
}
