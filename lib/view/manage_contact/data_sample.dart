// ignore_for_file: lines_longer_than_80_chars

const sampleList = {
  'contacts': [
   {
      'name': 'John Doe',
      'company_name': 'ABC Corporation',
      'email': 'john.doe@example.com',
      'phone_number': '+1234567890',
      'company_address': '123 Main St, City, Country',
      'company_landline': '+9876543210',
      'company_location': 'United Arab Emirates',
      'company_website': 'https://www.example.com',
      'created_by': 'Jane Smith',
      'type': 'Inv2023',
      'contact_source': 'Trade Show',
      'contact_designation': 'Sales Manager',
      'remarks': 'Interested in product X',
      'sample_followup_message': 'Thank you for expressing interest. We will get back to you shortly.',
      'followup_date': '2024-03-20',
    },
    {
      'name': 'Alice Smith',
      'company_name': 'XYZ Corporation',
      'email': 'alice.smith@example.com',
      'phone_number': '+1987654321',
      'company_address': '456 Oak St, City, Country',
      'company_landline': '+8765432109',
      'company_location': 'France',
      'company_website': 'https://www.xyzcorp.com',
      'created_by': 'Bob Johnson',
      'type': 'Meet2022',
      'contact_source': 'Referral',
      'contact_designation': 'Marketing Director',
      'remarks': 'Interested in partnership opportunities',
      'sample_followup_message': "Let's schedule a call to discuss further.",
      'followup_date': '2024-03-18',
    },
    {
      'name': 'Emma Brown',
      'company_name': '123 Industries',
      'email': 'emma.brown@example.com',
      'phone_number': '+1122334455',
      'company_address': '789 Elm St, City, Country',
      'company_landline': '+9988776655',
      'company_location': 'Germany',
      'company_website': 'https://www.123industries.com',
      'created_by': 'Sam Green',
      'type': 'Sem2025',
      'contact_source': 'Website Inquiry',
      'contact_designation': 'CEO',
      'remarks': 'Needs quotation for bulk purchase',
      'sample_followup_message': 'Sending you the quotation shortly.',
      'followup_date': '2024-03-17',
    },
    {
      'name': 'Michael Johnson',
      'company_name': 'Tech Solutions Ltd.',
      'email': 'michael.johnson@example.com',
      'phone_number': '+5544332211',
      'company_address': '456 Pine St, City, Country',
      'company_landline': '+6677889900',
      'company_location': 'United States',
      'company_website': 'https://www.techsolutions.com',
      'created_by': 'Linda Lee',
      'type': 'Conf2024',
      'contact_source': 'Cold Call',
      'contact_designation': 'IT Manager',
      'remarks': 'Interested in software upgrade',
      'sample_followup_message': "Let's schedule a demo to showcase our latest features.",
      'followup_date': '2024-03-19',
    },
    {
      'name': 'Sophia Martinez',
      'company_name': 'Martinez Enterprises',
      'email': 'sophia.martinez@example.com',
      'phone_number': '+9876543210',
      'company_address': '789 Maple St, City, Country',
      'company_landline': '+1234567890',
      'company_location': 'Canada',
      'company_website': 'https://www.martinezenterprises.com',
      'created_by': 'David Brown',
      'type': 'Sem2026',
      'contact_source': 'Email Campaign',
      'contact_designation': 'Operations Manager',
      'remarks': 'Interested in our consulting services',
      'sample_followup_message': "Let's arrange a meeting to discuss your requirements.",
      'followup_date': '2024-03-21',
    },
    {
      'name': 'Emily Wilson',
      'company_name': 'Wilson Solutions',
      'email': 'emily.wilson@example.com',
      'phone_number': '+1122334455',
      'company_address': '123 Oak St, City, Country',
      'company_landline': '+9988776655',
      'company_location': 'United Kingdom',
      'company_website': 'https://www.wilsonsolutions.com',
      'created_by': 'Alex Johnson',
      'type': 'Inv2024',
      'contact_source': 'Website Inquiry',
      'contact_designation': 'Project Manager',
      'remarks': 'Interested in our software solutions',
      'sample_followup_message': 'We will send you more information shortly.',
      'followup_date': '2024-03-22',
    },
    {
      'name': 'Ethan Adams',
      'company_name': 'Adams Enterprises',
      'email': 'ethan.adams@example.com',
      'phone_number': '+1122334455',
      'company_address': '456 Pine St, City, Country',
      'company_landline': '+9988776655',
      'company_location': 'Australia',
      'company_website': 'https://www.adamsenterprises.com',
      'created_by': 'Sarah Miller',
      'type': 'Conf2025',
      'contact_source': 'Trade Show',
      'contact_designation': 'Sales Representative',
      'remarks': 'Interested in discussing partnership opportunities',
      'sample_followup_message': 'We look forward to meeting you at the event.',
      'followup_date': '2024-03-23',
    },
    {
      'name': 'David White',
      'company_name': 'White Solutions',
      'email': 'david.white@example.com',
      'phone_number': '+1122334455',
      'company_address': '789 Elm St, City, Country',
      'company_landline': '+9988776655',
      'company_location': 'Singapore',
      'company_website': 'https://www.whitesolutions.com',
      'created_by': 'Laura Harris',
      'type': 'Meet2023',
      'contact_source': 'Referral',
      'contact_designation': 'Marketing Manager',
      'remarks': 'Interested in our marketing services',
      'sample_followup_message': "Let's schedule a meeting to discuss your requirements.",
      'followup_date': '2024-03-24',
    },
    {
      'name': 'Olivia Brown',
      'company_name': 'Brown Technologies',
      'email': 'olivia.brown@example.com',
      'phone_number': '+1122334455',
      'company_address': '456 Maple St, City, Country',
      'company_landline': '+9988776655',
      'company_location': 'Japan',
      'company_website': 'https://www.browntechnologies.com',
      'created_by': 'Mark Davis',
      'type': 'Sem2027',
      'contact_source': 'Website Inquiry',
      'contact_designation': 'IT Director',
      'remarks': 'Interested in our latest technology solutions',
      'sample_followup_message': 'We will provide you with a demo soon.',
      'followup_date': '2024-03-25',
    },
    {
      'name': 'Sophie Taylor',
      'company_name': 'Taylor Enterprises',
      'email': 'sophie.taylor@example.com',
      'phone_number': '+1122334455',
      'company_address': '789 Oak St, City, Country',
      'company_landline': '+9988776655',
      'company_location': 'South Africa',
      'company_website': 'https://www.taylorenterprises.com',
      'created_by': 'Daniel Wilson',
      'type': 'Inv2025',
      'contact_source': 'Cold Call',
      'contact_designation': 'Sales Associate',
      'remarks': 'Interested in our products',
      'sample_followup_message': 'We will send you a catalog soon.',
      'followup_date': '2024-03-26',
    },
    {
      'name': 'Lucas Lee',
      'company_name': 'Lee Solutions',
      'email': 'lucas.lee@example.com',
      'phone_number': '+1122334455',
      'company_address': '123 Pine St, City, Country',
      'company_landline': '+9988776655',
      'company_location': 'Brazil',
      'company_website': 'https://www.leesolutions.com',
      'created_by': 'Sophie Taylor',
      'type': 'Conf2026',
      'contact_source': 'Email Campaign',
      'contact_designation': 'Marketing Executive',
      'remarks': 'Interested in our upcoming conference',
      'sample_followup_message': 'We will send you the registration details soon.',
      'followup_date': '2024-03-27',
    },
    {
      'name': 'Ava Johnson',
      'company_name': 'Johnson Enterprises',
      'email': 'ava.johnson@example.com',
      'phone_number': '+1122334455',
      'company_address': '456 Elm St, City, Country',
      'company_landline': '+9988776655',
      'company_location': 'India',
      'company_website': 'https://www.johnsonenterprises.com',
      'created_by': 'Lucas Lee',
      'type': 'Sem2028',
      'contact_source': 'Website Inquiry',
      'contact_designation': 'Business Development Manager',
      'remarks': 'Interested in exploring partnership opportunities',
      'sample_followup_message': 'We will contact you to discuss further.',
      'followup_date': '2024-03-28',
    },
    {
      'name': 'Noah Garcia',
      'company_name': 'Garcia Solutions',
      'email': 'noah.garcia@example.com',
      'phone_number': '+1122334455',
      'company_address': '789 Pine St, City, Country',
      'company_landline': '+9988776655',
      'company_location': 'Spain',
      'company_website': 'https://www.garciasolutions.com',
      'created_by': 'Ava Johnson',
      'type': 'Inv2026',
      'contact_source': 'Trade Show',
      'contact_designation': 'Sales Representative',
      'remarks': 'Interested in our services',
      'sample_followup_message': 'We will reach out to you soon.',
      'followup_date': '2024-03-29',
    },
    {
      'name': 'Charlotte Miller',
      'company_name': 'Miller Technologies',
      'email': 'charlotte.miller@example.com',
      'phone_number': '+1122334455',
      'company_address': '123 Maple St, City, Country',
      'company_landline': '+9988776655',
      'company_location': 'Italy',
      'company_website': 'https://www.millertechnologies.com',
      'created_by': 'Noah Garcia',
      'type': 'Meet2024',
      'contact_source': 'Referral',
      'contact_designation': 'IT Manager',
      'remarks': 'Interested in our software solutions',
      'sample_followup_message': 'We will arrange a demo for you.',
      'followup_date': '2024-03-30',
    }
  ],
};

