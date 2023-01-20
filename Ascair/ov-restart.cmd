:: restart all OpenViva services on local server
:: author: flo.alt@fa-netz.de
:: ver 0.8

:: Monitoring offline

"C:\Program Files (x86)\Advanced Monitoring Agent\winagent.exe" /offline

timeout 10

:: stop all service
:: look at d:\oracle\skripten\start_stop\viva_alles_stoppen.cmd

call d:\oracle\skripten\start_stop\stop_tomcat.cmd
call d:\oracle\skripten\start_stop\stop_apache.cmd
call d:\oracle\skripten\start_stop\stop_weblogic_services.cmd
call d:\oracle\skripten\start_stop\viva_db_stop.cmd

timeout 60

:: start all services
:: look at d:\oracle\skripten\start_stop\viva_alles_starten.cmd

call d:\oracle\skripten\start_stop\viva_db_start.cmd
call d:\oracle\skripten\start_stop\start_weblogic_services.cmd
call d:\oracle\skripten\start_stop\start_apache.cmd
call d:\oracle\skripten\start_stop\start_tomcat.cmd

timeout 10

:: Monitoring online

"C:\Program Files (x86)\Advanced Monitoring Agent\winagent.exe" /online
