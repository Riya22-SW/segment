//
//  ApiManager.swift
//  SegmentDemo
//
//  Created by admin on 04/12/24.
//

import Foundation
import Alamofire

class ApiManager{
    
   let urlstr="https://official-joke-api.appspot.com/jokes/random/25"
    
    let urlstr1="https://freetestapi.com/api/v1/cats?limit=5"
    
    func fetchJokes(completionHandler: @escaping(Result<[JokeModel],Error>)-> Void) {
        
        AF.request(urlstr).responseDecodable(of: [JokeModel].self){response in
            switch response.result{
                
            case.success(let data):
                completionHandler(.success(data))
                
            case.failure(let error):
                completionHandler(.failure(error))
                
        
        
    }
        
        }
    }
    
    func fetchcat(completionHandler: @escaping(Result<[CatModel],Error>)-> Void) {
        
        AF.request(urlstr1).responseDecodable(of: [CatModel].self){response in
            switch response.result{
                
            case.success(let data):
                completionHandler(.success(data))
                
            case.failure(let error):
                completionHandler(.failure(error))
                
        
        
    }
        
        }
    }
}
