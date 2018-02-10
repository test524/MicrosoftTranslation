//
//  TransLationModel.swift
//  MicrosoftTranslation
//
//  Created by Pavan Kumar Reddy on 21/01/18.
//  Copyright © 2018 Nagarjuna. All rights reserved.
//

import Foundation

class  TransLationModel : NSObject
{

    static let shared:TransLationModel = {
        let instance = TransLationModel()
        return instance
    }()
    

    //MARK:- Adding parameters to  the URL.
    func makeURLRequest(dictionary: [String:String]) -> URL
    {
        var components = URLComponents.init(string: KBaseURL)
        var queryItems = [URLQueryItem]()
        for case let parameter in dictionary
        {
            let queryItem =  URLQueryItem.init(name: parameter.key, value: parameter.value)
            queryItems.append(queryItem)
        }
        components?.queryItems = queryItems
        return components!.url!
    }
    
    //MARK:- Translation API
    func translate(sourceText:String , fromLanguage:String , toLanguage:String , completion: @escaping (_ response: Data) -> Void)
    {
        let parameters = ["appid":"",
                          "text":sourceText,
                          "from":fromLanguage,
                          "to":toLanguage] as [String:String]
        
        var request = URLRequest.init(url: makeURLRequest(dictionary: parameters))
        request.httpMethod = "GET"
        request.setValue(KTransLationKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let xmlData = data else  {return}
            
            DispatchQueue.main.async {
                completion(xmlData)
            }
            
            }.resume()
    }
    
}