class Contact {

  Contact({
    required this.name,
    required this.companyName,
    required this.email,
    required this.phoneNumber,
    required this.companyAddress,
    required this.companyLandline,
    required this.companyLocation,
    required this.companyWebsite,
    required this.createdBy,
    required this.type,
    required this.contactSource,
    required this.contactDesignation,
    required this.remarks,
    required this.sampleFollowupMessage,
    required this.followupDate,
  });
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'] as String,
      companyName: json['company_name'] as String,
      email: json['email'] as String,
      phoneNumber: json['phone_number'] as String,
      companyAddress: json['company_address'] as String,
      companyLandline: json['company_landline'] as String,
      companyLocation: json['company_location'] as String,
      companyWebsite: json['company_website'] as String,
      createdBy: json['created_by'] as String,
      type: json['type'] as String,
      contactSource: json['contact_source'] as String,
      contactDesignation: json['contact_designation'] as String,
      remarks: json['remarks'] as String,
      sampleFollowupMessage: json['sample_followup_message'] as String,
      followupDate: json['followup_date'] as String,
    );
  }

  String name;
  String companyName;
  String email;
  String phoneNumber;
  String companyAddress;
  String companyLandline;
  String companyLocation;
  String companyWebsite;
  String createdBy;
  String type;
  String contactSource;
  String contactDesignation;
  String remarks;
  String sampleFollowupMessage;
  String followupDate;
}
