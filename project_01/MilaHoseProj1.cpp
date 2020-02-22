//  Project 1
//  Mila Hose
//  1/28/2020

#include <iostream>
#include <string>
#include <cassert>
#include <cmath>

using namespace std;

int binary_to_decimal(string s);
// precondition: s is a string that consists of only 0s and 1s
// postcondition: the positive decimal integer that is represented by s

string decimal_to_binary(int n);
// precondition: n is a positive integer
// postcondition: n’s binary representation is returned as a string of 0s and 1s

string add_binaries(string b1, string b2);
// precondition: b1 and b2 are strings that consists of 0s and 1s, i.e.
//               b1 and b2 are binary representations of two positive integers
// postcondition: the sum of b1 and b2 is returned. For instance,
//  if b1 = “11”, b2 = “01”, then the return value is “100”

string strReverse(string s);
// precondition: s is a string with length > 0
// postcondition: the string with all characters reversed

void menu();
// display the menu. Student shall not modify this function

int grade();
// returns an integer that represents the student’s grade of this projects.
// Student shall NOT modify

bool is_binary(string b);
// returns true if the given string s consists of only 0s and 1s; false otherwise

bool test_binary_to_decimal();
// returns true if the student’s implementation of binary_to_decimal function
// is correct; false otherwise. Student shall not modify this function

bool test_decimal_to_binary();
//  returns true if the student’s implementation of decimal_to_binary function is correct; false otherwise. Student shall not modify this function

bool test_add_binaries();
// which returns true if the student’s implementation of add_binaries function
// is correct; false otherwise. Student shall not modify this function


int main()
{
    int choice;
    string b1, b2;
    int x, score;
    do{
        // display menu
        menu();
        cout << "Enter you choice: ";
        cin >> choice;
        // based on choice to perform tasks
        switch(choice){
            case 1:
                cout << "Enter a binary string: ";
                cin >> b1;
                if(!is_binary(b1))
                    cout << "It is not a binary number\n";
                else
                    cout << "Its decimal value is: " << binary_to_decimal(b1) << endl;
                break;
                
            case 2:
                cout << "Enter a positive integer: ";
                cin >> x;
                if(x <= 0)
                    cout << "It is not a positive integer" << endl;
                else
                    cout << "Its binary representation is: " <<decimal_to_binary(x) << endl;
                break;
                
            case 3:
                cout << "Enter two binary numbers, separated by white space: ";
                cin >> b1 >> b2;
                if(!is_binary(b1) || !is_binary(b2))
                    cout << "At least one number is not a binary" << endl;
                else
                    cout << "The sum is: " << add_binaries(b1, b2) << endl;
                break;
                
            case 4:
                score = grade();
                cout << "If you turn in your project on blackboard now, you will get " << score << " out of 10" << endl;
                cout << "Your instructor will decide if one-two more points will be added or not based on your program style, such as good commnets (1 points) and good efficiency (1 point)" << endl;
                break;
                
            case 5:
                cout << "Thanks for using binary calculator program. Good-bye" << endl;
                break;
            default:
                cout << "Wrong choice. Please choose 1-5 from menu" << endl;
                break;
        }
        
    } while(choice != 5);
    return 0;
}

int binary_to_decimal(string s){
    // you implement this
    
    int exponent = 0, decimal = 0;
    int count = static_cast<int>(s.length() - 1);

    while (count >= 0) {
        if (s[count] == '1') {
            // 2 times exponent place value
            decimal += pow(2, exponent);
        }
        
        count--;
        exponent++;
    }

    return decimal;
}

string decimal_to_binary(int n){
    // you implement this
    
    string binary = "";
    int quotient = n, remainder = n;
    
    // Don't loop if 0 or 1
    if (n == 0) {
        return "0";
    } else if (n == 1) {
        return "1";
    }
    
    while (quotient > 0) {
        remainder = quotient - (floor(quotient / 2) * 2);
        quotient = floor(quotient / 2);

        if (remainder % 2 > 0) {
            binary += "1";
        } else {
            binary += "0";
        }
    }
    
    return strReverse(binary);
}

