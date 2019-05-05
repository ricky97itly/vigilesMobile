//
//  UserModel.swift
//  vigilesMobile
//
//  Created by alessandro palumbo on 05/05/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserModel: NSObject {
    func fetchEvents(complete: @escaping (_ result:[User]) -> ()) {
        let url = URL(string: "http://vigilesweb.test/oauth/token")!
        print("Canne e figa")
        
        Alamofire.request(url, method: .post).validate().responseJSON {
            response in
            print("In alamofire")
            
            guard response.error == nil
            else {
                print("ERROREEEEEE")
                print(response.error!)
                return
            }
            
            print("CICCIOLINA")
            
            guard (response.value as? [String:Any]) != nil
            else {
                if let error = response.error {
                    print("BASTARDO DI DIO")
                    print("ERRORE: \(error)")
                }
                return
            }
            
            print("CIAUOIKJNHJIKL")
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(UserData.self, from: response.data!)
                complete(user.data!)
                print("MERDACCIA DI DDIO")
                
            }
            catch let error{
                print("Decoding error: ", error)
            }
            return
        }
    }
}
