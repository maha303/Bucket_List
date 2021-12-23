//
//  TaskModel.swift
//  Bucket_List
//
//  Created by Maha saad on 19/05/1443 AH.
//

import Foundation

class TaskModel {
    static func getAllTasks(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    
    static func addTasks(objective: String, completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
                if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/") {
                    var request = URLRequest(url: urlToReq)
                    request.httpMethod = "POST"
                    let bodyData = "objective=\(objective)"
                    request.httpBody = bodyData.data(using: .utf8)
                    let session = URLSession.shared
                    let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                    task.resume()
                }
        }
    
    
    static func updateTask(index:Int,objective:String,completionHandler: @escaping(_ data: Data?, _ response:URLResponse?, _ error:Error?) -> Void){
        if let urlToReq = URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(index)/") {
                        // Create an NSMutableURLRequest using the url. This Mutable Request will allow us to modify the headers.
                        var request = URLRequest(url: urlToReq)
                        
                        // Set the method to PUT
                        request.httpMethod = "PUT"
                        request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
                        request.setValue("application/json", forHTTPHeaderField: "Accept")
                        // Create some bodyData and attach it to the HTTPBody
                        let bodyData = "{\"objective\":\"\(objective)\"}"
                        request.httpBody = bodyData.data(using: .utf8)
                        // Create the session
                        let session = URLSession.shared
                        let task = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                        task.resume()
        }
    }
    
    static func deleteTask(index:Int, completionHandler: @escaping(_ data: Data?, _ response:URLResponse?, _ error:Error?) -> Void){
            var request = URLRequest(url: URL(string: "https://saudibucketlistapi.herokuapp.com/tasks/\(index)")!)
            request.httpMethod = "DELETE"
            URLSession.shared.dataTask(with: request,completionHandler: completionHandler).resume()
        }
        
}
