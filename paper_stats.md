---
title: ''
author: ''
date: ''
output: 
  html_document:
    df_print: paged
    keep_md: true
  word_document:
    reference_docx: style.1.docx
---



# Statistical methods

Continuous variables were described by their means and SDs, medians and IQRs, and their range; while categorical variables were described by their counts and percentages in each category. Average treatment effects were estimated using mixed effects models with a random effect for participant. All reported models were adjusted for the sex of the participant (to correspond to the sex-stratified randomization lists). We also estimated a model with an added period effect, and another that also included an adjustment for period-specific baseline values of the outcome measure (REF). Following advice from Senn (REF), we did not formally test for a carry-over effect. All model-based estimates are reported with 95% CIs and p-values based on conditional F-tests with Kenward-Roger degrees of freedom (REF). We did not apply any adjustment for multiple testing, but have provided enough information for the reader to do so it they wish. Data were analysed on an intent-to-treat basis (i.e. without consideration for intervention compliance).

To evalaute the possilbity of heterogeneity of treatment effects, we 

All analyses were conducted using R language for statistical computing software V3.6.0 (2019-04-26). We used the lme4 package (REF) to estimate mixed effects models; ggplot2 (REF) to generate plots; and sjPlot to produce tables of model results. All anonymized data and the code used to analyze it and generate outputs can be found on the Open Science Framework (https://osf.io/zq4y9/). 


Table 1. Respondent characteristics




<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["Variable"],"name":[1],"type":["chr"],"align":["left"]},{"label":["N"],"name":[2],"type":["chr"],"align":["left"]},{"label":["Mean SD"],"name":[3],"type":["chr"],"align":["left"]},{"label":["Median [IQR]"],"name":[4],"type":["chr"],"align":["left"]},{"label":["(Min, Max)"],"name":[5],"type":["chr"],"align":["left"]}],"data":[{"1":"sequence","2":"83","3":"0.5 ± 0.5","4":"0 (0, 1)","5":"(0, 1)"},{"1":"sex","2":"83","3":"","4":"","5":""},{"1":"Male","2":"","3":"46 (55.4%)","4":"","5":""},{"1":"Female","2":"","3":"37 (44.6%)","4":"","5":""},{"1":"age_screening","2":"83","3":"57.7 ± 6.2","4":"57 (52.5, 63)","5":"(45, 70)"},{"1":"height_m","2":"83","3":"1.7 ± 0.1","4":"1.7 (1.6, 1.8)","5":"(1.5, 1.9)"},{"1":"weight_kg_screen","2":"83","3":"80.4 ± 13","4":"80.9 (70.6, 91)","5":"(53.5, 106.3)"},{"1":"bmi_screening","2":"83","3":"27.7 ± 3.5","4":"27.9 (25, 29.9)","5":"(20.4, 37.2)"},{"1":"sbpscreening","2":"83","3":"140.4 ± 10.1","4":"140 (132.5, 146)","5":"(124, 171)"},{"1":"dbpscreening","2":"83","3":"89.5 ± 8.8","4":"89 (83.5, 95)","5":"(67, 112)"},{"1":"smoking_ever","2":"83","3":"","4":"","5":""},{"1":"No","2":"","3":"60 (72.3%)","4":"","5":""},{"1":"Yes","2":"","3":"23 (27.7%)","4":"","5":""},{"1":"alcohol_consumption","2":"83","3":"","4":"","5":""},{"1":"No","2":"","3":"21 (25.3%)","4":"","5":""},{"1":"Yes","2":"","3":"62 (74.7%)","4":"","5":""},{"1":"physical_mins","2":"55","3":"43.7 ± 32.1","4":"34.3 (19.6, 57.9)","5":"(4.3, 148)"},{"1":"tv_hours","2":"82","3":"1.9 ± 1.7","4":"1.5 (1, 2.5)","5":"(0, 12)"},{"1":"sleep_hours","2":"82","3":"7 ± 1.1","4":"7 (6.5, 8)","5":"(3.5, 10)"},{"1":"occupation","2":"82","3":"","4":"","5":""},{"1":"1","2":"","3":"37 (45.1%)","4":"","5":""},{"1":"2","2":"","3":"20 (24.4%)","4":"","5":""},{"1":"3","2":"","3":"15 (18.3%)","4":"","5":""},{"1":"4","2":"","3":"1 (1.2%)","4":"","5":""},{"1":"5","2":"","3":"9 (11%)","4":"","5":""},{"1":"educationcategory","2":"82","3":"","4":"","5":""},{"1":"1","2":"","3":"2 (2.4%)","4":"","5":""},{"1":"3","2":"","3":"22 (26.8%)","4":"","5":""},{"1":"4","2":"","3":"34 (41.5%)","4":"","5":""},{"1":"5","2":"","3":"24 (29.3%)","4":"","5":""}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


Table 2. Blood pressure outcomes


Outcome    n_control   mean_control   sd_control   n_active   mean_active   sd_active   n_diff   Mean_diff   SD_diff  Estimate                     p
--------  ----------  -------------  -----------  ---------  ------------  ----------  -------  ----------  --------  -----------------------  -----
SBP               81            140         14.0         83           140        14.0       81        0.37      11.0  -0.078 (-2.92 to 2.77)    0.96
C SBP             82            140         14.0         81           140        15.0       80        1.10      11.0  0.47 (-2.33 to 3.27)      0.74
DBP               81             89          9.5         83            89         9.0       81       -0.26       7.6  -0.14 (-1.97 to 1.69)     0.88
C DBP             82             77          7.1         81            77         6.7       80       -0.31       6.5  -0.27 (-1.76 to 1.22)     0.72

Figure 1. Mixed-effect model estimated treatment effects for blood pressure outcomes. 

![](paper_stats_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

Figure 2. Change in systolic blood pressure across the two study periods

![](paper_stats_files/figure-html/unnamed-chunk-3-1.png)<!-- -->


Heterogenity


var                         vr       p
-----------------------  -----  ------
SBP                       0.98   0.921
DBP                       0.90   0.528
Central SBP               1.10   0.659
Central DBP               0.86   0.424
Arterial Stiffness        1.10   0.501
Glucose                   1.00   0.920
log(HDL)                  0.58   0.001
LDL                       1.20   0.309
log(OxLDL)                1.20   0.301
PWA Augment               0.78   0.205
log(TAG)                  0.85   0.335
log(Total Cholesterol)    0.99   0.944


![](paper_stats_files/figure-html/hdl_variance_plot-1.png)<!-- -->


![](paper_stats_files/figure-html/all_distributions-1.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-2.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-3.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-4.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-5.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-6.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-7.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-8.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-9.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-10.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-11.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-12.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-13.png)<!-- -->![](paper_stats_files/figure-html/all_distributions-14.png)<!-- -->

