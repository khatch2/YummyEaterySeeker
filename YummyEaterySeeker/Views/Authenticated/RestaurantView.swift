//
//  RestaurantView.swift
//  YummyEaterySeeker
//
//  Created by Khatch Shah on 2023-11-01.
//

import SwiftUI

extension Image {
    init?(base64String: String) {
        guard let data = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            print("Error in converting from String to Data")
            return nil }
        
        guard let uiImage = UIImage(data: data) else {
            print("Error in convering from Data to UIImage")
            print(data.description)
            print()
            return nil }
        
        self = Image(uiImage: uiImage)
    }
}

struct RestaurantView: View {
    
    var restaurantStation: RestaurantStation
    
    var base64String = "data:image/html;base64,PGh0bWwgbGFuZz0iZGUiPjxoZWFkPjxtZXRhIGh0dHAtZXF1aXY9IkNvbnRlbnQtVHlwZSIgY29udGVudD0idGV4dC9odG1sOyBjaGFyc2V0PUlTTy04ODU5LTEiPjx0aXRsZT5XZWl0ZXJsZWl0dW5nc2hpbndlaXM8L3RpdGxlPjxzdHlsZT5ib2R5LGRpdixhe2ZvbnQtZmFtaWx5OmFyaWFsLHNhbnMtc2VyaWZ9Ym9keXtiYWNrZ3JvdW5kLWNvbG9yOiNmZmY7bWFyZ2luLXRvcDozcHh9ZGl2e2NvbG9yOiMwMDB9YTpsaW5re2NvbG9yOiM0YjExYTg7fWE6dmlzaXRlZHtjb2xvcjojNGIxMWE4O31hOmFjdGl2ZXtjb2xvcjojZWE0MzM1fWRpdi5teW1Hb3tib3JkZXItdG9wOjFweCBzb2xpZCAjZGFkY2UwO2JvcmRlci1ib3R0b206MXB4IHNvbGlkICNkYWRjZTA7YmFja2dyb3VuZDojZjhmOWZhO21hcmdpbi10b3A6MWVtO3dpZHRoOjEwMCV9ZGl2LmFYZ2FHYntwYWRkaW5nOjAuNWVtIDA7bWFyZ2luLWxlZnQ6MTBweH1kaXYuZlRrN3Zke21hcmdpbi1sZWZ0OjM1cHg7bWFyZ2luLXRvcDozNXB4fTwvc3R5bGU+PC9oZWFkPjxib2R5PjxkaXYgY2xhc3M9Im15bUdvIj48ZGl2IGNsYXNzPSJhWGdhR2IiPjxmb250IHN0eWxlPSJmb250LXNpemU6bGFyZ2VyIj48Yj5XZWl0ZXJsZWl0dW5nc2hpbndlaXM8L2I+PC9mb250PjwvZGl2PjwvZGl2PjxkaXYgY2xhc3M9ImZUazd2ZCI+Jm5ic3A7RGllIHZvbiBkaXIgYmVzdWNodGUgU2VpdGUgdmVyc3VjaHQsIGRpY2ggYW4gPGEgaHJlZj0iaHR0cHM6Ly9lbi5tLndpa2lwZWRpYS5vcmcvd2lraS9GaWxlOlNtYWxsX1JlZF9Sb3NlLkpQRyI+aHR0cHM6Ly9lbi5tLndpa2lwZWRpYS5vcmcvd2lraS9GaWxlOlNtYWxsX1JlZF9Sb3NlLkpQRzwvYT4gd2VpdGVyenVsZWl0ZW4uPGJyPjxicj4mbmJzcDtGYWxscyBkdSBkaWVzZSBTZWl0ZSBuaWNodCBiZXN1Y2hlbiBt9mNodGVzdCwga2FubnN0IGR1IDxhIGhyZWY9IiMiIGlkPSJ0c3VpZF8xIj56dXIgdm9yaGVyaWdlbiBTZWl0ZSB6dXL8Y2trZWhyZW48L2E+LjxzY3JpcHQgbm9uY2U9IjlmTUM0TnM1S2o5TmExSzA0SnRyUnciPihmdW5jdGlvbigpe3ZhciBpZD0ndHN1aWRfMSc7KGZ1bmN0aW9uKCl7ZG9jdW1lbnQuZ2V0RWxlbWVudEJ5SWQoaWQpLm9uY2xpY2s9ZnVuY3Rpb24oKXt3aW5kb3cuaGlzdG9yeS5iYWNrKCk7cmV0dXJuITF9O30pLmNhbGwodGhpcyk7fSkoKTsoZnVuY3Rpb24oKXt2YXIgaWQ9J3RzdWlkXzEnO3ZhciBjdD0nb3JpZ2lubGluayc7dmFyIG9pPSd1bmF1dGhvcml6ZWRyZWRpcmVjdCc7KGZ1bmN0aW9uKCl7ZG9jdW1lbnQuZ2V0RWxlbWVudEJ5SWQoaWQpLm9ubW91c2Vkb3duPWZ1bmN0aW9uKCl7dmFyIGI9ZG9jdW1lbnQmJmRvY3VtZW50LnJlZmVycmVyLGE9ImVuY29kZVVSSUNvbXBvbmVudCJpbiB3aW5kb3c/ZW5jb2RlVVJJQ29tcG9uZW50OmVzY2FwZSxjPSIiO2ImJihjPWEoYikpOyhuZXcgSW1hZ2UpLnNyYz0iL3VybD9zYT1UJnVybD0iK2MrIiZvaT0iK2Eob2kpKyImY3Q9IithKGN0KTtyZXR1cm4hMX07fSkuY2FsbCh0aGlzKTt9KSgpOzwvc2NyaXB0Pjxicj48YnI+PGJyPjwvZGl2PjwvYm9keT48L2h0bWw+"
//    var stringData = Data(base64Encoded: base64String)
    
//    var uiImage = UIImage(data: stringData)
    
//    let swiftUI = Image(uiImage: uiImage)
        
        var body: some View {
            
            NavigationLink(destination: SecondScreenView(restaurantStation: restaurantStation), label: {
                
                HStack {
                    
                    let swiftUI = Image(base64String: base64String)
                    
                
                    
//                    Text("\(person.firstName) \(person.lastName)")
                    
                }.foregroundColor(.white)
            })
            

            
        }
    
    
}

#Preview {
    RestaurantView(restaurantStation: RestaurantStation(name: "String", latitude: 0, longitude: 0))
}
