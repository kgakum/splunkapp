class undeploy {
   notify { 'Will undeploy and disable splunk forwarder. Config will be preserved': }

     service { "splunk":
     enable      =>  false,
     ensure      =>  "stopped",
     hasrestart  =>  true,
     hasstatus   =>  true,
   }

   package { "splunkforwarder":
     ensure  =>  "absent",
   }
 }
include undeploy
