📘 TP Dockerfile 

- Un serveur web apache
- Plusieurs services tournent en meme temps 
- bd fonctionnelle avec WordPress et PhpMyAdmin
- index automatique désactivable
- Utilisateur créée qui interagit avec la BD. 
- index automatique désactivable

Les commandes : 
- docker build --no-cache -t wordpress-ipssi .
- docker run -p 8080:80 wordpress-ipssi
- docker run -p 8080:80 -e AUTOINDEX=off wordpress-ipssi

