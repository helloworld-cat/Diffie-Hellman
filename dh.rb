#encoding: utf-8


#Permet un calcul rapide de: g^a mod p
def mod_exp(a,e,m)
  result = 1
  while e > 0
    result = (result * a) % m if e[0] == 1
    e = e >> 1
    a = (a * a) % m
  end
  return result
end

#VALEURS INITIALES

#g et p sont des nombres connus des agents (Alice, Bob). Ils peuvent être selectionnés arbitraitement par Alice lors de l'initialisation de la communication puis diffusés en clair
p=23 # p doit être un nb premier. Utiliser un nombre > à 1024bits (>309 chiffres)
g=3 # nb de base: groupe. Utiliser un nombre aléatoire tel que g < p

#PRINCIPE:

# Alice et Bob ont en commun un nombre premier p et une base g.
# Alice choisit un nombre secret a=6
a = 6 # Utiliser de préférence un nombre de 100 chiffres mininum.
# Elle envoie à Bob la valeur g^a [mod p] = 36 [23] = 16
#A = g**a % p # A = 3**6 % 23
A = mod_exp(g,a,p)
puts "Alice envoie à Bob: g=#{g}, p=#{p}, A=#{A}"

# Bob choisit à son tour un nombre secret b=15
b = 15 # Utiliser de préférence un nombre de 100 chiffres mininum.
# Bob envoie à Alice la valeur g^b [mod p] = 315 [23] = 12
#B = g**b % p # B = 3**15 % 23
B = mod_exp(g,b,p)
#send("Alice",B)
puts "Bob envoie à Alice: B=#{B}"

# Alice peut maintenant calculer la clé secrète commune K => (g^b [mod p])^a [mod p] = 126 [23] = 9
#kAlice = B**a % p
kAlice = mod_exp(B,a,p)
puts "kAlice = #{kAlice}"
# Bob fait de même et obtient la même clé, K, que Alice : (g^a [mod p])^b [mod p] = 1615 [23] = 9
#kBob = A**b % p
kBob = mod_exp(A,b,p)
puts "kBob   = #{kBob}"

