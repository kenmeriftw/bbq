# BBQ-EVENTER

Thank you for visiting this repository!

You can find here an Ruby on Rails web application for eventers - people who are fond of organizing events and inviting 
their friends. Create an account using standard email+password combination or just link your social networks (now there 
are Facebook and VK integration available), 

![alt text](https://media.giphy.com/media/NJbAyhkzSd5dvwwTMP/giphy.gif)

create your own events or subscribe on your friend's one, leave a comments or pin the photos of fun you've had recently,
get the e-mail notification about all the interesting updates about events you subscribed on.

![alt text](https://media.giphy.com/media/tDoZIuJ3MIEKmXvsns/giphy.gif)

Application is deployed on [VPS](https://bbq-eventer.site/) now, I will be glad if you visit it.

- Deployed on `DigitalOcean` VPS (`Ubuntu 20.04` + `nginx` + `Phusion Passenger`) via `Capistrano` gem
- `PostgreSQL` database for local data storage
- Userpics and photos storage organized on `Amazon S3 AWS` via `carrierwave` and `rmagic` gems
- `Mailjet` service for e-mail sendind in background jobs using `Resque` + `Redis`
- In-app authorization via `pundit` gem
- `OAuth2`-standarted authorization via `Facebook` and `VK` social networks accounts
- Localized via `I18n` gem
- Bootstraped via `bootstrap-5.0.0`

If you are going to run this application locally on your machine clone this repo using
```
git clone git@github.com:knmrftw/bbq.git
```
and make `cd` into new directory.
You have to install `ruby-2.7.2` or just skip this step if you have it installed previously on your machine.
Run
```
bundle
```
to install all required gems and dependencies.

Application requires `credentials` keys for services connected to this project. Add keys to your `rails credentials`:
```
aws:
  access_key_id:
  secret_access_key:
  bucket_name:
database:
  password:
mailjet:
  api_key:
  secret_key:
  sender:
omniauth:
  facebook_id:
  facebook_secret: 
  vkontakte_id: 
  vkontakte_secret:
```
