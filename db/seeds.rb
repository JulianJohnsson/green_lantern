# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.count == 0
  user = CreateAdminService.new.call
  puts 'CREATED ADMIN USER: ' << user.email
end

country_list = [
  ["Afghanistan",0.5,[0.11,0.115,0.085,0.085,0.105]],["Afrique du Sud",7.8,[1.716,1.794,1.326,1.326,1.638]],["Albanie",3.1,[0.682,0.713,0.527,0.527,0.651]],["Algérie",4.3,[0.946,0.989,0.731,0.731,0.903]],["Allemagne",11.3,[2.486,2.599,1.921,1.921,2.373]],["Andorre",7.7,[1.694,1.771,1.309,1.309,1.617]],["Angola",1.4,[0.308,0.322,0.238,0.238,0.294]],["Antigua-et-Barbuda",5.4,[1.188,1.242,0.918,0.918,1.134]],["Arabie saoudite",19.2,[4.224,4.416,3.264,3.264,4.032]],["Argentine",8.6,[1.892,1.978,1.462,1.462,1.806]],["Arménie",4.2,[0.924,0.966,0.714,0.714,0.882]],["Australie",26.5,[5.83,6.095,4.505,4.505,5.565]],["Autriche",9.6,[2.112,2.208,1.632,1.632,2.016]],["Azerbaïdjan",5.7,[1.254,1.311,0.969,0.969,1.197]],["Bahamas",12.3,[2.706,2.829,2.091,2.091,2.583]],["Bahreïn",22,[4.84,5.06,3.74,3.74,4.62]],["Bangladesh",1.1,[0.242,0.253,0.187,0.187,0.231]],["Barbade",5.4,[1.188,1.242,0.918,0.918,1.134]],["Belgique",10.5,[2.31,2.415,1.785,1.785,2.205]],["Belize",4.2,[0.924,0.966,0.714,0.714,0.882]],["Bénin",1.3,[0.286,0.299,0.221,0.221,0.273]],["Bhoutan",4.1,[0.902,0.943,0.697,0.697,0.861]],["Biélorussie",11.5,[2.53,2.645,1.955,1.955,2.415]],["Birmanie",2.3,[0.506,0.529,0.391,0.391,0.483]],["Bolivie",11.8,[2.596,2.714,2.006,2.006,2.478]],["Bosnie-Herzégovine",7.7,[1.694,1.771,1.309,1.309,1.617]],["Botswana",5.1,[1.122,1.173,0.867,0.867,1.071]],["Brésil",5.6,[1.232,1.288,0.952,0.952,1.176]],["Brunei",34.6,[7.612,7.958,5.882,5.882,7.266]],["Bulgarie",8.8,[1.936,2.024,1.496,1.496,1.848]],["Burkina Faso",2.3,[0.506,0.529,0.391,0.391,0.483]],["Burundi",0.5,[0.11,0.115,0.085,0.085,0.105]],["Cambodge",8,[1.76,1.84,1.36,1.36,1.68]],["Cameroun",4.2,[0.924,0.966,0.714,0.714,0.882]],["Canada",20.6,[4.532,4.738,3.502,3.502,4.326]],["Cap-Vert",0.7,[0.154,0.161,0.119,0.119,0.147]],["Chili",6.7,[1.474,1.541,1.139,1.139,1.407]],["Chine",9,[1.98,2.07,1.53,1.53,1.89]],["Chypre",11.6,[2.552,2.668,1.972,1.972,2.436]],["Colombie",3.5,[0.77,0.805,0.595,0.595,0.735]],["Comores",0.7,[0.154,0.161,0.119,0.119,0.147]],["Corée du Nord",4.3,[0.946,0.989,0.731,0.731,0.903]],["Corée du Sud",13,[2.86,2.99,2.21,2.21,2.73]],["Costa Rica",2.5,[0.55,0.575,0.425,0.425,0.525]],["Côte d’Ivoire",1.4,[0.308,0.322,0.238,0.238,0.294]],["Croatie",6.2,[1.364,1.426,1.054,1.054,1.302]],["Cuba",4.6,[1.012,1.058,0.782,0.782,0.966]],["Curacao",43.2,[9.504,9.936,7.344,7.344,9.072]],["Danemark",8.8,[1.936,2.024,1.496,1.496,1.848]],["Djibouti",2.9,[0.638,0.667,0.493,0.493,0.609]],["Dominique",3,[0.66,0.69,0.51,0.51,0.63]],["Égypte",3,[0.66,0.69,0.51,0.51,0.63]],["Émirats arabes unis",21.8,[4.796,5.014,3.706,3.706,4.578]],["Équateur",3.2,[0.704,0.736,0.544,0.544,0.672]],["Érythrée",1.1,[0.242,0.253,0.187,0.187,0.231]],["Espagne",7.7,[1.694,1.771,1.309,1.309,1.617]],["Estonie",16,[3.52,3.68,2.72,2.72,3.36]],["Eswatini",2.4,[0.528,0.552,0.408,0.408,0.504]],["États-Unis",19.6,[4.312,4.508,3.332,3.332,4.116]],["Éthiopie",1.8,[0.396,0.414,0.306,0.306,0.378]],["Fidji",2.5,[0.55,0.575,0.425,0.425,0.525]],["Finlande",12.5,[2.75,2.875,2.125,2.125,2.625]],["France",7.2,[1.584,1.656,1.224,1.224,1.512]],["Gabon",7.1,[1.562,1.633,1.207,1.207,1.491]],["Gambie",1.7,[0.374,0.391,0.289,0.289,0.357]],["Géorgie",3.9,[0.858,0.897,0.663,0.663,0.819]],["Ghana",1.1,[0.242,0.253,0.187,0.187,0.231]],["Grèce",9.2,[2.024,2.116,1.564,1.564,1.932]],["Grenade",6.7,[1.474,1.541,1.139,1.139,1.407]],["Guatemala",1.9,[0.418,0.437,0.323,0.323,0.399]],["Guinée",8,[1.76,1.84,1.36,1.36,1.68]],["Guinée équatoriale",5,[1.1,1.15,0.85,0.85,1.05]],["Guinée-Bissau",4.1,[0.902,0.943,0.697,0.697,0.861]],["Guyana",7.9,[1.738,1.817,1.343,1.343,1.659]],["Haïti",0.8,[0.176,0.184,0.136,0.136,0.168]],["Honduras",2.2,[0.484,0.506,0.374,0.374,0.462]],["Hongrie",6.6,[1.452,1.518,1.122,1.122,1.386]],["Îles Cook",1.4,[0.308,0.322,0.238,0.238,0.294]],["Îles Marshall",0.1,[0.022,0.023,0.017,0.017,0.021]],["Îles Salomon",7.5,[1.65,1.725,1.275,1.275,1.575]],["Inde",2.2,[0.484,0.506,0.374,0.374,0.462]],["Indonésie",3,[0.66,0.69,0.51,0.51,0.63]],["Irak",4.1,[0.902,0.943,0.697,0.697,0.861]],["Iran",8,[1.76,1.84,1.36,1.36,1.68]],["Irlande",13.3,[2.926,3.059,2.261,2.261,2.793]],["Islande",13.2,[2.904,3.036,2.244,2.244,2.772]],["Israël",9.7,[2.134,2.231,1.649,1.649,2.037]],["Italie",7.3,[1.606,1.679,1.241,1.241,1.533]],["Jamaïque",5.3,[1.166,1.219,0.901,0.901,1.113]],["Japon",11.7,[2.574,2.691,1.989,1.989,2.457]],["Jordanie",2.8,[0.616,0.644,0.476,0.476,0.588]],["Kazakhstan",20.3,[4.466,4.669,3.451,3.451,4.263]],["Kenya",1.1,[0.242,0.253,0.187,0.187,0.231]],["Kirghizistan",2.2,[0.484,0.506,0.374,0.374,0.462]],["Kiribati",0.5,[0.11,0.115,0.085,0.085,0.105]],["Koweït",35,[7.7,8.05,5.95,5.95,7.35]],["Laos",2.4,[0.528,0.552,0.408,0.408,0.504]],["Lesotho",1.6,[0.352,0.368,0.272,0.272,0.336]],["Lettonie",6.1,[1.342,1.403,1.037,1.037,1.281]],["Liban",3,[0.66,0.69,0.51,0.51,0.63]],["Liberia",0.6,[0.132,0.138,0.102,0.102,0.126]],["Libye",12.9,[2.838,2.967,2.193,2.193,2.709]],["Liechtenstein",5.1,[1.122,1.173,0.867,0.867,1.071]],["Lituanie",7.3,[1.606,1.679,1.241,1.241,1.533]],["Luxembourg",20,[4.4,4.6,3.4,3.4,4.2]],["Macédoine du Nord",6.2,[1.364,1.426,1.054,1.054,1.302]],["Madagascar",4.6,[1.012,1.058,0.782,0.782,0.966]],["Malaisie",8.8,[1.936,2.024,1.496,1.496,1.848]],["Malawi",1.2,[0.264,0.276,0.204,0.204,0.252]],["Maldives",0.8,[0.176,0.184,0.136,0.136,0.168]],["Mali",4.2,[0.924,0.966,0.714,0.714,0.882]],["Malte",5.5,[1.21,1.265,0.935,0.935,1.155]],["Maroc",2.3,[0.506,0.529,0.391,0.391,0.483]],["Maurice",1.4,[0.308,0.322,0.238,0.238,0.294]],["Mauritanie",3,[0.66,0.69,0.51,0.51,0.63]],["Mexique",5.1,[1.122,1.173,0.867,0.867,1.071]],["Micronésie",0.6,[0.132,0.138,0.102,0.102,0.126]],["Moldavie",3.2,[0.704,0.736,0.544,0.544,0.672]],["Monaco",7.2,[1.584,1.656,1.224,1.224,1.512]],["Mongolie",8.1,[1.782,1.863,1.377,1.377,1.701]],["Monténégro",7.8,[1.716,1.794,1.326,1.326,1.638]],["Mozambique",0.8,[0.176,0.184,0.136,0.136,0.168]],["Namibie",4.2,[0.924,0.966,0.714,0.714,0.882]],["Nauru",0.1,[0.022,0.023,0.017,0.017,0.021]],["Népal",1.4,[0.308,0.322,0.238,0.238,0.294]],["Nicaragua",2.6,[0.572,0.598,0.442,0.442,0.546]],["Niger",0.5,[0.11,0.115,0.085,0.085,0.105]],["Nigeria",1.6,[0.352,0.368,0.272,0.272,0.336]],["Niue",1.4,[0.308,0.322,0.238,0.238,0.294]],["Norvège",10.3,[2.266,2.369,1.751,1.751,2.163]],["Nouvelle-Zélande",16.3,[3.586,3.749,2.771,2.771,3.423]],["Oman",13.4,[2.948,3.082,2.278,2.278,2.814]],["Ouganda",1.9,[0.418,0.437,0.323,0.323,0.399]],["Ouzbékistan",5.5,[1.21,1.265,0.935,0.935,1.155]],["Pakistan",1.9,[0.418,0.437,0.323,0.323,0.399]],["Palaos",1.7,[0.374,0.391,0.289,0.289,0.357]],["Palestine",9.7,[2.134,2.231,1.649,1.649,2.037]],["Panamá",4,[0.88,0.92,0.68,0.68,0.84]],["Papouasie-Nouvelle-Guinée",1.3,[0.286,0.299,0.221,0.221,0.273]],["Paraguay",7.5,[1.65,1.725,1.275,1.275,1.575]],["Pays-Bas",12,[2.64,2.76,2.04,2.04,2.52]],["Pérou",2.3,[0.506,0.529,0.391,0.391,0.483]],["Philippines",1.6,[0.352,0.368,0.272,0.272,0.336]],["Pologne",11,[2.42,2.53,1.87,1.87,2.31]],["Portugal",7,[1.54,1.61,1.19,1.19,1.47]],["Qatar",39.1,[8.602,8.993,6.647,6.647,8.211]],["République centrafricaine",0.3,[0.066,0.069,0.051,0.051,0.063]],["République démocratique du Congo",0.5,[0.11,0.115,0.085,0.085,0.105]],["République dominicaine",3.1,[0.682,0.713,0.527,0.527,0.651]],["République du Congo",3,[0.66,0.69,0.51,0.51,0.63]],["République tchèque",12.3,[2.706,2.829,2.091,2.091,2.583]],["Roumanie",6.2,[1.364,1.426,1.054,1.054,1.302]],["Royaume-Uni",7.7,[1.694,1.771,1.309,1.309,1.617]],["Russie",19.4,[4.268,4.462,3.298,3.298,4.074]],["Rwanda",0.6,[0.132,0.138,0.102,0.102,0.126]],["Saint-Christophe-et-Niévès",3.8,[0.836,0.874,0.646,0.646,0.798]],["Saint-Marin",7.3,[1.606,1.679,1.241,1.241,1.533]],["Saint-Vincent-et-les Grenadines",2.9,[0.638,0.667,0.493,0.493,0.609]],["Sainte-Lucie",3.4,[0.748,0.782,0.578,0.578,0.714]],["Salvador",2,[0.44,0.46,0.34,0.34,0.42]],["Samoa",1.8,[0.396,0.414,0.306,0.306,0.378]],["São Tomé-et-Principe",1,[0.22,0.23,0.17,0.17,0.21]],["Sénégal",3.4,[0.748,0.782,0.578,0.578,0.714]],["Serbie",7.8,[1.716,1.794,1.326,1.326,1.638]],["Seychelles",9.5,[2.09,2.185,1.615,1.615,1.995]],["Sierra Leone",1.6,[0.352,0.368,0.272,0.272,0.336]],["Singapour",10,[2.2,2.3,1.7,1.7,2.1]],["Slovaquie",8.5,[1.87,1.955,1.445,1.445,1.785]],["Slovénie",10.2,[2.244,2.346,1.734,1.734,2.142]],["Somalie",1.5,[0.33,0.345,0.255,0.255,0.315]],["Soudan",2.5,[0.55,0.575,0.425,0.425,0.525]],["Soudan du Sud",2.5,[0.55,0.575,0.425,0.425,0.525]],["Sri Lanka",1.4,[0.308,0.322,0.238,0.238,0.294]],["Suède",5.5,[1.21,1.265,0.935,0.935,1.155]],["Suisse",6.2,[1.364,1.426,1.054,1.054,1.302]],["Suriname",4.7,[1.034,1.081,0.799,0.799,0.987]],["Syrie",4.2,[0.924,0.966,0.714,0.714,0.882]],["Tadjikistan",1.7,[0.374,0.391,0.289,0.289,0.357]],["Tanzanie",1.3,[0.286,0.299,0.221,0.221,0.273]],["Tchad",1.6,[0.352,0.368,0.272,0.272,0.336]],["Thaïlande",6.4,[1.408,1.472,1.088,1.088,1.344]],["Timor oriental",0.7,[0.154,0.161,0.119,0.119,0.147]],["Togo",1,[0.22,0.23,0.17,0.17,0.21]],["Tonga",1.4,[0.308,0.322,0.238,0.238,0.294]],["Trinité-et-Tobago",38.9,[8.558,8.947,6.613,6.613,8.169]],["Tunisie",3.4,[0.748,0.782,0.578,0.578,0.714]],["Turkménistan",16,[3.52,3.68,2.72,2.72,3.36]],["Turquie",6.7,[1.474,1.541,1.139,1.139,1.407]],["Tuvalu",0.5,[0.11,0.115,0.085,0.085,0.105]],["Ukraine",9,[1.98,2.07,1.53,1.53,1.89]],["Uruguay",9.9,[2.178,2.277,1.683,1.683,2.079]],["Vanuatu",1.6,[0.352,0.368,0.272,0.272,0.336]],["Vatican",7.3,[1.606,1.679,1.241,1.241,1.533]],["Venezuela",8.8,[1.936,2.024,1.496,1.496,1.848]],["Viêt Nam",3.3,[0.726,0.759,0.561,0.561,0.693]],["Yémen",1.4,[0.308,0.322,0.238,0.238,0.294]],["Zambie",1.4,[0.308,0.322,0.238,0.238,0.294]],["Zimbabwe",4.4,[0.968,1.012,0.748,0.748,0.924]]
]

