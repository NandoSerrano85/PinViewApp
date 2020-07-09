// NAME: Fernando Serrano
// PANTHERID:   5642858
// CLASS:       COP 4655 01 Online
// INSTRUCTOR:  Steve Luis ECS 282
// ASSIGNMENT:  Programming assignment 5
// DUE:         Thursday 11/17/19

import Foundation

class PinDatabase {
    static let shared = PinDatabase()
    
    private var data:[String:String] = [:]
    private var keys:[String] = []
    private var cache:[String] = ["", ""]
    
    private init(key:String, value:String){
        self.data[key] = value
        self.keys.append(key)
    }
    
    private convenience init(){
        let keyList = ["0000", "1111", "2222"]
        let urlList = ["https://www.apple.com", "https://www.cnet.com", "https://www.google.com"]
        self.init(key:keyList[0], value:urlList[0])
        for n in 1...2{
            self.addNewPin(key: keyList[n], value: urlList[n])
        }
    }
    func getURL(key:String) -> String{
        return self.data[key]!
    }
    
    func getPinAndURL(index:Int) -> (pin:String, url:String){
        return (self.keys[index], self.data[self.keys[index]]!)
    }
    
    func getCache() -> [String] {
        return self.cache
    }
    
    func setCache(key:String, value:String){
        self.cache[0] = key
        self.cache[1] = value
    }
    
    func addNewPin(key:String, value:String){
        self.data[key] = value
        self.keys.append(key)
    }
    
    func removeFromDB(index:Int) {
        let key = self.keys[index]
        self.keys.remove(at:index)
        self.data.removeValue(forKey: key)
    }
    
    func validationCheckForKey(key:String) -> Bool {
        return self.data[key] != nil
    }
    
    func validationCheckForChanges(index:Int, key:String, value:String){
        if index > self.keys.count-1 {
            self.keys.append(key)
            self.data[key] = value
        } else if self.keys[index] != key {
            self.data.removeValue(forKey: self.keys[index])
            self.keys[index] = key
            self.data[key] = value
        } else {
            self.data[key] = value
        }
    }
    func sizeOfDB() -> Int  {
        return self.keys.count
    }
    
}
