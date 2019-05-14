//
//  ChatService.swift
//  vigilesMobile
//
//  Created by Claudia Lolli on 15/05/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import Foundation
import Scaledrone

class ChatService {
    func sendMessage(_ message: String) {
        room?.publish(message: message)
    }
    private let scaledrone: Scaledrone
    private let messageCallback: (Message)-> Void
    
    private var room: ScaledroneRoom?
    
    init(member: Member, onRecievedMessage: @escaping (Message)-> Void) {
        self.messageCallback = onRecievedMessage
        self.scaledrone = Scaledrone(
            channelID: "T4BBwxobMCVFNVTV",
            data: member.toJSON)
        scaledrone.delegate = self as ScaledroneDelegate
    }
    
    func connect() {
        scaledrone.connect()
    }
}

extension ChatService: ScaledroneDelegate {
    func scaledroneDidConnect(scaledrone: Scaledrone, error: Error?) {
        print("Connected to Scaledrone")
        room = scaledrone.subscribe(roomName: "observable-room")
        room?.delegate = self as? ScaledroneRoomDelegate
    }
    
    func scaledroneDidReceiveError(scaledrone: Scaledrone, error: Error?) {
        print("Scaledrone error", error ?? "")
    }
    
    func scaledroneDidDisconnect(scaledrone: Scaledrone, error: Error?) {
        print("Scaledrone disconnected", error ?? "")
    }
}

extension ChatService: ScaledroneRoomDelegate {
    func scaledroneRoomDidConnect(room: ScaledroneRoom, error: Error?) {
        print("Connected to room!")
    }
    
    func scaledroneRoomDidReceiveMessage(
        room: ScaledroneRoom,
        message: Any,
        member: ScaledroneMember?) {
        
        guard
            let text = message as? String,
            let memberData = member?.clientData,
            let member = Member(fromJSON: memberData)
            else {
                print("Could not parse data.")
                return
        }
        
        let message = Message(
            member: member,
            text: text,
            messageId: UUID().uuidString)
        messageCallback(message)
    }
}
