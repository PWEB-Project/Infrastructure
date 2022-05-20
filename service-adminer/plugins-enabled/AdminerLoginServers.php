<?php
require_once('plugins/AdminerLoginServers.php');

return new AdminerLoginServers(array(
    "mysql://mysql:3306#warproject",
    "pgsql://postgresql:5432#kong",
));
