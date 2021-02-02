//
//  Message.swift
//  ViztarChatApp
//
//  Created by Jai Mataji on 03/02/21.
//


class Message
{
//    var author: String = ""
    var timestamp: Int = 0
    var body: String = ""
    
    init(timestamp:Int, body:String)
    {
        self.timestamp = timestamp
        self.body = body
    }
}
