library preconsult.globals;

List name = [
  [
    "NEONATAL \n AGE (0M-3M)",
    "Neonatologist \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "TODDLER \n AGE (3M - 3Y)",
    "Paediatrician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "PEDIATRIC \n AGE (3Y - 12Y)",
    "Paediatrician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    'ADOLESCENT \n AGE (13Y - 18Y)',
    "Adolescent \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "ADULT \n AGE (18Y - 30Y)",
    "Physician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "ADULT \n AGE (30Y - 45Y)",
    "Physician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "MIDDLE AGED \n AGE (45Y - 60Y)",
    "Physician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "AGED \n AGE (60Y - 70Y)",
    "Physician \nDr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "OLD AGED \n AGE (70Y - 80Y)",
    "Physician \n Dr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ],
  [
    "OLD AGED \n AGE (80Y +)",
    "Physician \n Dr. XYZ \n Phone No: +91 884442111 \n Changes Require Approvals MedOnGo , BMC and Doctor Approvals",
  ]
];

List flow = [
  ["NeoNatal Male", "NeoNatal Female", "NeoNatal Others"],
  ["Toddler Male", "Toddler Female", "Toddler Others"],
  ["Pediatric Male", "Pediatric Female", "Pediatric Others"],
  ["Adolescent Male", "Adolescent Female", "Adolescent Others"],
  ['adultMale(18y-30y)','adultFemale(18y-30y)',' adultOthers(18y-30y)'],
  ['adultMale(31y-45y)','adultFemale(31y-45y)', "adultOthers(31y-45y)"],
  ['middleAgedMale(46y-60y)', 'middleAgedFemale(46y-60y)', 'middleAgedOthers(46y-60y)'],
  ['agedAdultMale(61y-70y)','agedAdultFemale(61y-70y)', "agedAdultOthers(61y-70y)"],
  ['oldAgedMale(71Y-80Y)','oldAgedFemale(71Y-80Y)','oldAgedOthers(71Y-80Y)'],
  ['80+Male', '80+female', '80+Others']
];


List<String> groups = ['Select From Below','Personal', 'Social', 'Clinical History', 'Screening', 'Anemia Assessment', 'Referral'];
List<String> inputMode = ['none','text','numeric','date','dateTime','duration','options', 'multiOptions'];
List<String> mandatory = ["true", "false"];