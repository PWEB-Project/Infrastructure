<?php
require_once('plugins/AdminerLoginServers.php');

return new AdminerLoginServers(array(
    "pgsql://postgresql:5432#warproject",
));
