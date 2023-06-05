pidfile = "/var/run/prosody/prosody.pid";

---администраторы сервера---
admins = { "poly.wave@callmeplease.ru" }

---Отключаем регистрацию через клиенты---
allow_registration = true


---Хранить всё в БД---
default_storage = "sql"
sql = {
    driver = "PostgreSQL";
    database = "prosody";
    host = "postgres";
    port = 5432;
    username = "prosody";
    password = "prosody";
}


sql_manage_tables = true



---Сертификаты---
certificates = "/etc/prosody/certs"

---http
http_host = "0.0.0.0"
http_ports = { 5280 }
https_ports = { }
http_interfaces = { "0.0.0.0" }
trusted_proxies = { "0.0.0.0" }

---Методы шифрования---
ssl = {
    key = "/etc/prosody/certs/callmeplease.ru.key";
    certificate = "/etc/prosody/certs/callmeplease.ru.crt";
    options = { "no_sslv3", "no_sslv2", "no_ticket", "no_compression", "cipher_server_preference", "single_dh_use", "single_ecdh_use" };
    ciphers="EECDH+ECDSA+AESGCM:EECDH+aRSA+AESGCM:EECDH+ECDSA+SHA384:EECDH+ECDSA+SHA256:EECDH+aRSA+SHA384:EECDH+aRSA+SHA256:EECDH+aRSA+RC4:EECDH:EDH+aRSA:!aNULL:!eNULL:!LOW:!3DES:!MD5:!EXP:!PSK:!SRP:!DSS:!RC4:AES256-GCM-SHA384";
    protocol = "tlsv1_1+";
    dhparam = "/etc/prosody/certs/dh-2048.pem";
}

---Обязательное шифрование Клиент сервер и Сервер и сервер
c2s_require_encryption = true;
s2s_require_encryption = true;
s2s_secure_auth = true;

---Модули---
plugin_paths = { "/opt/prosody-modules/" }

---Глобальные модули---
modules_enabled = {
    "roster";
    "saslauth";
    "tls";
    "dialback";
    "disco";

    "private";
    --"profile";
    "offline";
    "admin_adhoc";
    "admin_telnet";
    "legacyauth";
    "version";
    "uptime";
    "time";
    "ping";
    "register";
    "posix";
    "bosh";
    "announce";
    "pep";
    "smacks";
    "carbons";
    "blocklist";
    "csi";
    "csi_battery_saver";
    "mam";
    "lastlog";
    "list_inactive";
    "cloud_notify";
    "compat_dialback";
    "throttle_presence";
    "log_auth";
    "server_contact_info";
    "websocket";
    "bookmarks";
    "privacy_lists";
    "filter_chatstates";
    "vcard_legacy";
    "pinger";
    "http_upload_external";
    "register_web";
    "http_altconnect";
    "conversejs";
    "turn_external";
};


---Настройка архива сообщений, можно выставить в днях, или отключить вовсе---
default_archive_policy = true;
archive_expires_after = "1d";

---EXTERNAL HTTP UPLOAD---
http_upload_external_base_url = "https://callmeplease.ru/upload/"
http_upload_external_secret = "prosody"
http_upload_external_file_size_limit = 536870912 --4Gb

---шаблон для веб регистрации---
register_web_template = "/etc/prosody/register-templates/Prosody-Web-Registration-Theme"

---Websocket---
consider_websocket_secure = true;
cross_domain_websocket = true;

---настройки веб клиента---
conversejs_options = {
    debug = false;
    view_mode = "fullscreen";
}
conversejs_tags = {
    -- Load libsignal-protocol.js for OMEMO support (GPLv3; be aware of licence implications)
    [[<script src="https://cdn.conversejs.org/3rdparty/libsignal-protocol.min.js"></script>]];
}

cross_domain_bosh = true;
consider_bosh_secure = true;

https_ssl = {
    key = "/etc/prosody/certs/callmeplease.ru.key";
    certificate = "/etc/prosody/certs/callmeplease.ru.crt";
}

---TURN STUN для звонков---
turn_external_host = "194.58.119.39"
turn_external_port = 3478
turn_external_secret = "prosody"

c2s_direct_tls_ports = { 5223 }
c2s_direct_tls_ssl = {
    certificate = "/etc/prosody/certs/callmeplease.ru.crt";
    key = "/etc/prosody/certs/callmeplease.ru.key";
}


VirtualHost "callmeplease.ru"
http_host = "callmeplease.ru"
http_external_url = "https://callmeplease.ru/"

authentication = "internal_hashed"

Component "callmeplease.ru/conference" "muc"
    restrict_room_creation = "admin"

    muc_room_default_public = false
    muc_room_default_members_only = true
    muc_room_default_language = "ru"
    max_history_messages = 5000
    modules_enabled = {
        "muc_mam",
        "vcard_muc",
        "muc_cloud_notify";
    }
    muc_log_by_default = true
    disco_items = {
        { "conference", "MUC" };
    }

Component "callmeplease.ru/pubsub" "pubsub"
Component "callmeplease.ru/proxy" "proxy65"
proxy65_acl = { "callmeplease.ru" }
