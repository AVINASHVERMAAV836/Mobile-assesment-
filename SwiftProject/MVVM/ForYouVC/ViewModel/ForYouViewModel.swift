//
//  ForYouViewModel.swift
//  SwiftProject
//
//  Created by Admin on 03/04/24.
//

import Foundation

protocol ForYouViewModelDelegate{
    func didReceiveTrackListResponse(response: ForyouResponse?)
}

struct ForYouViewModel{
    var delegate: ForYouViewModelDelegate?
    
    func getTrackList(){
        let url = URL(string: trackData)!
        let httpUtility = HttpUtility()
        httpUtility.getApiData(requestUrl: url, resultType: ForyouResponse.self){result in 
            if (result != nil){
                DispatchQueue.main.async{
                    self.delegate?.didReceiveTrackListResponse(response: result)
                }
            }else{
                DispatchQueue.main.async{
                    self.delegate?.didReceiveTrackListResponse(response: ForyouResponse(data: nil))
                }
            }
        }
    }
}

struct HttpUtility{
    
        func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?)-> Void){
            
            //......Creating urlRequest.........
            var urlRequest = URLRequest(url: requestUrl)
            urlRequest.httpMethod = "get"
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            
            URLSession.shared.dataTask(with: urlRequest) { (responseData, httpUrlResponse, error) in
                if(error == nil && responseData != nil && responseData?.count != 0)
                {
                    let decoder = JSONDecoder()
                    do {
                        let result = try decoder.decode(resultType, from: responseData!)
                        print(result)
                        _=completionHandler(result)
                    }
                    catch let error{
                        debugPrint("error occured while decoding = \(error.localizedDescription)")
                    }
                }
                
            }.resume()
        }
    
}
