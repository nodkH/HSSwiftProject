//
//  ViewController.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/5/18.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit
import Alamofire



class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "首页"
        self.view.backgroundColor = .white
        
        let button = UIButton(frame: CGRect(x: 50, y: 200, width: 160, height: 66))
        button.setTitle("send post", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(sendPostRequest), for: .touchUpInside)
        self.view.addSubview(button)
        
        let button1 = UIButton(frame: CGRect(x: 50, y: 300, width: 160, height: 66))
        button1.setTitle("send get", for: .normal)
        button1.setTitleColor(.blue, for: .normal)
        button1.addTarget(self, action: #selector(sendGetRequest), for: .touchUpInside)
        self.view.addSubview(button1)
        
//        self.sendRequest()
        
    }

    
    @objc func sendGetRequest() {
        let parameters = [
            "act" : "goods",
            "op" : "get_goods_detail_voucher",
            "goods_id" : "877780031",
            "from_client" : "app",
            "key" : "40979c565f786cb918601ebf0582dba0"
        ] as [String : Any]
        
        let url =  String(system: .by) + "?act=goods&op=get_goods_detail_voucher&goods_id=877780031&from_client=app&key=40979c565f786cb918601ebf0582dba0"
        
        HSNetWorkManager.shared.request(url: String(system: .by), parameters: parameters, baseModel: BaseModel2.self, success: { (baseModel, json) in
            print(json)
        }) { (error) in
            print(error.message)
        }

        
    }
    
    
    @objc func sendPostRequest() {
        let parameters = [
            "userId" : "aeb4572975c14f1899d375f1caf3ad83",
            "content" : "fdd"
        ] as [String : Any]
        HSNetWorkManager.shared.request(url: String(system: .post) + "question/issue",  parameters: parameters, method: .post, baseModel: HSBaseModel.self, success: { [weak self](baseModel, json) in
            if baseModel.isSuccess == true {
                baseModel.result?["content"]
                let resultModel = postModel(JSON: baseModel.result ?? [String : Any]())
                print(resultModel?.content)
                
            } else {
                print(baseModel.msg)
            }
        }) { (error) in
            print(error.message)
        }
        
//        let type = HSRequestType()
        
//        HSNetWorkManager.shared.request(requestType: <#T##HSRequestType#>, model: <#T##Mappable.Protocol#>, success: <#T##(HSBaseModel<Mappable>, JSON) -> Void#>, failed: <#T##NetFailedBlock##NetFailedBlock##(HSError) -> Void#>)
    }

}


