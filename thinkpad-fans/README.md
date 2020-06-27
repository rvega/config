See the makefile for automatic control. You can manually do

https://wiki.archlinux.org/index.php/Fan_speed_control#ThinkPad_laptops

```
echo 'level 0' | sudo tee -a /proc/acpi/ibm/fan
echo 'level 7' | sudo tee -a /proc/acpi/ibm/fan
echo 'level full-speed' | sudo tee -a /proc/acpi/ibm/fan

cat /proc/acpi/ibm/thermal
cat /proc/acpi/ibm/fan
```

