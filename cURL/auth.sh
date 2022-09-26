#авторизация и получение файла cookie
#олгин - export SEASON_LOGIN="************"
#пароль - export SEASON_PASSWORD="************"
curl -s \
--cookie-jar cookies.txt \
--data "login_name=$SEASON_LOGIN&login_password=$SEASON_PASSWORD&login=submit" \
https://seasonvar.one/user/ >> /dev/null

#подключение с использованием файла cookie
curl -s \
--cookie cookies.txt \
https://seasonvar.one/ | grep -i "Мой профиль"