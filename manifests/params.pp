# Class: spotweb::params
#
# This class defines default parameters used by the main module class spotweb
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to spotweb class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class spotweb::params {

  ### Application related parameters

  $path = $::operatingsystem ? {
    default => '/usr/share/spotweb'
  }

    $mysql_database = 'spotweb'
  $mysql_user     = 'spotweb'
  $mysql_host     = 'localhost'

  $enabled = true

}