if Country.count == 0
  country_list.each do |name,total,detail|
    Country.create(name: name, total: total, detail: detail)
  end
end

country_enrichment = [
  ["Afghanistan",7,3,4,7,4,5,2],["Afrique du Sud",11,40,55,104,60,78,33],["Albanie",38,16,22,41,24,31,13],["Algérie",5,22,30,57,33,43,18],["Allemagne",141,58,80,151,86,113,47],["Andorre",92,40,55,103,59,77,32],["Angola",17,7,10,19,11,14,6],["Antigua-et-Barbuda",66,28,38,72,41,54,23],["Arabie saoudite",237,99,136,256,147,192,80],["Argentine",106,44,61,115,66,86,36],["Arménie",51,22,30,56,32,42,18],["Australie",325,136,188,353,202,265,110],["Autriche",127,49,68,128,73,96,40],["Azerbaïdjan",70,29,40,76,44,57,24],["Bahamas",150,63,87,164,94,123,51],["Bahreïn",270,113,156,293,168,220,92],["Bangladesh",13,6,8,15,8,11,5],["Barbade",66,28,38,72,41,54,23],["Belgique",144,54,74,140,80,105,44],["Belize",51,22,30,56,32,42,18],["Bénin",16,7,9,17,10,13,5],["Bhoutan",50,21,29,55,31,41,17],["Biélorussie",141,59,81,153,88,115,48],["Birmanie",28,12,16,31,18,23,10],["Bolivie",144,61,84,157,90,118,49],["Bosnie-Herzégovine",95,40,55,103,59,77,32],["Botswana",63,26,36,68,39,51,21],["Brésil",69,29,40,75,43,56,23],["Brunei",425,178,245,461,264,346,144],["Bulgarie",117,45,62,117,67,88,37],["Burkina Faso",28,12,16,31,18,23,10],["Burundi",8,3,4,7,4,5,2],["Cambodge",98,41,57,107,61,80,33],["Cameroun",51,22,30,56,32,42,18],["Canada",253,106,146,275,157,206,86],["Cap-Vert",8,4,5,9,5,7,3],["Chili",82,34,47,89,51,67,28],["Chine",111,46,64,120,69,90,38],["Chypre",78,60,82,155,89,116,48],["Colombie",44,18,25,47,27,35,15],["Comores",8,4,5,9,5,7,3],["Corée du Nord",53,22,30,57,33,43,18],["Corée du Sud",160,67,92,173,99,130,54],["Costa Rica",30,13,18,33,19,25,10],["Côte d’Ivoire",17,7,10,19,11,14,6],["Croatie",91,32,44,83,47,62,26],["Cuba",55,24,33,61,35,46,19],["Curacao",529,222,306,576,330,432,180],["Danemark",115,45,62,117,67,88,37],["Djibouti",36,15,21,39,22,29,12],["Dominique",37,15,21,40,23,30,13],["Égypte",37,15,21,40,23,30,13],["Émirats arabes unis",268,112,154,291,167,218,91],["Équateur",40,16,23,43,24,32,13],["Érythrée",13,6,8,15,8,11,5],["Espagne",92,40,55,103,59,77,32],["Estonie",216,82,113,213,122,160,67],["Eswatini",33,12,17,32,18,24,10],["États-Unis",239,101,139,261,150,196,82],["Éthiopie",21,9,13,24,14,18,8],["Fidji",30,13,18,33,19,25,10],["Finlande",154,64,89,167,95,125,52],["France",91,37,51,96,55,72,30],["Gabon",87,36,50,95,54,71,30],["Gambie",21,9,12,23,13,17,7],["Géorgie",47,20,28,52,30,39,16],["Ghana",14,6,8,15,8,11,5],["Grèce",115,47,65,123,70,92,38],["Grenade",83,34,47,89,51,67,28],["Guatemala",22,10,13,25,15,19,8],["Guinée",98,41,57,107,61,80,33],["Guinée équatoriale",62,26,35,67,38,50,21],["Guinée-Bissau",50,21,29,55,31,41,17],["Guyana",96,41,56,105,60,79,33],["Haïti",9,4,6,11,6,8,3],["Honduras",28,11,16,29,17,22,9],["Hongrie",79,34,47,88,50,66,28],["Îles Cook",17,7,10,19,11,14,6],["Îles Marshall",1,1,1,1,1,1,0],["Îles Salomon",92,39,53,100,57,75,31],["Inde",28,11,16,29,17,22,9],["Indonésie",36,15,21,40,23,30,13],["Irak",50,21,29,55,31,41,17],["Iran",99,41,57,107,61,80,33],["Irlande",160,68,94,177,102,133,55],["Islande",162,68,94,176,101,132,55],["Israël",119,50,69,129,74,97,40],["Italie",98,38,52,97,56,73,30],["Jamaïque",66,27,38,71,40,53,22],["Japon",142,60,83,156,89,117,49],["Jordanie",34,14,20,37,21,28,12],["Kazakhstan",249,104,144,271,155,203,85],["Kenya",13,6,8,15,8,11,5],["Kirghizistan",28,11,16,29,17,22,9],["Kiribati",5,3,4,7,4,5,2],["Koweït",429,180,248,467,267,350,146],["Laos",30,12,17,32,18,24,10],["Lesotho",18,8,11,21,12,16,7],["Lettonie",88,31,43,81,47,61,25],["Liban",37,15,21,40,23,30,13],["Liberia",8,3,4,8,5,6,3],["Libye",158,66,91,172,99,129,54],["Liechtenstein",62,26,36,68,39,51,21],["Lituanie",128,38,52,97,56,73,30],["Luxembourg",260,103,142,267,153,200,83],["Macédoine du Nord",76,32,44,83,47,62,26],["Madagascar",57,24,33,61,35,46,19],["Malaisie",108,45,62,117,67,88,37],["Malawi",15,6,9,16,9,12,5],["Maldives",9,4,6,11,6,8,3],["Mali",51,22,30,56,32,42,18],["Malte",84,28,39,73,42,55,23],["Maroc",28,12,16,31,18,23,10],["Maurice",17,7,10,19,11,14,6],["Mauritanie",37,15,21,40,23,30,13],["Mexique",63,26,36,68,39,51,21],["Micronésie",7,3,4,8,5,6,3],["Moldavie",40,16,23,43,24,32,13],["Monaco",91,37,51,96,55,72,30],["Mongolie",99,42,57,108,62,81,34],["Monténégro",96,40,55,104,60,78,33],["Mozambique",10,4,6,11,6,8,3],["Namibie",51,22,30,56,32,42,18],["Nauru",1,1,1,1,1,1,0],["Népal",17,7,10,19,11,14,6],["Nicaragua",32,13,18,35,20,26,11],["Niger",7,3,4,7,4,5,2],["Nigeria",20,8,11,21,12,16,7],["Niue",17,7,10,19,11,14,6],["Norvège",148,53,73,137,79,103,43],["Nouvelle-Zélande",200,84,115,217,125,163,68],["Oman",165,69,95,179,102,134,56],["Ouganda",24,10,13,25,15,19,8],["Ouzbékistan",67,28,39,73,42,55,23],["Pakistan",22,10,13,25,15,19,8],["Palaos",20,9,12,23,13,17,7],["Palestine",119,50,69,129,74,97,40],["Panamá",49,21,28,53,31,40,17],["Papouasie-Nouvelle-Guinée",16,7,9,17,10,13,5],["Paraguay",91,39,53,100,57,75,31],["Pays-Bas",140,62,85,160,92,120,50],["Pérou",29,12,16,31,18,23,10],["Philippines",20,8,11,21,12,16,7],["Pologne",135,57,78,147,84,110,46],["Portugal",86,36,50,93,53,70,29],["Qatar",479,201,277,521,299,391,163],["République centrafricaine",3,2,2,4,2,3,1],["République démocratique du Congo",6,3,4,7,4,5,2],["République dominicaine",38,16,22,41,24,31,13],["République du Congo",37,15,21,40,23,30,13],["République tchèque",161,63,87,164,94,123,51],["Roumanie",76,32,44,83,47,62,26],["Royaume-Uni",109,40,55,103,59,77,32],["Russie",237,100,137,259,148,194,81],["Rwanda",7,3,4,8,5,6,3],["Saint-Christophe-et-Niévès",44,20,27,51,29,38,16],["Saint-Marin",98,38,52,97,56,73,30],["Saint-Vincent-et-les Grenadines",36,15,21,39,22,29,12],["Sainte-Lucie",41,17,24,45,26,34,14],["Salvador",24,10,14,27,15,20,8],["Samoa",22,9,13,24,14,18,8],["São Tomé-et-Principe",12,5,7,13,8,10,4],["Sénégal",42,17,24,45,26,34,14],["Serbie",96,40,55,104,60,78,33],["Seychelles",116,49,67,127,73,95,40],["Sierra Leone",20,8,11,21,12,16,7],["Singapour",123,51,71,133,76,100,42],["Slovaquie",104,44,60,113,65,85,35],["Slovénie",125,52,72,136,78,102,43],["Somalie",18,8,11,20,11,15,6],["Soudan",30,13,18,33,19,25,10],["Soudan du Sud",30,13,18,33,19,25,10],["Sri Lanka",17,7,10,19,11,14,6],["Suède",80,28,39,73,42,55,23],["Suisse",79,32,44,83,47,62,26],["Suriname",58,24,33,63,36,47,20],["Syrie",51,22,30,56,32,42,18],["Tadjikistan",21,9,12,23,13,17,7],["Tanzanie",16,7,9,17,10,13,5],["Tchad",21,8,11,21,12,16,7],["Thaïlande",78,33,45,85,49,64,27],["Timor oriental",9,4,5,9,5,7,3],["Togo",12,5,7,13,8,10,4],["Tonga",17,7,10,19,11,14,6],["Trinité-et-Tobago",478,200,276,519,297,389,162],["Tunisie",42,17,24,45,26,34,14],["Turkménistan",197,82,113,213,122,160,67],["Turquie",67,34,47,89,51,67,28],["Tuvalu",5,3,4,7,4,5,2],["Ukraine",111,46,64,120,69,90,38],["Uruguay",121,51,70,132,76,99,41],["Vanuatu",20,8,11,21,12,16,7],["Vatican",98,38,52,97,56,73,30],["Venezuela",108,45,62,117,67,88,37],["Viêt Nam",40,17,23,44,25,33,14],["Yémen",17,7,10,19,11,14,6],["Zambie",17,7,10,19,11,14,6],["Zimbabwe",54,23,31,59,34,44,18]
]

