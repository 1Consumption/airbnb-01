//
//  MapListUseCase.swift
//  Airbnb
//
//  Created by 신한섭 on 2020/06/05.
//  Copyright © 2020 신한섭. All rights reserved.
//

import Foundation

struct RooomListInMapUseCase {
    
    private var networkManager: NetworkManageable
    
    init(networkManager: NetworkManageable) {
        self.networkManager = networkManager
    }
    
    func requestRoomList(queryString: String, failureHandler: @escaping (String) -> (), successHandler: @escaping ([MapViewRoomList]) -> ()) {
        networkManager.loadResource(method: .get, headers: nil, bodys: nil, statusCode: 300,  requestURL: EndPoint.defaultURL + EndPoint.accommodations + EndPoint.coordinate + queryString){
            switch $0 {
            case .success(let data):
                guard let data = data else {
                    failureHandler("no data")
                    return
                }
                
                do {
                    let model = try JSONDecoder().decode([MapViewRoomList].self, from: data)
                    successHandler(model)
                } catch {
                    failureHandler("Json decode error")
                }
                break
            case .failure(let error):
                failureHandler(error.localizedDescription)
                break
            }
        }
    }
}
