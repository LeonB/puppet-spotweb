class spotweb::config {

    # do package before config
    Class['spotweb::package'] -> Class['spotweb::config']

    php::fpm::pool { 'spotweb':
        port   => 9007,
        ensure => $spotweb::ensure,
        user   => 'www-data',
        group  => 'www-data',
    }

    nginx::vhost::snippet { 'spotweb':
        vhost   => 'default',
        content => template('spotweb/nginx_vhost.erb'),
        ensure  => $spotweb::ensure
     }

    mysql::db { $spotweb::mysql_database:
        user     => $spotweb::mysql_user,
        password => $spotweb::mysql_password,
        host     => $spotweb::mysql_host,
        grant    => ['all'],
    }

    file { "${spotweb::path}/dbsettings.inc.php":
        owner   => 'root',
        group   => 'root',
        mode    => 0644,
        content => template('spotweb/dbsettings.inc.php.erb'),
    }

    exec { '/usr/bin/php5 /usr/share/spotweb/upgrade-db.php':
        refreshonly => true,
        subscribe   => Git::Repo['spotweb'],
        require     => File["${spotweb::path}/dbsettings.inc.php"],
    }

    cron { 'spotweb retrieve':
        command => '/usr/bin/php5 /usr/share/spotweb/retrieve.php',
        user    => www-data,
        hour    => [8, 12],
        minute  => 0
    }

}