country_enrichment.each do |name,house_size,furniture,clothes,other_goods,healthcare,subscriptions,other_services|
  c = Country.find_by_name(name)
  c.update(house_size: house_size, furniture: furniture,clothes: clothes,other_goods: other_goods,healthcare: healthcare,subscriptions: subscriptions,other_services: other_services)
end

# WARNING category format deprecated, seed format and content need to be updated for seeding a new environment (see script for details)
category_list = [
  [ "Auto & Transports", 165, 0.550308125, 0 ],
  [ "Assurance véhicule", 247, 0.023, 165 ],
  [ "Billets d'avion", 198, 1.12152, 165 ],
  [ "Billets de train", 197, 0.33563, 165 ],
  [ "Carburant", 87, 1.186, 165 ],
  [ "Entretien véhicule", 288, 0.063295, 165 ],
  [ "Location de véhicule", 264, 1.186, 165 ],
  [ "Péage", 309, 0.19571, 165 ],
  [ "Stationnement", 251, 0.19571, 165 ],
  [ "Transports en commun", 196, 0.1186, 165 ],
  [ "Auto & Transports Autres", 84, 0.023, 165 ],
  [ "Logement", 161, 0.5242457823, 0 ],
  [ "Assurance habitation", 246, nil, 161 ],
  [ "Charges diverses", 328, 0.03623, 161 ],
  [ "Décoration", 221, 0.06949, 161 ],
  [ "Eau", 293, 0.01537, 161 ],
  [ "Electricité", 217, 0.4761904762, 161 ],
  [ "Entretien", 222, 0.03615, 161 ],
  [ "Extérieur et jardin", 323, 0.03629, 161 ],
  [ "Gaz", 218, 3, 161 ],
  [ "Loyer", 216, nil, 161 ],
  [ "Logement étudiant", 241, 0, 161 ],
  [ "Logement Autres", 220, nil, 161 ],
  [ "Abonnements", 171, 0.006012888889, 162 ],
  [ "Achats de biens et services", 162, 0.008664444444, 0 ],
  [ "Banque", 164, 0.01690333333, 162 ],
  [ "Divers", 160, 0.004496666667, 162 ],
  [ "Internet", 180, 0, 171 ],
  [ "Téléphonie fixe", 258, 0, 171 ],
  [ "Téléphonie mobile", 277, 0, 171 ],
  [ "Abonnements Autres", 280, 0, 171 ],
  [ "Câble / Satellite", 219, 0, 171 ],
  [ "Livres", 243, 0.02698, 162 ],
  [ "Vêtements/Chaussures", 272, 0.0296, 162 ],
  [ "High Tech", 184, 0.03566, 162 ],
  [ "Articles de sport", 262, 0.04293, 162 ],
  [ "Tabac", 308, 0.04627, 162 ],
  [ "Esthétique & Soins", 315, 0.023, 162 ],
  [ "Coiffeur", 235, 0.023, 315 ],
  [ "Cosmétique", 248, 0.023, 315 ],
  [ "Esthétique", 321, 0.023, 315 ],
  [ "Esthétique & Soins Autres", 317, 0.023, 315 ],
  [ "Spa & Massage", 316, 0.023, 315 ],
  [ "Frais Animaux", 224, 0.06334, 315 ],
  [ "Divertissements", 269, 0.02738, 162 ],
  [ "Hôtels", 263, 0.43479, 162 ],
  [ "Hobbies", 226, nil, 162 ],
  [ "Sorties culturelles", 244, 0.02738, 162 ],
  [ "Sport", 242, nil, 162 ],
  [ "Sports d'hiver", 310, nil, 162 ],
  [ "Voyages / Vacances", 249, nil, 162 ],
  [ "Remboursement emprunt", 89, nil, 164 ],
  [ "Prêt étudiant", 259, 0, 164 ],
  [ "Frais bancaires", 79, nil, 164 ],
  [ "Services Bancaires", 306, nil, 164 ],
  [ "Assurance", 278, 0.039015625, 164 ],
  [ "Banque Autres", 195, 0, 164 ],
  [ "Débit mensuel carte", 191, nil, 164 ],
  [ "Epargne", 192, nil, 164 ],
  [ "Hypothèque", 194, nil, 164 ],
  [ "Achats & Shopping Autres", 186, 0.04293, 162 ],
  [ "Cadeaux", 183, nil, 162 ],
  [ "Films & DVDs", 319, nil, 162 ],
  [ "Licenses", 441888, nil, 162 ],
  [ "Musique", 318, nil, 162 ],
  [ "Pressing", 324, 0.039015625, 162 ],
  [ "Loisirs & Sorties Autres", 223, 0.10314, 162 ],
  [ "Fournitures scolaires", 238, 0, 162 ],
  [ "Jouets", 266, 0, 162 ],
  [ "Alimentation & Restau.", 168, 0.070256, 0 ],
  [ "Café", 313, 0.06334, 168 ],
  [ "Fast foods", 260, 0.07964, 168 ],
  [ "Restaurants", 83, 0.07964, 168 ],
  [ "Sortie au restaurant", 320, 0.07964, 168 ],
  [ "Supermarché / Epicerie", 273, 0.04902, 168 ],
  [ "Bars / Clubs", 227, 0.08105, 168 ],
  [ "Alimentation Autres", 188, 0.06334, 168 ],
  [ "Impôts & Taxes", 159, 0.039015625, 0 ],
  [ "Santé", 163, 0.0425625, 159 ],
  [ "Amendes", 207, 0, 159 ],
  [ "Impôts fonciers", 209, nil, 159 ],
  [ "Impôts sur le revenu", 208, nil, 159 ],
  [ "Dentiste", 325, 0.05675, 163 ],
  [ "Médecin", 261, 0.05675, 163 ],
  [ "Opticien / Ophtalmo.", 322, 0.05675, 163 ],
  [ "Pharmacie", 236, 0.04387, 163 ],
  [ "Mutuelle", 245, 0, 163 ],
  [ "Baby-sitters & Crèches", 267, 0, 159 ],
  [ "Ecole", 239, 0, 159 ],
  [ "Impôts & Taxes Autres", 206, nil, 159 ],
  [ "Taxes", 302, nil, 159 ],
  [ "TVA", 441988, nil, 159 ],
  [ "Santé Autres", 268, 0, 163 ],
  [ "Scolarité & Enfants Autres", 237, 0, 159 ],
  [ "Dépenses pro", 166, nil, 0 ],
  [ "Comptabilité", 441889, nil, 166 ],
  [ "Conseils", 441895, nil, 166 ],
  [ "Cotisations Sociales", 441886, nil, 166 ],
  [ "Dépenses pro Autres", 90, nil, 166 ],
  [ "Fournitures de bureau", 274, nil, 166 ],
  [ "Frais d'expéditions", 204, nil, 166 ],
  [ "Frais d'impressions", 205, nil, 166 ],
  [ "Frais de recrutement", 441892, nil, 166 ],
  [ "Frais juridique", 441899, nil, 166 ],
  [ "Maintenance bureaux", 203, nil, 166 ],
  [ "Marketing", 441900, nil, 166 ],
  [ "Notes de frais", 265, nil, 166 ],
  [ "Prévoyance", 441897, nil, 166 ],
  [ "Publicité", 202, nil, 166 ],
  [ "Rémunérations dirigeants", 441891, nil, 166 ],
  [ "Salaires", 441890, nil, 166 ],
  [ "Services en ligne", 270, nil, 166 ],
  [ "Sous-traitance", 441896, nil, 166 ],
  [ "Taxe d'apprentissage", 441898, nil, 166 ],
  [ "A catégoriser", 1, 0, 0 ],
  [ "Autres dépenses", 276, 0.039015625, 1 ],
  [ "Dons", 294, 0.039015625, 1 ],
  [ "Pensions", 240, 0, 1 ],
  [ "Loisirs & Sorties", 170, 0, 162 ],
  [ "Entrées d'argent", 2, 0, 0 ],
  [ "Allocations et pensions", 327, 0, 2 ],
  [ "Autres rentrées", 3, 0, 2 ],
  [ "Dépôt d'argent", 271, 0, 2 ],
  [ "Economies", 289, 0, 2 ],
  [ "Emprunt", 441894, 0, 2 ],
  [ "Extra", 233, 0, 2 ],
  [ "Intérêts", 80, 0, 2 ],
  [ "Loyers reçus", 314, 0, 2 ],
  [ "Remboursements", 283, 0, 2 ],
  [ "Retraite", 279, 0, 2 ],
  [ "Salaires", 230, 0, 2 ],
  [ "Services", 232, 0, 2 ],
  [ "Subventions", 441893, 0, 2 ],
  [ "Ventes", 231, 0, 2 ],
  [ "Virements internes", 282, 0, 2 ],
  [ "Retraits, Chq. et Vir.", 303, 0, 0 ],
  [ "Chèques", 88, 0, 303 ],
  [ "Retraits", 85, 0, 303 ],
  [ "Virements", 78, 0, 303 ],
  [ "Virements internes", 326, 0, 303 ],
  [ "Scolarité & Enfants", 167, 0, 159 ]
]

