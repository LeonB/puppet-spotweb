class spotweb(
	$path           = params_lookup( 'path' ),
	$mysql_database = params_lookup( 'mysql_database' ),
	$mysql_user     = params_lookup( 'mysql_user' ),
	$mysql_password = params_lookup( 'mysql_password' ),
	$mysql_host     = params_lookup( 'mysql_host' ),
	$enabled        = params_lookup( 'enabled' )
  ) inherits spotweb::params {

	# install php before spotweb
	Class['php'] -> Class['spotweb']

  	$ensure = $enabled ? {
  		true => present,
  		false => absent
  	}

	include spotweb::package, spotweb::config
}
