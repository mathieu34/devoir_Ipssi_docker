📘 TP Dockerfile 

- Un serveur web apache
- Plusieurs services tournent en meme temps 
- bd fonctionnelle avec WordPress et PhpMyAdmin
- Utilisateur créée qui interagit avec la BD. 
- index automatique désactivable

Les commandes : 
- docker build --no-cache -t wordpress-ipssi .
- docker run -p 8080:80 wordpress-ipssi
- docker run -p 8080:80 -e AUTOINDEX=off wordpress-ipssi
- docker run -p 80:80 -p 443:443 wordpress-ipssi

Ajout du service nginx : 
- accessibilite du service wordpress via le container (exec commande) mais pas via l'Endpoint https://127.0.0.1/wordpress 