if Category.count == 0
  category_list.each do |name,external_id,coeff,parent_id|
    Category.create(name: name, external_id: external_id, coeff: coeff, parent_id: parent_id)
  end
end

bridges = Bridge.where("bank_connected = true")
bridges.each do |bridge|
  user = User.find(bridge.user_id)
  if user.scores == [] &&
    if user.transactions.present?
      Score.create(user_id: bridge.user_id, kind: :dynamic, country_id: 63)
    else
      Score.create(user_id: bridge.user_id, kind: :static, country_id: 63)
    end
  end
end

equivalent_list = [
  ["petits voiliers", "⛵", 0, 150],
  ["vaches limousines", "🐮", 0, 750],
  ["crocodiles adultes", "🐊", 0, 400],
  ["jeans délavés", "👖", 1, 15],
  ["zèbres", "🦓", 0, 300],
  ["baguettes", "🥖", 1, 0.38],
  ["écrans plats", "🖥", 1, 568],
  ["bains chauds", "🛀", 3, 0.7],
  ["canapés convertibles", "🛋", 1, 204],
  ["trotinette électrique", "🛴", 2, 0.202],
  ["croissants", "🥐", 1, 0.143],
  ["porcelets", "🐖", 0, 1.5],
  ["appareils photo numériques", "📷", 1, 128],
  ["hélicoptère", "🚁", 2, 45]
]

