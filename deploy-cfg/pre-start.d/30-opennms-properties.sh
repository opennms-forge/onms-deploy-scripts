#!/bin/bash

source deploy-cfg/include/pre-script.sh

echo "opennms.poller.server.registryPort=10990" >> $OPENNMS_ROOT/etc/opennms.properties
# echo "org.opennms.web.console.centerUrl=/trend/trend-box.htm,/heatmap/heatmap-box.jsp" >> $OPENNMS_ROOT/etc/opennms.properties
# echo "org.opennms.web.console.centerUrl=/includes/categories-box.jsp,/heatmap/heatmap-box.jsp" >> $OPENNMS_ROOT/etc/opennms.properties

echo "org.opennms.rrd.storeByForeignSource=true" >> $OPENNMS_ROOT/etc/opennms.properties

echo "org.opennms.grafanaBox.show=true" >> $OPENNMS_ROOT/etc/opennms.properties
echo "org.opennms.grafanaBox.hostname=opennms.informatik.hs-fulda.de" >> $OPENNMS_ROOT/etc/opennms.properties
echo "org.opennms.grafanaBox.port=3443" >> $OPENNMS_ROOT/etc/opennms.properties
echo "org.opennms.grafanaBox.apiKey=eyJrIjoieUZKV1pPdVNGNUVITDI3bzBBT21ra1EySjg3M0pRVHIiLCJuIjoiQWRtaW4iLCJpZCI6MX0=" >> $OPENNMS_ROOT/etc/opennms.properties
echo "org.opennms.grafanaBox.tag=OpenNMS" >> $OPENNMS_ROOT/etc/opennms.properties
echo "org.opennms.grafanaBox.protocol=https" >> $OPENNMS_ROOT/etc/opennms.properties
#echo "org.opennms.web.console.centerUrl=/surveillance-box.jsp,/trend/trend-box.htm" >> $OPENNMS_ROOT/etc/opennms.properties


source deploy-cfg/include/post-script.sh
