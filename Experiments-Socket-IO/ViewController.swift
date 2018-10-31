//
//  ViewController.swift
//  Experiments-Socket-IO
//
//  Created by Andrew Ashurov on 7/25/18.
//  Copyright © 2018 0x384c0. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    var socket:SocketIOClient!
    var manager:SocketManager!
    override func viewDidLoad() {
        let params = ["token":"TOKEN",
                      "toUser":"37"]
        manager = SocketManager(socketURL: URL(string: "ws://localhost:3001")!,
                                config: [.connectParams(params)])
        
        socket = manager.defaultSocket
        
        
        
        socket.on(clientEvent: .connect) {_,_  in
            print("socket connected")
        }
        socket.on(clientEvent: .disconnect) { _,_ in
            print("socket connected")
        }
        socket.on(clientEvent: .error) { _,_ in
            print("socket error")
        }
        socket.on(clientEvent: .ping) { _,_ in
            print("socket ping")
        }
        socket.on(clientEvent: .pong) { _,_ in
            print("socket pong")
        }
        socket.on("new_message") {data, ack in
            print("socket new_message")
            print((data.first as! Dictionary<String,AnyObject>)["from"]!)
            print((data.first as! Dictionary<String,AnyObject>)["message"]!)
            
        }
    }
    
    @IBAction func connect(_ sender: Any) {
        socket.connect()
    }
    @IBAction func diconnect(_ sender: Any) {
        socket.disconnect()
    }
    @IBAction func sendTestMessage(_ sender: Any) {
        print(socket.status)
        socket.emit("send_message", ["message": "Я отправляю сообщение и это сообщение"])
    }
}