if Equivalent.count == 0
  equivalent_list.each do |name,emoji,kind,carbone_min|
    Equivalent.create(name: name, emoji: emoji, kind: kind, carbone_min: carbone_min)
  end
end

modifier_list = [
  [['Bio',0,1],[["Produits Bio", -0.05]],[40,70]],
  [['Livraison à domicile',0,0],[["Livraison à domicile", 0.05]],[70]],
  [['Type de nourriture',1,1],[["Vegan", -0.463],["Végétarien", -0.3955],["Carné", 0.5093]],[72,73,75]],
  [['Type de commerce',1,0],[["Boucherie", 3.6],["Poissonnerie", 0.8],["Maraicher", -0.92],["Vin & alcools", -0.4],["Charcuterie", 1.06],["Boulangerie", -0.55],["Fromager", 0.45]],[75,77]],
  [["Type d'énergie",1,1],[["Gaz", 0.19],["Gaz & Electricité", 0],["Electricité", -0.81]],[17]],
  [["Part de renouvelable",1,1],[["Aucune énergie renouvelable", 0],["Partiellement renouvelable", -0.40],["100% renouvelable", -0.70]],[17]],
  [['Occasion',0,0],[["Produit acheté d'occasion", -1]],[15,33,34,35,36,61,62,63]],
  [["Provenance",1,0],[["Produit local", -0.10],["Produit importé", 0.03]],[15,25,70]],
  [["Type de carburant",1,1],[["Diesel", -0.1],["Essence", 0]],[5]],
  [["Type de train",1,0],[["TGV", -0.83],["TER", 1.35],["Transilien & RER", -0.6],["Eurostar & Thalys", 0.07]],[4]],
  [["Type de véhicule",1,0],[["Classique", 0],["Hybride", -0.25],["Electrique", -0.87]],[7, 145, 146]]
]

