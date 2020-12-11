//
//  HSNetWorkManager.swift
//  HSSwiftProject
//
//  Created by 孔祥刚 on 2020/5/18.
//  Copyright © 2020 孔祥刚. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import SwiftyJSON



enum HSNetWorkResult<Model> {
    case success(Model,JSON)
    case failure(HSError)
}

/// 请求结果回调
typealias ResultBlock<Model> = (HSNetWorkResult<Model>) -> Void

/// 进度
typealias AFSProgressBlock = (Double) -> Void


class HSNetWorkManager: NSObject {
    
    static let shared = HSNetWorkManager()
    private var sessionManager: SessionManager?
    
    override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = Alamafire_TimeoutIntervalForRequest
        sessionManager = SessionManager.init(configuration: configuration, delegate: SessionDelegate.init(), serverTrustPolicyManager: nil)
    }
    
    
}


// MARK: 公用调用方法
extension HSNetWorkManager {
    
    /// 普通请求
    /// - Parameters:
    ///   - url: url 建议通过HSBaseApi生成
    ///   - parameters: 参数列表
    ///   - header: header
    ///   - method: 请求方法
    ///   - baseModel: 返回的model类型（需遵循Mappable）
    ///   - completion: 请求回调
    
    func request<Model: Mappable>(url: String, parameters: [String: Any]? = nil, header: HTTPHeaders? = nil, method : HTTPMethod? = .get, baseModel: Model.Type, completion: @escaping ResultBlock<Model>) -> Void {
        
        let header1 = header ?? HSDefaultHeader.defaultHeader()
        
        switch method {
        case .get:
            self.GET(url: url, param: parameters, headers: header1, completion: completion)
            break
            
        case .post:
            self.POST(url: url, param: parameters, headers: header1, completion: completion)
            
        default:
            break
        }
    }
    
    
    
    
}


// MARK: 私有方法
extension HSNetWorkManager {
    
    fileprivate func GET<Model: Mappable>(url: String, param: Parameters?, headers: HTTPHeaders, completion: @escaping ResultBlock<Model>) -> Void {
    //        let encodStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
        self.sessionManager?.request(url, method: .get, parameters: param, encoding: URLEncoding.default, headers: headers)
            .validate()
            .responseJSON { (response) in
                
                self.handleResponse(response: response, completion: completion)
        }
        
    }
    
    
    
