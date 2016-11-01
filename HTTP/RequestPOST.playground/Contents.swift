//: Playground - noun: a place where people can play

import UIKit

/**
 */
func requestPOST(stringURL url:String) -> URLSessionDataTask? {
    var task: URLSessionDataTask? = nil
    
    guard let url: URL = URL(string: url) else {
        print("URL is invalid..!!")
        return task
    }
    
    let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "POST"
    
    /* 
     * You should pass a nil completion handler only when creating tasks in sessions whose delegates include a urlSession(_:dataTask:didReceive:) method.
     */
    task = urlSession.dataTask(with: urlRequest, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) in
        /*
         * If a response from the server is received, regardless of whether the request completes successfully or fails,
         * the response parameter contains that information.
         */
        guard let httpResponse = response as? HTTPURLResponse else {
            print("The response is nil. Something is wrong..!!")
            return
        }
        
        print("Status Code: \(httpResponse.statusCode)\n")
        
        if let error = error {
            print("Error: " + error.localizedDescription)
            return
        }
        
        guard let _ = data else {
            print("The data is nil. Something is wrong..!!")
            return
        }
    })
    
    task!.resume()
    return task
}

let url = "http://httpbin.org/post"
if let task = requestPOST(stringURL: url) {
    while task.state == .running {
        usleep(500)
    }
    print(task.state.rawValue)
}
