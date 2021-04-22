@testable import ScenarioBuilderExample

extension Patient {

    // FIXME: IRL there would be reasonable defaults here
    static func fixture(
        name: String = "",
        dateOfBirth: Date = Date(),
        address: Address = .fixture()
    ) -> Patient {
        Patient(name: name, dateOfBirth: dateOfBirth, address: address)
    }
}

extension Doctor {

    static func fixture(
        name: String = "a name",
        license: String = "123ABC",
        specialty: Specialty = .generalPractitioner
    ) -> Doctor {
        Doctor(name: name, license: license, specialty: specialty)
    }
}

extension Address {

    // FIXME: IRL there would be reasonable defaults here
    static func fixture(
        streetNumber: String = "",
        street: String = "",
        city: String = "",
        state: String = "",
        postCode: String = ""
    ) -> Address {
        Address(
            streetNumber: streetNumber,
            street: street,
            city: city,
            state: state,
            postCode: postCode
        )
    }
}

