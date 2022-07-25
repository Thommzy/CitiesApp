//
//  NetworkService.swift
//  Square1Cities
//
//  Created by Timothy Obeisun on 7/21/22.
//
import Foundation

struct NetworkService {
    
    //MARK:- Singleton
    static let shared = NetworkService()
    
    private init() {}
    
    func searchCities(searchParmeter: String,
                      page: Int,
                      completion: @escaping (Result<Cities, Error>) -> Void) {
        request(route: .filterCity(searchParmeter, page),
                method: .get,
                completion: completion)
    }
    
    func fetchCities(page: Int,
                     completion: @escaping (Result<Cities, Error>) -> Void) {
        request(route: .fetchCities(page),
                method: .get,
                completion: completion)
    }
    
    private func request<T: Codable>(route: Route,
                                     method: Method,
                                     parameters: [String: Any]? = nil,
                                     completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = createRequest(route: route,
                                          method: method,
                                          parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            var result: Result<Data, Error>?
            if let data = data {
                result = .success(data)
            } else if let error = error {
                result = .failure(error)
            }
            DispatchQueue.main.async {
                //MARK:-Decode our result and send back to the user
                self.handleResponse(result: result, completion: completion)
            }
        }.resume()
        
    }
    
    private func handleResponse<T: Decodable>(result: Result<Data, Error>?,
                                              completion: (Result<T, Error>) -> Void) {
        guard let result = result else {
            completion(.failure(AppError.unknownError))
            return
        }
        switch result {
        case .success(let data):
            let decoder = JSONDecoder()
            guard let response = try? decoder.decode(ApiResponse<T>.self, from: data) else {
                completion(.failure(AppError.errorDecoding))
                return
            }
            if let decodedData = response.data {
                completion(.success(decodedData))
            } else {
                completion(.failure(AppError.unknownError))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
    
    
    /// This Function helps us to generate a url Request
    /// - Parameters:
    ///   - route: The Path to the resource in the back end
    ///   - method: Type of request to be made
    ///   - parameters: whatever information need to pass to the back End
    /// - Returns: Url Request
    private func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        let urlString = Route.baseUrl + route.description
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)")}
                urlRequest.url = urlComponent?.url
            }
        }
        
        return urlRequest
    }
}