string add_binaries(string b1, string b2){
    // you implement this

    int b1Length = static_cast<int>(b1.length());
    int b2Length = static_cast<int>(b2.length());
    int difference = b1Length > b2Length ? (b1Length - b2Length) : (b2Length - b1Length);
    string zeroPadding = "", sum = "";
    bool carryOne = false;
    
    while (difference > 0) {
        zeroPadding += "0";
        difference--;
    }
    
    if (b1.length() > b2.length()) {
        b2 = zeroPadding + b2;
        b2Length = static_cast<int>(b2.length());
    } else {
        b1 = zeroPadding + b1;
        b1Length = static_cast<int>(b1.length());
    }
    
    for (int i = b1Length - 1; i >= 0; i--) {
        if (b1[i] == '1' && b2[i] == '1') {
            if (carryOne) {
                sum += "1";
                carryOne = true;
            } else {
                sum += "0";
                carryOne = true;
            }
        } else if (b1[i] == '1' || b2[i] == '1') {
            if (carryOne) {
                sum += "0";
                carryOne = true;
            } else {
                sum += "1";
                carryOne = false;
            }
        } else { // both are 0
            if (carryOne) {
                sum += "1";
                carryOne = false;
            } else {
                sum += "0";
                carryOne = false;
            }
        }
    }
    
    // Don't forget final carry
    if (carryOne) {
        sum += "1";
    }

    return strReverse(sum);
}

void menu()
{
    cout << "******************************\n";
    cout << "*          Menu              *\n";
    cout << "* 1. Binary to Decimal       *\n";
    cout << "* 2. Decinal to Binary       *\n";
    cout << "* 3. Add two Binaries        *\n";
    cout << "* 4. Grade                   *\n";
    cout << "* 5. Quit                    *\n";
    cout << "******************************\n";
}

int grade(){
    int result = 0;
    // binary_to_decimal function worth 3 points
    if(test_binary_to_decimal()){
        cout << "binary_to_decimal function pass the test" << endl;
        result += 3;
    }
    else
        cout << "binary_to_decimal function failed" << endl;
    
    // decinal_to_binary function worth 2 points
    if(test_decimal_to_binary()){
        cout << "decimal_to_binary function pass the test" << endl;
        result += 2;
    }
    else
        cout << "decimal_to_binary function failed" << endl;
    // add_binaries function worth 3 points
    if(test_add_binaries()){
        cout << "add_binaries function pass the test" << endl;
        result += 3;
    }
    else
        cout << "add_binaries function pass failed" << endl;
    return result;
}

bool is_binary(string s){
    for(int i = 0; i < s.length(); i++)
        if(s[i] != '0' && s[i] != '1') // one element in s is not '0' or '1'
            return false;  // then it is not a binary nunber representation
    return true;
}

bool test_binary_to_decimal(){
    if(binary_to_decimal("0") != 0 || binary_to_decimal("1") != 1)
        return false;
    if(binary_to_decimal("010") != 2 || binary_to_decimal("10") != 2)
        return false;
    if(binary_to_decimal("01101") != 13 || binary_to_decimal("1101") != 13)
        return false;
    return true;
}

bool test_decimal_to_binary(){
    if(decimal_to_binary(0) != "0" || decimal_to_binary(1) != "1")
        return false;
    if(decimal_to_binary(2) != "10" || decimal_to_binary(13) != "1101")
        return false;
    return true;
}

bool test_add_binaries(){
    if(add_binaries("0", "0") != "0") return false;
    if(add_binaries("0", "110101") != "110101") return false;
    if(add_binaries("1", "110111") != "111000") return false;
    if(add_binaries("101", "111011") != "1000000") return false;
    return true;
}

string strReverse(string s) {
    int strLength = static_cast<int>(s.length() - 1);
    string reversedStr = "";

    for (int i = strLength; i >= 0; i--) {
        reversedStr += s[i];
    }
    
    return reversedStr;
}
