import Foundation

class APIConnector {
    private var requests: PrepareRequests
    
    init(requests: PrepareRequests) {
        self.requests = requests
        makeRequest()
    }
    
    private func makeRequest() {
        let allRequests = requests.getAllPreparedRequests()
        
        for req in allRequests {
            let request = URLRequest(url: URL(string: req)!)
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let books = try? JSONDecoder().decode(Books.self, from: data)  {
                    print(books.items[0].volumeInfo.authors)
                    print(books.items[0].volumeInfo.title)
                }
            }
            task.resume()
        }
    }
}
