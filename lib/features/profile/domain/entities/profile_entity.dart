class PropertyDetailEntity {
  final String? projectName;
  final String? unit;
  final String? phase;
  final String? bookingDate;

  const PropertyDetailEntity({
    this.projectName,
    this.unit,
    this.phase,
    this.bookingDate,
  });
}

class ProfileEntity {
  final String? name;
  final String? email;
  final String? phone;
  final String? dateOfBirth;
  final String? memberSince;
  final int? ticketsRaised;
  final int? documentsCount;
  final PropertyDetailEntity? property;

  const ProfileEntity({
    this.name,
    this.email,
    this.phone,
    this.dateOfBirth,
    this.memberSince,
    this.ticketsRaised,
    this.documentsCount,
    this.property,
  });

  ProfileEntity copyWith({
    String? name,
    String? email,
    String? phone,
    String? dateOfBirth,
    String? memberSince,
    int? ticketsRaised,
    int? documentsCount,
    PropertyDetailEntity? property,
  }) => ProfileEntity(
    name: name ?? this.name,
    email: email ?? this.email,
    phone: phone ?? this.phone,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    memberSince: memberSince ?? this.memberSince,
    ticketsRaised: ticketsRaised ?? this.ticketsRaised,
    documentsCount: documentsCount ?? this.documentsCount,
    property: property ?? this.property,
  );
}
