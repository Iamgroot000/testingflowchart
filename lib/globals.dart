library preconsult.globals;

List name = [
  [
    "NEONATAL \n AGE (0M-3M)",
    "Neonatologist \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "TODDLER \n AGE (3M - 2Y)",
    "Paediatrician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "PEDIATRIC \n AGE (2Y - 6Y)",
    "Paediatrician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    'ADOLESCENT \n AGE (7Y - 12Y)',
    "Adolescent \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    'SEMIADULT \n AGE (13 - 17Y)',
    "Physician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "ADULT \n AGE (18Y - 30Y)",
    "Physician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "ADULT \n AGE (31Y - 40Y)",
    "Physician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "MIDDLE AGED \n AGE (41Y - 60Y)",
    "Physician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "AGED \n AGE (61Y - 70Y)",
    "Physician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "OLD AGED \n AGE (71Y - 85Y)",
    "Physician \n Dr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "OLD AGED \n AGE (85Y +)",
    "Physician \n Dr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ]
];

List flow = [
  ["NeoNatal"],
  ["Toddler"],
  ['Pediatric'],
  ['Adoloscent'],
  ['SEMIADULT Male','SEMIADULT Female'],
  ['ADULT (18Y - 30Y) Male','ADULT (18Y - 30Y) Female'],
  ['ADULT (31Y - 40Y) Male', 'ADULT (31Y - 40Y) Female'],
  ['MIDDLE AGED (41Y - 60Y) Male','MIDDLE AGED (41Y - 60Y) Female'],
  ['AGED (61Y - 70Y) Male','AGED (61Y - 70Y) Female'],
  ['OLD AGED (71Y - 85Y) Male','OLD AGED (71Y - 85Y) Female'],
  ['85+ Male', '85+ Female']
];


List<String> groups = ['Select From Below','Personal', 'Social', 'Clinical History', 'Screening', 'Anemia Assessment', 'Referral'];
List<String> inputMode = ['none','text','numeric','date','dateTime','duration','options', 'multiOptions'];
List<String> mandatory = ["true", "false"];