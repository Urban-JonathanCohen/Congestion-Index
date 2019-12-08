# Towards a city congestion index: methodological explorations using Google's Distance Matrix API
#### Keywords:
Congestion, Accessibility, Spatial Inequalities

##### Jonathan Cohen & Jorge Gil
###### Department of Architecture and Civil Engineering, Chalmers University of Technology
*email: jonathan.cohen@chalmers.se*

## Abstract
### Introduction:
As cities grow, urban activities diversify, and their location spreads across the city, mobility becomes a fundamental feature of everyone’s daily life. As a result, mobility holds the potential to unlock not only efficiency gains, but also enhance quality of life. Improvements to mobility are usually associated with positive effects such as access to opportunities. 

If neglected, negative externalities such as pollution, barriers and congestion can jeopardise efforts assigned to improve the urban system. 

This work provides a methodology for measuring traffic congestion and studies how it is distributed across an urban area. This allows to identify which regions of the city are more affected or evaluate the consequences of transportation projects. 

### Methods:
The method proposed takes Census Tracks as Geographical Unit (GU) of metropolitan regions. Using Goolge's API, travel times and distances from each GU to all other are retrieved. A a data-set of n * (n - 1) trip details is constructed for a 'congested' and a 'non-congested' situation. The average difference between these situations is calculated for each GU; resulting in the Congested Index. \par

### Results:
The tool is tested for Goteborg and Amsterdam. A map of the synthetic Congestion measurement is used to capture the phenomena within each city. Mapping and visualising the Index allows to identify which areas need improvement. The Congestion values can be used to understand if the problem affects equally different population groups in terms of income, age or ethnicity. \par


### Conclusions:
The strategy presented to capture the level of traffic within a city is systematic, generalizable and low-budget. The use of the tool over time, will allow practitioners to understand how traffic evolves and evaluate transport policies.\par

### Grant Support: 
Chalmers Area of Advance Building Futures

