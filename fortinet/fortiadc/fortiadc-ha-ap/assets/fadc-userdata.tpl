Content-Type: multipart/mixed; boundary="===============0086047718136476635=="
MIME-Version: 1.0

--===============0086047718136476635==
config system global
  set hostname ${fadc_id}
  set admin-idle-timeout 120
end
config system interface
  edit "port1"
    set mode dhcp
    set vdom root
    set allowaccess https ssh
    set retrieve_dhcp_gateway enable
    config  ha-node-ip-list
    end
  next
  edit "port2"
    set vdom root
    set mode dhcp
    set allowaccess https ssh
    set retrieve_dhcp_gateway disable
  next
  edit "port3"
    set vdom root
    set mode dhcp
    set allowaccess https ssh
    set retrieve_dhcp_gateway disable
    end
  next
end
%{ if fadc_config_ha }
config system ha
set mode active-active-vrrp
  set hbdev port3
  set datadev port3
  set group-id 1
  set local-node-id ${fadc_ha_nodeid}
  set config-priority 90
  set l7-persistence-pickup enable
  set l4-persistence-pickup enable
  set hb-type unicast
  set priority ${fadc_ha_priority}
  set local-address ${fadc_ha_localip}
  set peer-address ${fadc_ha_peerip}
end
config system traffic-group
  edit "traffic_group_1"
    set failover-order ${fadc_a_ha_nodeid} ${fadc_b_ha_nodeid}
    set preempt enable
  next
  edit "traffic_group_2"
    set failover-order ${fadc_b_ha_nodeid} ${fadc_a_ha_nodeid}
    set preempt enable
  next
end
%{ endif }

%{ if fadc_license_file != "" }
--===============0086047718136476635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="${fadc_license_file}"

${file(fadc_license_file)}

%{ endif }
--===============0086047718136476635==--