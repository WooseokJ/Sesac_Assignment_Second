import Foundation


guard let result = json.data(using: .utf8) else {fatalError("Error")}
print(result)

//data(json) -> quote(모델로)
do{
    let value = try JSONDecoder().decode(BoxOffice.self, from: result)
    print(value)
}catch {
    print(error)
}