if Modifier.count == 0
  modifier_list.each do |modifier, modifier_options, categories|
    repeating = true if modifier[2] == 1
    mod = Modifier.create(name: modifier[0], question_type: modifier[1], repeating: repeating)
    modifier_options.each do |name, coeff|
      mod.modifier_options.create(name: name, coeff: coeff)
    end
    categories.each do |cat|
      mod.categories << Category.find(cat)
    end
    mod.save
  end
end

badge_list = [
  ["Maitrise la méthodologie Carbo", "badge_1.png", 0],
  ["Précise ton mode de vie", "badge_2.png", 1],
  ["Compense ton empreinte carbone", "badge_3.png", 2],
  ["Invite un proche pour te comparer", "badge_4.png", 3],
  ["Fais une 1ère estimation de ton impact", "badge_1.png", 0]
]

if Badge.count == 0
  badge_list.each do |name, image, family|
    Badge.create(name: name, image: image, family: family)
  end
end

new_badge_list = [
  ["Découvre ton impact carbone", "badge_1.png", 0, "Un kilogramme de CO2, ça ne parle pas à tout le monde ! Pourquoi parle t-on d’équivalent, quelle différence avec les autres gaz à effet de serre : prends 2 minutes ici pour bien comprendre ce que représente ton empreinte carbone.", ""],
  ["Découvre un projet de compensation", "badge_2.png",  0, "La compensation est une première étape qui vise à assumer la responsabilité de ses choix quotidiens, Connais-tu les différents projets Carbo qui permettent de compenser ton empreinte carbone ? C’est par ici !", "https://www.hellocarbo.com/compenser-mon-empreinte-carbone/"],
  ["Teste tes connnaissances carbone", "badge_4.png", 0, "Comprendre en s’amusant, quoi de mieux ? Prends 5 min pour mieux maîtriser les fondamentaux du réchauffement climatique avec le Quizz Carbo ! Seras-tu capable de répondre correctement et maintenir la température de la Terre ?", ""],
  ["Connecte un compte bancaire", "badge_5.png", 1, "La méthodologie Carbo permet de suivre automatiquement et sans effort ton empreinte carbone. Autorise Carbo à se connecter en toute sécurité à une ou plusieurs banques que tu utilises au quotidien, c’est 100% gratuit !", "/bridges/new"],
  ["Catégorise tes dépenses", "badge_8.png", 1, "Pour gagner en précision carbone, certaines dépenses requièrent une modification manuelle, par exemple en adaptant la catégorie associée. Tu peux propager cette action aux autres dépenses similaires. Et hop, un badge !", "/categorize"],
  ["Suggére une précision", "badge_6.png", 1, "Avec ta contribution, on peut bâtir de grandes choses ! À commencer par un meilleur algorithme. Si une évolution te semble utile (nouvelle catégorie, fonctionnalité, etc.), fais le nous savoir ici et remporte un badge !", "/transactions"],
  ["Remporte un match Carbo", "badge_10.png", 2, "La comparaison sociale, rien de tel pour se bouger le cocotier ! Carbo te permet de comparer ton impact carbone avec celui d’autres profils. As-tu les épaules pour remporter ton premier match, et le badge qui va avec ?", "/matches"],
  ["Réduire ton impact de XX kg CO2", "badge_9.png", 2, "Réduire ton empreinte carbone, c’est probablement aujourd’hui l’action la plus utile pour contenir le réchauffement climatique et préserver la planète. Pour remporter ce badge, suis tes recommandations Carbo !", "/reduce"],
  ["Respecte l’accord de Paris", "badge_12.png", 2, "Pour faire simple, cet accord fixe pour chaque individu un plafond maximum annuel à ne pas dépasser pour maintenir la température de la Terre dans des proportions raisonnables. Es tu capable de décrocher ce Graal ? ", "/reduce"],
  ["Partage ton Profil Carbone", "badge_19.png", 3, "Si tu as appris quelque chose avec Carbo, il y a de fortes chances que tu souhaites en faire bénéficier tes proches ? Ça tombe bien, voici une page publique dédiée à ton profil, prêt à partager ! Clique ici et gagne un badge :)", ""],
  ["Partage ton Carbomètre", "badge_20.png", 3, "Le Carbomètre est un moyen simple et ludique de se repérer dans la jungle du carbone. De quoi sensibiliser facilement le plus grand nombre ! Remporte un badge en partageant ton Carbomètre en un clic ici >", ""],
  ["Offre Carbo à un proche", "badge_18.png", 3, "Faire plaisir en agissant pour la planète, c’est possible ! Offre un abonnement Carbo à un proche, de la durée de ton choix, pour lui permettre de soutenir nos projets certifiés et de démarrer une vie neutre en carbone.", "https://www.hellocarbo.com/offrir-cadeau-ecolo/"],
  ["Ajoute une photo à ton profil", "badge_13.png", 4, "Tout est dit. Cela permet à ton application d’être plus agréable à utiliser, pour toi mais aussi pour toute la communauté ! Mais ça te permettra surtout de partager facilement à tes proches certains visuels, comme le Carbomètre.", ""],
  ["Installe Carbo sur ton smartphone", "badge_14.png", 4, "Carbo est une application web disponible sur tous tes appareils. Il existe un moyen simple de l’ajouter à l’écran d’accueil de ton téléphone, comme n’importe quelle appli de l’App Store ou Google Play. Mieux, ça prend 15 secondes !", "https://www.hellocarbo.com/questions/problemes-app-web/?#q1"],
  ["Activer les notifications Carbo", "badge_15.png", 4, "Sois prévenu.e lorsqu’un événement clef apparaît sur ton profil carbone ou dans la communauté Carbo. Un moyen simple de gagner un badge ! Pas d'inquiétude, ces notifications se limiteront toujours à l’essentiel :)", ""],
  ["Mettre à jour tes ID bancaires", "badge_16.png", 4, "Par mesure de sécurité, la plupart des banques requiert de changer régulièrement le mot de passe associé à ton compte. Quand cela arrive, modifie simplement tes identifiants ici pour ne pas perdre le fil de ton impact carbone !", "/users/edit"],
  ["Suis Carbo sur Facebook", "badge_23.png", 5, "Tu aimes ce qu’on fait et tu aimerais nous soutenir un peu ? Commence par nous suivre sur les réseaux sociaux, c’est un moyen efficace de faire connaître Carbo à ton entourage...et de remporter un badge facile ;)", "https://www.facebook.com/hellocarbo/"],
  ["Recommande Carbo sur TrustPilot", "badge_21.png", 5, "Carbo utilise cette plateforme pour consolider les avis vérifiés de la communauté. Recommander Carbo, c’est un moyen efficace de renforcer notre crédibilité pour, à terme, sensibiliser le plus grand nombre. On compte sur toi !", "https://fr.trustpilot.com/evaluate/hellocarbo.com?utm_medium=trustbox&utm_source=TrustBoxReviewCollector"],
  ["Vote pour tes fonctionnalités", "badge_24.png", 5, "Chez Carbo, on a fait le choix d’être 100% transparent sur notre démarche, en rendant notamment public notre plan de développement. Tu peux même voter pour soutenir et prioriser certaines fonctionnalités ! C’est par ici >", "https://trello.com/b/ikSl3Q07/carbo-suivi-du-d%C3%A9veloppement"],
  ["Connecte toi à Carbo au moins 5 fois", "badge_22.png", 5, "Tes petites actions quotidiennes peuvent, à long terme, contribuer efficacement à la préservation de notre bonne vieille planète. Mais s’engager à long-terme, ça reste le plus difficile, et Carbo est aussi là pour ça !", ""]
]

