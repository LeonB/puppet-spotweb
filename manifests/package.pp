class spotweb::package {

    git::repo { 'spotweb':
        path   => $spotweb::path,
        source => 'git://github.com/spotweb/spotweb.git',
        mode   => 0644,
    }

}
