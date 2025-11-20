# Podman Nginx Alpine for WordPress

Sebelumnya harus install Podman dulu. Pake Podman Compose lebih enak.

- Kloning <https://github.com/areknjomplang/podman-nginx-alpine-wordpress.git>.
- Buat sertifikat SSL dengan mkcert (untuk development lokal).
- Jalankan `podman compose up -d`
- Buka <http://localhost:8080> di browser.
- Login ke WordPress di <http://localhost:8080/wp-login.php>
