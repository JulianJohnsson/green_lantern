# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
user = CreateAdminService.new.call
puts 'CREATED ADMIN USER: ' << user.email

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

category_list.each do |name,external_id,coeff,parent_id|
  Category.create(name: name, external_id: external_id, coeff: coeff, parent_id: parent_id)
end
