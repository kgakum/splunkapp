class splunk_deploy {
notify { 'install splunkforwarder.': }

    package { "splunkforwarder":
    ensure  => "installed",
    provider => 'rpm',
    source  => "/etc/puppet/manifests/splunkforwarder-6.0.2-196940-linux-2.6-x86_64.rpm",
  }
}

class splunk_service {
notify { 'enable/start the splunk forwarder.': }

   exec { "splunk_enable_boot_start_accept_license":
     command => '/opt/splunkforwarder/bin/splunk enable boot-start --accept-license --no-prompt --answer-yes',
     onlyif =>  "/opt/splunkforwarder/bin/splunk enable boot-start --no-prompt 2>&1 | egrep -i '.*not.*accepted.*'",
     path => '/opt/splunkforwarder/bin:/usr/bin:/usr/sbin:/bin',
     require => Class['splunk_deploy'],
   }
   exec { "splunk_start":
     command => '/opt/splunkforwarder/bin/splunk start --accept-license --no-prompt --answer-yes',
	path => '/opt/splunkforwarder/bin:/usr/bin:/usr/sbin:/bin',
	require => Class['splunk_deploy'],
   }
}
include splunk_service
include splunk_deploy
class splunk_start {
     service { "splunk":
     enable => true,
     ensure => "running",
     require => Class['splunk_deploy'],
}
}
include splunk_start
