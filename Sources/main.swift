import OpenAPIRuntime
import OpenAPIURLSession
//import OversizeServices

//public actor NetworkService {
//    let client: Client
//
//    public init() {
//        self.client = Client(
//            serverURL: try! Servers.server1(),
//            transport: URLSessionTransport()
//        )
//    }
//
//    public func fetchAccountStatus() async -> Result<Operations.getBanners.Output, Error> {
//        do {
//            let result = try await client.getBanners(.init())
//            return .success(result)
//        } catch {
//            return .failure(error)
//        }
//    }
//}