if Badge.count == 5
  new_badge_list.each do |name, image, family, short_desc, url|
    Badge.create(name: name, image: image, family: family, short_desc: short_desc, url: url)
  end
end

users = User.where("onboarded IS TRUE")
users.each do |user|
  if user.badges.count == 0
    score = user.scores.last
    if score.regime.present?
      unless user.badges.include?(Badge.find(5))
        user.badges <<  Badge.find(5)
      end
    end
    if score.dairy.present?
      unless user.badges.include?(Badge.find(2))
        user.badges <<  Badge.find(2)
      end
    end
    if user.subscribed == true
      unless user.badges.include?(Badge.find(3))
        user.badges <<  Badge.find(3)
      end
    end
    if User.where("invited_by_id = ?", user.id).present?
      unless user.badges.include?(Badge.find(4))
        user.badges <<  Badge.find(4)
      end
    end
    if score.kind.to_sym == :dynamic
      unless user.badges.include?(Badge.find(9))
        user.badges <<  Badge.find(9)
      end
    end
  end
end

transaction_enrichments_list = [
  ['CB Uber Paris',145,nil,nil],
  ['CB Uber',145,nil,nil],
  ['CB Naturalia',75,12,36],
  ['CB Lim*ride Cost',147,nil,nil],
  ['CB Cityscoot',147,nil,nil],
  ['CB Txfy.me Paris',145,nil,nil],
  ['CB Carrefour Bio',75,12,36],
  ['CB Naturalia Paris',75,12,36],
  ['CB Paris Feni',73,14,39],
  ['CB Velib Metropole',147,nil,nil],
  ['Lunchr',73,nil,nil],
  ['Kapten',145,nil,nil],
  ['CB Bio C Bon',75,12,36],
  ['CB Biocoop',75,12,36],
  ['CB Lime Sarl Paris',147,nil,nil],
  ['CB Lunchr',73,nil,nil],
  ['CB Mgp*vinted',34,18,54],
  ['CB Velib Metropole Paris',147,nil,nil],
  ['CB Uber *trip',145,nil,nil],
  ['CB Uber Trip Help.ub',145,nil,nil],
  ['CB Blablacar',146,nil,nil],
  ['CB Gb Eurostar Inter',4,21,62],
  ['CB Kapten Levallois Per',145,nil,nil],
  ['CB Ubereats',72,nil,nil],
  ['CB Transport Marce Paris',145,22,65],
  ['CB Txfy.me',145,nil,nil],
  ['CB Lim*ride Cost Paris',147,nil,nil],
  ["CB Autolib'",7,22,65]
]

if TransactionEnrichment.auto.count < 3
  transaction_enrichments_list.each do |desc,category,modifier,modifier_option|
    t = TransactionEnrichment.create(description: desc, category_id: category, modifier_id: modifier, modifier_option_id: modifier_option)
  end
end