    fileprivate func POST<Model: Mappable>(url: String, param: Parameters?, headers: HTTPHeaders, completion: @escaping ResultBlock<Model>) -> Void {
            
        
        self.sessionManager?.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody, headers: headers)
            .validate()
            .responseJSON { (response) in
                
                self.handleResponse(response: response, completion: completion)
        }
        
    }
    
    
 
        
    
        
        
    //    上传图片
    
    func postImage<Model: Mappable>(image: UIImage, url: String, param: Parameters?, headers: HTTPHeaders, isShowHUD: Bool, progressBlock: @escaping AFSProgressBlock, completion: @escaping ResultBlock<Model>) {
            
            let imageData = image.jpegData(compressionQuality: 0.0001)
            let headers = ["content-type":"multipart/form-data"]
            self.sessionManager?.upload(multipartFormData: { (multipartFormData) in
                //采用post表单上传
                // 参数解释
                let dataStr = DateFormatter.init()
                dataStr.dateFormat = "yyyyMMddHHmmss"
                let fileName = "\(dataStr.string(from: Date.init())).png"
                multipartFormData.append(imageData!, withName: "file", fileName: fileName, mimeType: "image/jpg/png/jpeg")
            }, to: url, headers: headers, encodingCompletion: { (encodingResult) in
                
                switch encodingResult {
                case .success(let upload, _, _):
                    //连接服务器成功后，对json的处理
                    upload.responseJSON { response in
                        //解包
                        self.handleResponse(response: response, completion: completion)
                    }
                    //获取上传进度
                    upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                        progressBlock(progress.fractionCompleted)
                        print("图片上传进度: \(progress.fractionCompleted)")
                    }
                    break
                case .failure(let encodingError):
                    self.handleRequestError(error: encodingError as NSError, completion: completion)
                    break
                }
            })
        }
    
    func postVideo<Model: Mappable>(video: Data, url: String, param: Parameters?,headers: HTTPHeaders,isShow: Bool, progressBlock: @escaping AFSProgressBlock, completion: @escaping ResultBlock<Model>) {
        
        self.sessionManager?.upload(multipartFormData: { (multipartFormData) in
            //采用post表单上传
            // 参数解释
            let dataStr = DateFormatter.init()
            dataStr.dateFormat = "yyyyMMddHHmmss"
            let fileName = "\(dataStr.string(from: Date.init())).mp4"
            multipartFormData.append(video, withName: "file", fileName: fileName, mimeType: "video/mp4")
        }, to: url, headers: headers, encodingCompletion: { (encodingResult) in
            
            switch encodingResult {
            case .success(let upload, _, _):
                //连接服务器成功后，对json的处理
                upload.responseJSON { response in
                    //解包
                    self.handleResponse(response: response, completion: completion)
                    //                    print("json:\(result)")
                }
                //获取上传进度
                upload.uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                    progressBlock(progress.fractionCompleted)
                    print("图片上传进度: \(progress.fractionCompleted)")
                }
                break
            case .failure(let encodingError):
                self.handleRequestError(error: encodingError as NSError, completion: completion)
                break
            }
        })
    }
        
        
        
    
}


// MARK: 处理数据
extension HSNetWorkManager {
    /** 处理服务器响应数据*/
    private func handleResponse<Model: Mappable>(response:DataResponse<Any>, completion: @escaping ResultBlock<Model>){
        if let error = response.result.error {
            // 服务器未返回数据
            self.handleRequestError(error: error as NSError, completion: completion)
            
        }else if let value = response.result.value {
            // 服务器有返回数据
            if (value as? NSDictionary) == nil {
                // 返回格式不对
                self.handleRequestSuccessWithFaliedBlcok(completion: completion)
            }else{
                self.handleRequestSuccess(value: value, completion: completion)
            }
        }
    }
    
    /** 处理请求失败数据*/
    private func handleRequestError<Model: Mappable>(error: NSError, completion: @escaping ResultBlock<Model>){
        var errorInfo = HSError()
        errorInfo.code = error.code
        errorInfo.error = error
        if ( errorInfo.code == -1009 ) {
            errorInfo.message = "无网络连接"
        }else if ( errorInfo.code == -1001 ){
            errorInfo.message = "请求超时"
        }else if ( errorInfo.code == -1005 ){
            errorInfo.message = "网络连接丢失(服务器忙)"
        }else if ( errorInfo.code == -1004 ){
            errorInfo.message = "服务器没有启动"
        }else if ( errorInfo.code == 404 || errorInfo.code == 3) {
            errorInfo.message = "无权限"
        } else {
            errorInfo.message = error.localizedDescription
        }
        completion(.failure(errorInfo))
    }
    
     /** 处理请求成功数据*/
    private func handleRequestSuccess<Model: Mappable>(value:Any, completion: @escaping ResultBlock<Model>){
        let json: JSON = JSON(value)
        
        guard let baseModel = Model.init(JSONString: json.description) else {
            var errorInfo = HSError()
            
            errorInfo.message = "转换base model失败"
            completion(.failure(errorInfo))
            return
        }
        completion(.success(baseModel, json))
    }
    
    /** 服务器返回数据解析出错*/
    private func handleRequestSuccessWithFaliedBlcok<Model: Mappable>(completion: @escaping ResultBlock<Model>){
        var errorInfo = HSError()
        errorInfo.code = -1
        errorInfo.message = "数据解析出错"
        completion(.failure(errorInfo))
        
    }
}

