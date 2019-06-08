//
//  ReportsModel.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 02/05/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ReportsModel: NSObject {
    
    //    Escaping viene richiamato dopo l'esecuzione della funzione, facendola quindi "vivere più a lungo"
    //    Closure, possiamo passarlo nel codice (abbiamo "assegnato" result a Reports)
    func fetchEvents(complete: @escaping (_ result: [Reports]) -> ()) {
        let url = URL(string: "http://vigilesweb.test/api/reports")!
        print("prova")
        
        Alamofire.request(url, method: .get).validate().responseJSON {
            response in
            print("Inizio film")
            //            Verifichiamo errori, guard permette di performare un’azione solo quando la sua condizione non è verificata (quindi falsa)
            guard response.error == nil
                else {
                    print("errore")
                    print(response.error!)
                    return
            }
            print("Ci sono, forse")
            //            Se la risposta non è di tipo stringa attiva errore
            guard (response.value as? [String: Any]) != nil
                else {
                    if let error = response.error {
                        print("Merdaccia")
                        print("Errore: \(error)")
                    }
                    return
            }
            print("Thanos")
            //            Do esegue il codice per decodificare json chiedendo risposta dai dati presenti al suo interno. In caso di errore viene passato e               "preso" dal catch
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let reports = try decoder.decode(ReportsData.self, from: response.data!)
                //                Si mandano i dati recuperati a HistoricalViewController
                print(reports.data!)
                complete(reports.data!)
                print("Vai stronzo")
            }
                
            catch let error {
                print("Decoding error: ", error)
            }
            
            return
        }
    }
}
