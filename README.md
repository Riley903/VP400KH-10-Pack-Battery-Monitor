# Battery Back-up System

This project is the entriety of the NiCd battery back-up system used in my parents' house for emergency power in the event of a power failure.

![](/assets/TOP.jpg)

## Original Goal

The original goal of this project was to provide power to a water pump in the event of a power failure to provide water pressure to the house.

Recycling old heavy NiCd aircraft batteries in packs of 10 cells to provide 12V would be the electrical storage since it was free and would not need to be portable.

Several of these packs, originally 4 was deemed sufficient, would be used to power a 12V water pump from the recreational boating industry which provided the necessary 50psi at a reasonable flow rate. 

In addition to this battery storage solution, we planned to designa and build a small test unit that could calculate each cell's capacity such that we could grade them and organize them in packs of similar cells. Having 100s of cells, this is a must.

## Changes to the Original Goal

We were surprised by how effective the system was working as is with 4 packs and the pump, thus we decided to introduce 4 more packs and run an inverter to the house's main panel where it could be distributed through breakers to specific areas of the house. This would be useful for powering the lights and small appliances such as LED TVs, phone chargers, computers, and possibly the fridges and freezers.

## Some Future Plans

- Adding the 4 additional packs is still in the works.
- Water level metering to the storage tank outside.
- Silent charger for the packs.
- Upgrade the packs to the ESP32 dev board as the main controller.
- Once the ESP32's are installed, could implement a locally hosted website to view the packs and cells.
- Battery pack controllable disconnects and connects. (Look into high power transistors/thyristors capable of switching 100s of Amperes).
