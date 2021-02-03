//
//  VLUtility.swift
//  ViztarChatApp
//
//  Created by Jai Mataji on 03/02/21.
//

import Foundation

class VLUtility{
    private init(){}
    
    static var plistURL : URL {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let path = paths.appending("/chat.plist")
        let fileManager = FileManager.default
        if (!(fileManager.fileExists(atPath: path)))
        {
            do {
                let bundlePath : NSString = Bundle.main.path(forResource: "chat", ofType: "plist")! as NSString
                try fileManager.copyItem(atPath: bundlePath as String, toPath: path)
            }catch {
                print(error)
            }
        }
        return URL(string: "file://" + path)!
    }
    
    static func savePropertyList(_ plist: Any) throws
    {
        let plistData = try PropertyListSerialization.data(fromPropertyList: plist, format: .xml, options: 0)
        try plistData.write(to: plistURL)
    }
    
    static func loadPropertyList() throws -> [String:String]
    {
        let data = try Data(contentsOf: plistURL)
        guard let plist = try PropertyListSerialization.propertyList(from: data, format: nil) as? [String:String] else {
            return [:]
        }
        return plist
    }
    
    static func getLastMessage()->String{
        do {
            let dictionary = try VLUtility.loadPropertyList()
            let chatDict = dictionary
            var chatKeys = Array(chatDict.keys)
            chatKeys.sort(by: <)
            
            return chatDict[chatKeys.last ?? ""] ?? ""
        } catch {
            return ""
        }
    }
    
    static func dateForTimestamp(ts:String)-> String{
        let date = Date(timeIntervalSince1970: Double(ts)!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: date)
    }
}
