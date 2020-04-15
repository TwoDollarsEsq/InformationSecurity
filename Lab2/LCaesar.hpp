//
//  LCeaser.hpp
//  Ciphers & Unicode
//
//  Created by Artyom Rudakov on 5/29/18.
//  Copyright © 2020 TwoDollarsEsq. All rights reserved.
//
//  Реалізація шифра Цезаря з підтримкою Unicode.

#pragma once

#include <string>
#include <fstream>
#include <codecvt>

std::string cEncode(std::string body, int key) {
    std::wstring_convert<std::codecvt_utf8_utf16<wchar_t>> converter;
    std::wstring source = converter.from_bytes(body);
    auto length = source.length();
    
    for (unsigned i = 0; i < length; i++)
        if (source[i] > 32)
            source[i] += key;
    
    return converter.to_bytes(source);
}

std::string cDecode(std::string body, int key) {
    std::wstring_convert<std::codecvt_utf8_utf16<wchar_t>> converter;
    std::wstring source = converter.from_bytes(body);
    auto length = source.length();
    
    for (unsigned i = 0; i < length; i++)
        if (source[i] > 32) {
            int value = source[i] - key;
            if (value < 32)
                source[i] = value + 94;
            else
                source[i] -= key;
        }
    
    return converter.to_bytes(source);
}
