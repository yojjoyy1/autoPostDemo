//
//  HLRequestModel.swift
//  autoPostDemo
//
//  Created by novastar on 2024/8/16.
//

import UIKit
import Alamofire
import Combine

class HLRequestModel: NSObject {

    static let threadsDomain = "https://graph.threads.net/v1.0"
    
    static let threadsPublishApi:(String) -> String = {
        userid in
        return "https://graph.threads.net/v1.0/\(userid)/threads_publish"
    }
    class func publishTreads(content:String,userId:String,access_token:String){
        let para = ["media_type":"TEXT","text":content,"access_token":access_token]
        AF.request("\(threadsDomain)/\(userId)/threads",method: .post,parameters: para).response { afData in
            do{
                let json = try JSONSerialization.jsonObject(with: afData.data!)
                if let dic = json as? NSDictionary{
                    let contentId = dic["id"] as! String
                    print("threads response:\(dic)")
                    let publishPara = ["creation_id":contentId,"access_token":access_token]
                    AF.request(threadsPublishApi(userId),method: .post,parameters: publishPara).response {
                        publishData in
                        let publishResStr = String(data: publishData.data!, encoding: .utf8)
                        print("publishResStr:\(publishResStr)")
                    }
                }
            }catch{
                print("error:\(error.localizedDescription)")
            }
        }
    }
}
