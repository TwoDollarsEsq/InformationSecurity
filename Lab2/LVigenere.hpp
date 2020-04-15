//
//  LVigenere
//  Ciphers & Unicode
//
//  Created by Artyom Rudakov on 5/9/18.
//  Copyright © 2018 TwoDollarsEsq. All rights reserved.
//

#pragma once

#include <string>
#include <fstream>

std::string vEncode(std::string body, std::string key) {
    std::wstring_convert<std::codecvt_utf8_utf16<wchar_t>> converter;
    std::wstring source = converter.from_bytes(body);
    unsigned keyValue = key[0];
    auto length = source.length();
    
    for (unsigned i = 0; i < length; i++) {
        if (i) {
            if (i < key.length())
                keyValue = key[i];
            else
                keyValue = key[i % key.length()];
        }
        
        if (source[i] > 31) {
            source[i] += keyValue;
        }
    }
    return converter.to_bytes(source);
}

std::string vDecode(std::string body, std::string key) {
    std::wstring_convert<std::codecvt_utf8_utf16<wchar_t>> converter;
    std::wstring source = converter.from_bytes(body);
    unsigned keyValue = key[0];
    auto length = source.length();
    
    for (unsigned i = 0; i < length; i++) {
        if (i) {
            if (i < key.length())
                keyValue = key[i];
            else
                keyValue = key[i % key.length()];
        }
        
        if (source[i] > 31) {
            int value = source[i] - keyValue;
            if (value < 32)
                source[i] = value + 94;
            else
                source[i] -= keyValue;
        }
    }
    return converter.to_bytes(source);
}
