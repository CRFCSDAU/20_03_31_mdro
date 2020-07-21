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




TLDR: There are hip patients who are known carriers but not necessarily infected with a multi-drug resistant organism (MDRO). In order to prevent other patients from being colonised/cross contaminated by such organisms “MDRO patients” are isolated within the hospital. This really limits this cohort of patients’ access to basic care. Anecdotally they wait for much longer to get a bed on the ward and are left on trollies in ED far longer and also have to wait much longer to get to theatre for their broken hip…..but nobody has shown this.

Primary outcomes: Time to theatre for hip fracture Fixation, Time to ward bed from emergency department

Secondary outcomes: Thirty day mortality, local cost analysis (we have more detailed data for waterford)

Key variables in the dataset:

**adm_trauma_date_time**: Date & Time of Trauma causing Hip Fracture

**adm_date**: admission date

**adm_ae_dis_date_time**: Date and time of leaving ED for operating hospital *(key data piece for this study as often MDROs patients are stuck in EDs waiting for isolation beds)*

**adm_first_pres_hosp_date_time**: Date and time of arrival at first presenting hospital (not all hospitals have orthopaedics  e.g. if a patient presents to Kilkenny hospital and is subsequently transferred to Waterford for fixation -this time represents date/time of presentation to Kilkenny hospital)

**adm_ae_date_time**: Date and time of arrival to operating (orthopaedic) hospital
 
**adm_trauma_team_date_time**: Date & time seen by orthopaedic team in operating hospital
 
**adm_orth_ward_date_time**: Date & time admission to an orthopaedic ward *(Again a key piece of data here as often MDRO patients are delayed getting to ortho wards)*
 
**adm_primary_surgery_date_time**: Date & Time of primary surgery for hip fracture *this is one of our key outcomes (our hypothesis is that this is delayed in MDRO patients)*
 
**dis_date**: discharge date

**adm_ger_acute_assess_date_time**: Date & Time of assessment by geriatrician during acute admission
 
 
# Missing data for time variables

We need to establish how accurate the relevant dates are, so that we can feel confident they accurately reflect the relevant time variables we want to create. So the first step is just to try and look at them. 

Here are the missing values for each time variable.  

![](mdro_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

Below we relate each of these event times to the admission date/time (with no missing values), finding that several of them are likely to fall both before (in some patients) and after (in others) the admission time. 

![](mdro_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

Repeat the same thing for discharge times. 

![](mdro_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

Based on these, I'd probably just stop condsidering *adm_ae_date_time*, *adm_trauma_date_time*, and *adm_first_pres_hosp_date_time* (unless there is some way to explain these findings). Just as a reminder, these were:

**adm_trauma_date_time**: Date & Time of Trauma causing Hip Fracture

**adm_ae_date_time**: Date and time of arrival to operating (orthopaedic) hospital

**adm_first_pres_hosp_date_time**: Date and time of arrival at first presenting hospital (not all hospitals have orthopaedics  e.g. if a patient presents to Kilkenny hospital and is subsequently transferred to Waterford for fixation -this time represents date/time of presentation to Kilkenny hospital)

And then we will also remove *adm_trauma_team_date_time* since so many are missing. 
 
Now we can look at what order these different events tend to come in. In the plot below, each little point is a person, showing the order that a given event appeared. For example, for most, but not all, the *adm_date* was the first, the *adm_ae_dis_date_time* second, *adm_orth_ward_date_time* third, *adm_primary_surgery_date_time* fourth, and the *dis_date* 5th (of all the patients, only 6 had all 6 of these dates, so you can't see them on the plot).


![](mdro_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

Here are the same data as a filled (proportional) bar chart. 

![](mdro_files/figure-html/unnamed-chunk-6-1.png)<!-- -->
Importantly, the plots above include people that don't have all 5 of these event times in their record. So here is what it looks like if we restrict the data to those with all 5 events. 



![](mdro_files/figure-html/unnamed-chunk-8-1.png)<!-- -->

![](mdro_files/figure-html/unnamed-chunk-9-1.png)<!-- -->

This reduced dataset includes 10903 of 18118 patients (60.2%). 


# Time to AE


  





# Time to theatre for hip fracture fixation

















<!--html_preserve--><div class="container st-container">
<h3>Data Frame Summary</h3>
<h4>data</h4>
<strong>Dimensions</strong>: 18118 x 221
  <br/><strong>Duplicates</strong>: 0
<br/>
<table class="table table-striped table-bordered st-table st-table-striped st-table-bordered st-multiline ">
  <thead>
    <tr>
      <th align="center" class="st-protect-top-border"><strong>No</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Variable</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Stats / Values</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Freqs (% of Valid)</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Graph</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Valid</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Missing</strong></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center">1</td>
      <td align="left">id
[integer]</td>
      <td align="left">Mean (sd) : 9059.5 (5230.4)
min < med < max:
1 < 9059.5 < 18118
IQR (CV) : 9058.5 (0.6)</td>
      <td align="left" style="vertical-align:middle">18118 distinct values
(Integer sequence)</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAGJJREFUaN7t2TEOgCAMQNFewSvIDej97yYkJjroIHZ8PyF0IG9jaoRW2n+3jU6sZeY4/bqex/Y2dhgMBoPBYDAYDAaDwWAwGAwGg8FgMBisApuLrDJsvoPBYFGxYL79TX3rABuWFBW3whzBAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwYc8ztgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMBCSiwoAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">2</td>
      <td align="left">adm_date
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-05-16
med : 2016-05-18
max : 2018-12-29
range : 6y 7m 13d</td>
      <td align="left" style="vertical-align:middle">2231 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAMRJREFUaN7t11EOwjAIgOFewd5g7Ab2/ndzbR1p0mkUyDT6k76MhC88MLqlRFjiYg0RWfTBi62lgH0YkxZLDNaPF8tbQ3FY2SUXVnuKw0q5goH1oZqwLWvBWhtTqh03Jq0nN9aXzbpLPkwrwV7A+qjZMb3470M17ui3Mb3EDiYU7DQsH77VFmzcD25sLAMDi8d0eUVgcxnYOVjW74kI7FEZ2JdjdQbCsJoFAwMDAwP7J0z/B0OwJ2VgYGBgYL+KSUgkwhI3Vh8PoRVkzpcAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDBhzzO2AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwEJKLCgAAAABJRU5ErkJggg=="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">3</td>
      <td align="left">hosp
[character]</td>
      <td align="left">1. 0600
2. 0910
3. 0300
4. 0724
5. 0922
6. 0203
7. 0800
8. 1270
9. 0108
10. 0908
[ 6 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2219</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1843</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1667</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1552</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1507</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1258</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1141</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1057</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">938</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">858</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4078</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">22.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAC4AAAESBAMAAABwWPpmAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAKRJREFUWMPt1NEJwCAQA1BXcAR1A7v/bv2owvVKKMIJTUk+348HCaa0P3Wm5CvD2zEip3bUb/YJ9vms93Fnl3M76jd4PwXcIyd31G/Ufl529fDmZi7ndNRv7H4KuEfO7qjf0P2Upzd3jvxfjnpf3Q9y9+vd7ulyekf9aj/yL+wHuf/27J1yfkf9oj2sup+tuafL+R31i/YQ5dXH7Nymyykd9bszJ/XI8pouwXK0AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwYc8ztgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMBCSiwoAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">4</td>
      <td align="left">dis_date
[POSIXct, POSIXt]</td>
      <td align="left">min : 2013-01-01
med : 2016-06-09
max : 2018-12-31
range : 5y 11m 30d</td>
      <td align="left" style="vertical-align:middle">2065 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAANZJREFUaN7t11sOhCAMBVC2MLMD6w6m+9/bpIHEgDxC20TFe3/UpJ4gKaghIJp8dPkS0XZcGjFmfglGMZsLtjP/0gCBjSLT7oYlxY7JOvLDDsWI5ZNlxHJlBazY/YxYvsfUekKDpTGee0KFxTM/rNpgWqyqXIjJw7lhUm3A4licsHj7M7BOg81jHeUKLFs9JqzcakxYWQ0M2G2x1ltWhzWqV8I6r+x5rFM9hzU/llRYvxrYzTFpUTdMDsCAAQMGDNg7MBr+N09gozJgwIABA7YuRi4JiCZ/F+9djRTHqZ8AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDBhzzO2AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwEJKLCgAAAABJRU5ErkJggg=="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">5</td>
      <td align="left">is_day_case
[numeric]</td>
      <td align="left">Min : 0
Mean : 0
Max : 1</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">18115</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">100.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAAA4BAMAAACMIT4NAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAD5JREFUWMPt1TEBABAABVEVREAD+nez2Iz+5l2At14pStVzHXGsVJNIJBKJxEvMn6vm+lpsRCKRSCR+Luq9DZcnwFokJcz/AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwYc8ztgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMBCSiwoAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">6</td>
      <td align="left">adm_type
[numeric]</td>
      <td align="left">Mean (sd) : 4 (0.3)
min < med < max:
1 < 4 < 5
IQR (CV) : 0 (0.1)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">150</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">10</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">17939</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">99.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">19</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKEAAABoBAMAAABrmI35AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAFtJREFUaN7t1UENwCAUBUEktA4KlYB/b73ggJcmP8wKmOu2plTjTnURiUQikfiDGAMPFzuRSCQSiaXEGHi4OGI9S3xnKiKRSCTWF/OfqXDXCmInEolEIrGUqP0+d96mlHLozO8AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDBhzzO2AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwEJKLCgAAAABJRU5ErkJggg=="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">7</td>
      <td align="left">discharge_code
[character]</td>
      <td align="left">1. 02
2. 01
3. 04
4. 10
5. 07
6. 03
7. 06
8. 09
9. 00
10. 11
[ 6 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7029</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">38.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5269</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">29.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3333</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">18.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">998</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">712</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">340</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">166</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">84</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">46</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">44</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">97</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAEcAAAESBAMAAABdqtXcAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAKVJREFUaN7t2MEJwCAMhWFHaDaouoHdf7dS6KnYmIsa5X/n76AhD8QQfCZpOV+ULyUgkG9k2nHRcsxB9RN/UHUEBQRaApl2fGrvflCu3QoEWgOZdly0TCxnbKFnBCDQosi046KlS+9iE2XlciCQc2TacdHSo3cGlAsItDcyFUFkKEogEGh47yIIBPL5Q+NxTiDQ7uX0OAIQaPfemZDHRzsINBx5yw3DaNkVw5/eBAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMGHPM7YAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDAQkosKAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">8</td>
      <td align="left">sex
[numeric]</td>
      <td align="left">Min : 1
Mean : 1.7
Max : 2</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">5378</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">29.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">12740</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">70.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHYAAAA4BAMAAADa2xE+AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAEVJREFUSMdjYBh5QAkrUBTEC6B6lY2xgVG9o3pH9Y7qHXx6KSnrBMkBQ1ivEjkAbxzhB0ajekf1juod1TsAeikp60YSAACKOHj6LKKsXgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMGHPM7YAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDAQkosKAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">9</td>
      <td align="left">marr_status
[numeric]</td>
      <td align="left">Mean (sd) : 2.4 (1)
min < med < max:
1 < 2 < 8
IQR (CV) : 1 (0.4)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3119</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">17.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">6848</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">37.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">6691</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">36.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">564</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">3.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">719</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">4.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">170</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">5</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAEUAAADKBAMAAAABRZAXAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAIlJREFUWMPt1MENgCAQRFFKYDsQ6ED6782LBzQKm0hwCX/O78AmMzhnL7FMkEv8aVIugsFMbjSdl0p6m1jJ9nTXLRiMJaPp88h9fd2gb9++YzCWjKbPY/cVmiZlDGYOo+mzVPLPBt8fXfwtGMwURtNnqaT7vjCYxYwYMwGDWczIQGPtdgzGgrGUAzeSPpPr2u9gAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwYc8ztgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMBCSiwoAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">10</td>
      <td align="left">resid
[character]</td>
      <td align="left">1. 1200
2. 2800
3. 0200
4. 1900
5. 1300
6. 0300
7. 0600
8. 3200
9. 3100
10. 0400
[ 64 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1004</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">834</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">754</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">753</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">658</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">625</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">625</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">582</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">581</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">575</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">11127</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">61.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGkAAAESBAMAAAAMPua/AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAALBJREFUaN7t1sENgzAQRUFKSDoIpAPcf28QKYo4ehcpiPXsfS7/8OxpqnvLfvOz9x5f9W6tURQ1qsp1oxvcTH3WiKt9+ZWiqFFVrhv94ioVehyOG1IUNazKdaNf3EupKEVRUVW1oqHP8mHDwMecoqhiKteNALlI6SFFUf9RKnp+Q4qiaig9PL8hRVE1VNUe5pSKUhQVVVUrqocURUVV1R7m1BK612/5yFEUVUvlulHxNoVdBJk3/iE3AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwYc8ztgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMBCSiwoAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">11</td>
      <td align="left">specialty
[character]</td>
      <td align="left">1. 1800
2. 5000
3. 0900
4. 2300
5. 2400
6. 0700
7. 2600
8. 0400
9. 2500
10. 0100
[ 16 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">17024</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">94.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">344</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">338</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">89</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">63</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">51</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">48</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">31</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">30</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">20</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">80</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJkAAAESBAMAAAAccmomAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAALRJREFUeNrt1bERwlAQQ0GXAB1wdgem/95ICAhIYHQDN39fAZso0Lbp2/ZIt6d23BPRaDQa7Xda9heukS7Lafue1I6TRqPRaLO17C8krBmaP6XRaDTaq+ZP/0GLjECj0Wg02lstgo3Qikaj0Wi0Ni2CjdCKRqPRaLQhWgQboRWNRqPRaG1aBBuhFY1Go9FobVoEW1ArGo1Go9HatAg2QisajUaj0dq0CLagVjQajUajtWn6vAfKyrI3/AN4HQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMGHPM7YAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDAQkosKAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">12</td>
      <td align="left">dis_status
[numeric]</td>
      <td align="left">Min : 1
Mean : 1.2
Max : 2</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">13828</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">76.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4290</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">23.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAH8AAAA4BAMAAAAmzjr0AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAEZJREFUSMdjYBgFIKBELlCAGqBsTCYYNWDUgFEDRg0YhgZQXKgKkgsEho8BmKFDogEY0Wg0asCoAaMGjBowcg2guFAd6QAABvmIumNI6P0AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDBhzzO2AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwEJKLCgAAAABJRU5ErkJggg=="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">13</td>
      <td align="left">adm_ward
[character]</td>
      <td align="left">1. TRAUMA
2. ED2
3. OIWA
4. ORT2
5. ORT1
6. FINBMR
7. LAUR
8. JCM006
9. EMR
10. ORT
[ 254 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1492</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1289</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1104</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1064</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">980</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">922</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">845</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">836</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">720</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">678</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8188</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">45.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFAAAAESBAMAAACY2E9NAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAK1JREFUaN7t17ENhDAQRFFa2BKwO4D+e0MgJCCAGQLLBv8fv8RIs7obhm+Utsa4b4d5XgMCu4f2ZkJWH8q3XD4PEAi0NxOysrt24PrqCQgE2psJWX3IAQAC/3cA5G+P86uBQKC/mZAV3bUFszpmQCDwAu1xhYwDAAQ2Atk1EPg/+IVd21D++Th9HiAQ+GIzISu5aw9mdfWAwD6gvZmQ1YdJdpy95yYgsAtob6b1Fm3+HWwo3T7BAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwYc8ztgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMBCSiwoAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">14</td>
      <td align="left">disward
[character]</td>
      <td align="left">1. TRAUMA
2. OIWA
3. ORT2
4. ORT1
5. JCM006
6. FINBMR
7. LAUR
8. 3FOU
9. ORT
10. ATRDIS
[ 255 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1528</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1144</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1040</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1017</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">889</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">852</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">847</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">776</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">712</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">683</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8630</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">47.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFQAAAESBAMAAACRM+83AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAKhJREFUaN7t1sEJwzAUA9Cs4BGcbpDuv1tIKKSnWg6E2vB0fhd/kPCyzJX1TC2/8qGv9xEURSPa0a0SZBR6viqjx7E2FEUz2tGtEuTxHaj5BVAUDWlHt0qQUajJQFGTEfxyvi7Q+juhKHqjWy32OLUDKPp3ajJQFJ1sB2p+ARRFU9rRrRYbiZoMFDUZwS/nukDz74Si6I1uNd1AdA1yjWYrG4qi/d2aJTtA5j97ZCjbSQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMGHPM7YAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDAQkosKAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">15</td>
      <td align="left">adm_source
[numeric]</td>
      <td align="left">Mean (sd) : 1.3 (0.8)
min < med < max:
0 < 1 < 8
IQR (CV) : 0 (0.6)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">14775</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">81.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1639</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">9.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1569</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">8.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">23</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">6</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">25</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">79</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIcAAADKBAMAAAB9D06LAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAJZJREFUaN7t1bENwzAMRUGNEG8QxRsk+++WIm4MuDIl4Ee41+sKCiBb01V9K/SAQCAQyH8gFSMQeVV6Hsj+KQSBQCDrIkN2bM7JyEGOEdWQ3xe/IRAIBHJGhuzYe69jEXcHAoFA5iHuziSkQyAQCCQbqRiByJCZQCAQCGQeUjFWRToEAoFAspGKEYgMmQkEAoFAwhGd+wKGsemq0IJ6bgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMGHPM7YAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDAQkosKAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">16</td>
      <td align="left">priv_days
[numeric]</td>
      <td align="left">Mean (sd) : 1.5 (7.4)
min < med < max:
0 < 0 < 228
IQR (CV) : 0 (4.8)</td>
      <td align="left" style="vertical-align:middle">98 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAE5JREFUaN7t2VsVABAUAMFbQQRE0L+b45EAHz5mA0yBjdBJZZbTXRurbQSDwWAwGAwGg8FgMBgMBoPBYDAYDAaDwWCwr7B1hq+x8qTQSR2S9C9lE1LTSwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMGHPM7YAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDAQkosKAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">17</td>
      <td align="left">pub_days
[numeric]</td>
      <td align="left">Mean (sd) : 16.1 (24.7)
min < med < max:
0 < 10 < 726
IQR (CV) : 13 (1.5)</td>
      <td align="left" style="vertical-align:middle">218 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAFlJREFUaN7t2TERwCAURMFvIRIAB+DfWwKDAqAIM/uKK9fARWil3EvPZhMr7QsGg8FgMBgMBoPBYDAYDAaDwWAwGAwGg8FuwcZjegrrU/+L7ZzDE8tHCq30AjNLI+oWOU6jAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwYc8ztgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMBCSiwoAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">18</td>
      <td align="left">semi_priv_days
[numeric]</td>
      <td align="left">Mean (sd) : 1.9 (7.4)
min < med < max:
0 < 0 < 224
IQR (CV) : 0 (3.9)</td>
      <td align="left" style="vertical-align:middle">88 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAFhJREFUaN7t2TENwDAMRUFTKIS4EMKfWxZL2RN3qHQPwMl/doROyszxXFfYOycMBoPBYDAYDAaDwWAwGAwGg8FgMBgMBoP9BWv4l26s4bjvsNulhWVLoZMWpksIbAuAZg8AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDBhzzO2AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwEJKLCgAAAABJRU5ErkJggg=="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">19</td>
      <td align="left">itu_days
[numeric]</td>
      <td align="left">Mean (sd) : 0.2 (1.7)
min < med < max:
0 < 0 < 59
IQR (CV) : 0 (7.1)</td>
      <td align="left" style="vertical-align:middle">39 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAE5JREFUaN7t2VsVABAUAMFbQQRE0L+b45EAHz5mA0yBjdBJZZbTXRurbQSDwWAwGAwGg8FgMBgMBoPBYDAYDAaDwWCwr7B1hq+x8qTQSR2S9C9lE1LTSwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMGHPM7YAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDAQkosKAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">20</td>
      <td align="left">w_list
[character]</td>
      <td align="left">1. 0</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">116</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">100.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAAAgCAQAAAA7g2tDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfkBxUJNx+GOB7HAAAAiUlEQVRo3u3ZMQrCMABAUSO9oKMndOwRdax1kvZD0b43JQRC+JAsGc8Le12PPsA/EDEgYmB6nzw8kF+7j2U8rZduR5/tR8yrmescEDEgYkDEgIgBEQMiBkQMiBgQMSBiQMSAiAERAyIGRAyIGBAxIGJAxICIgY/fvnnbLic3fDXv5zoHRAyIGHgBq0kF8n47YVkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDBhzzO2AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwEJKLCgAAAABJRU5ErkJggg=="></td>
      <td align="center">116
(0.64%)</td>
      <td align="center">18002
(99.36%)</td>
    </tr>
    <tr>
      <td align="center">21</td>
      <td align="left">em_adm
[numeric]</td>
      <td align="left">Mean (sd) : 1.2 (0.5)
min < med < max:
1 < 1 < 5
IQR (CV) : 0 (0.5)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">16515</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">92.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">127</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1309</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">7.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">5</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJYAAACABAMAAAAboI1XAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAAG9JREFUaN7t1sENgCAQRUFasASwA+y/NxO1AAlLQDOvgDnu/pTUWonosfajv8pisVisIVbkvd8iWtwqLBaLxWJNtCKo1a17XMRY12aqLBaLxfq7Ffk7OpVPWJnFYrFYrIlWBLW6lVksFovFarT0vhNwN++KFZcSiAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMGHPM7YAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDAQkosKAAAAAElFTkSuQmCC"></td>
      <td align="center">17958
(99.12%)</td>
      <td align="center">160
(0.88%)</td>
    </tr>
    <tr>
      <td align="center">22</td>
      <td align="left">adm_weight
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">23</td>
      <td align="left">was_in_day_ward
[character]</td>
      <td align="left">1. 1</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">100.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAAAgCAQAAAA7g2tDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfkBxUJNx+GOB7HAAAAiUlEQVRo3u3ZMQrCMABAUSO9oKMndOwRdax1kvZD0b43JQRC+JAsGc8Le12PPsA/EDEgYmB6nzw8kF+7j2U8rZduR5/tR8yrmescEDEgYkDEgIgBEQMiBkQMiBgQMSBiQMSAiAERAyIGRAyIGBAxIGJAxICIgY/fvnnbLic3fDXv5zoHRAyIGHgBq0kF8n47YVkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzErMDE6MDBhzzO2AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwEJKLCgAAAABJRU5ErkJggg=="></td>
      <td align="center">3
(0.02%)</td>
      <td align="center">18115
(99.98%)</td>
    </tr>
    <tr>
      <td align="center">24</td>
      <td align="left">day_ward
[character]</td>
      <td align="left">1. DIAL
2. ONC
3. RDU</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">33.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">33.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">33.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAD8AAABQBAMAAABc07BjAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcfhjgexwAAADtJREFUSMdjYBgcQAkXUIAqUDbGAUYVjCqgjQKCaVIQFxCgn4LRjDOqYMgpGM1ZowpGFZChgGCaHGgAAEZjRwJD4xmXAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMxKzAxOjAwYc8ztgAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMBCSiwoAAAAASUVORK5CYII="></td>
      <td align="center">3
(0.02%)</td>
      <td align="center">18115
(99.98%)</td>
    </tr>
    <tr>
      <td align="center">25</td>
      <td align="left">trans_in_hosp
[character]</td>
      <td align="left">1. 0402
2. 0605
3. 0601
4. 0607
5. 0102
6. 0403
7. 0201
8. 0202
9. 0400
10. 0919
[ 36 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">363</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">23.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">278</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">17.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">239</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">15.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">214</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">110</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">41</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">35</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">32</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">30</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">28</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">199</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAC8AAAESBAMAAACfmpFYAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAJ9JREFUWMPt2LENgDAMBEBGwBtgvEGy/240SMRWviJJ4fy3V2DpX0hwHGtyx1wvWA0hZAHYucSc48E9WBtw5xIyAex80q4cNFcVQiqAna99kamH71xCMoCdj96VdsCagwipAHY+dFfaB6uE3QCOQWL+DA6AFUJSgJ2LDAPuaj9YsSsIHNx+sORFpugqQlaAnYvMh/C3pPPBWwjJAHY+Ow8ByQGe4N9nYAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMSswMTowMGHPM7YAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDAhepGXAAAAAElFTkSuQmCC"></td>
      <td align="center">1569
(8.66%)</td>
      <td align="center">16549
(91.34%)</td>
    </tr>
    <tr>
      <td align="center">26</td>
      <td align="left">trans_out_hosp
[character]</td>
      <td align="left">1. 0915
2. 0954
3. 0302
4. 0955
5. 0925
6. 0402
7. 0803
8. 0404
9. 0101
10. 0400
[ 50 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">783</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">21.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">714</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">19.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">642</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">17.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">308</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">163</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">125</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">106</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">95</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">90</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">80</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">567</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">15.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAC0AAAESBAMAAACbb0FlAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAKlJREFUWMPt2MsJgDAQBNCU4HZgTAdr/72J4CdZM4dAImyYPb6LAzMoGML428ytl6e9PLpPR/2KuaWzm8c+XuZUulNH/Q7ZT5R6HrpbR/3+816KH093QLprR/123E+secrD0N066hftodXPb2U9j9IndtQ72kmrm9lmeegzOOpXzHE/9JZ+xVz/XdU9KX0GR/2K9HHuZ24fvR/kxc+rPOf7t0Lpfh31O/IOr9Dv9lPZk+MAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDBQJykrAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwIXqRlwAAAABJRU5ErkJggg=="></td>
      <td align="center">3673
(20.27%)</td>
      <td align="center">14445
(79.73%)</td>
    </tr>
    <tr>
      <td align="center">27</td>
      <td align="left">los
[numeric]</td>
      <td align="left">Mean (sd) : 19.8 (27.6)
min < med < max:
1 < 13 < 1227
IQR (CV) : 13 (1.4)</td>
      <td align="left" style="vertical-align:middle">231 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAE9JREFUaN7t2UERABAUQMFfQQQ0oH83xkiAg8O+AFvgReikskqXbaz2WYPBYDAYDAaDwWAwGAwGg8FgMBgMBoPBYDDYV9gaw/kaK08KnTQAELMowMgpJeMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDBQJykrAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwIXqRlwAAAABJRU5ErkJggg=="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">28</td>
      <td align="left">age
[numeric]</td>
      <td align="left">Mean (sd) : 80.6 (8.7)
min < med < max:
60 < 82 < 105
IQR (CV) : 13 (0.1)</td>
      <td align="left" style="vertical-align:middle">46 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAJJJREFUaN7t2csJwCAQRVFbSDpI0kGm/94CYWah4F8Mwfs2gujBxeAHnSMt2dI5NZlhZdglb24wsAiWqbc6TNIrBAMD+yNmu8QQTBEBAwMDA1sH2/2DpBPzETAwsBUx3VSOIZi2MzG7Xg/BgllgYGAfY5H3cxsWmQUGBgYGVo+FvyBdmHWDgc3ArHiDu0ZfHGnJA7I2oZZvu3hrAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwUCcpKwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMiswMTowMCF6kZcAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">29</td>
      <td align="left">age_group
[character]</td>
      <td align="left">1. 60-69
2. 70-79
3. 80-89
4. 90+</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2358</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5139</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">28.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7823</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">43.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2798</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">15.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAE0AAABoBAMAAABGRmAGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAGJJREFUWMPt070JACAMhFFH0A00bqD772YjkkKSFIJ/99WvOjjnzo9GYZrvLtdegYP7x1n/EZR2O5qVhF14cHCPO+s/Vv9ytSOlKO3CgoN70Vn/cdPPJcd2KXBwvzjrP06uAaAOlwLKXOv2AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwUCcpKwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMiswMTowMCF6kZcAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">30</td>
      <td align="left">drg
[character]</td>
      <td align="left">1. I03B
2. I08B
3. I08A
4. I03A
5. I78B
6. I78A
7. W02B
8. 801A
9. W02A
10. I28A
[ 154 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5904</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">36.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5559</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">34.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1583</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1535</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">346</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">234</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">156</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">126</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">76</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">54</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">554</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAEMAAAESBAMAAABUQXWmAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAKJJREFUaN7t2LENgDAMRFFGwBuQZINk/92gAAqEwZXjRP/qV2DpTkhZlljJeraTlKYGAulHDN0VPas30b/2JurRFQLpSAzd9d5R+iDnRRBILGLoruhhahDIgFM7fpN/pFQIJCAxdFfEibyu+XERBDIoMdRbxIlkCGReIl4k0tEQyKg7MpAEgcxLxItEOhoCGXVHBpL115WLlFYhkHjE0N0o2QELxbHYwlAlRgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMiswMTowMFAnKSsAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDAhepGXAAAAAElFTkSuQmCC"></td>
      <td align="center">16127
(89.01%)</td>
      <td align="center">1991
(10.99%)</td>
    </tr>
    <tr>
      <td align="center">31</td>
      <td align="left">mdc
[numeric]</td>
      <td align="left">Mean (sd) : 7.3 (3.2)
min < med < max:
0 < 8 < 23
IQR (CV) : 0 (0.4)</td>
      <td align="left" style="vertical-align:middle">18 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAGJJREFUaN7t2bENgDAMRcGsEDbAbAD774YCFZaQIKRC9/p/nSuXop5qborWXF91i20tGAwGg8FgMBgMBoPBYDAYDAaDwWAw2P+xyG+mL9iStzAY7BF2HuIg7FiuFyyGVNTTDoSfM4IR2ogBAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwUCcpKwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMiswMTowMCF6kZcAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">32</td>
      <td align="left">has_med_card
[numeric]</td>
      <td align="left">Mean (sd) : 0.7 (0.5)
min < med < max:
0 < 1 < 2
IQR (CV) : 1 (0.7)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">6120</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">33.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">11940</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">65.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">58</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAG8AAABQBAMAAADlxzYrAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAFFJREFUWMPt1LENACAMA0FGgA1IGIH9d6OhJEKEKvDfX2XJKf2RWklZlyds3QgIBAJt6P6cclpAqKfV3RxWQCAQeAHdZxXokN1QgEAgMAJ8vQHOBrt6TK+9aQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMiswMTowMFAnKSsAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDAhepGXAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">33</td>
      <td align="left">health_insurer
[numeric]</td>
      <td align="left">Mean (sd) : 1.5 (1.3)
min < med < max:
0 < 1 < 9
IQR (CV) : 0 (0.9)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">28</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3227</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">75.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">507</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">11.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">279</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">6.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">76</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">106</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">10</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">45</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">12</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAH0AAADiBAMAAACRntWAAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAKlJREFUaN7t2sEJwzAMBdCM0G5Qxxuk++9WCC2U3iwVrOD37+8gHT4ItG2y32O58TzP8ykf5GX8Hszj7fszFp7n+dk+23+z+/tv/R/0n/0fPM/zi/lsfw6ycv6cvcX9uX+e5/kL+mz/jctaPjL7t+88z/OL+mx/xnQdP3w4/fg+erjxPM8X8dn+i+k6vvE8z/NTfJCX8bP/v3ie56/qg7yMbzzP8/wUv3JeRyn/Hsc9dPoAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDBQJykrAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwIXqRlwAAAABJRU5ErkJggg=="></td>
      <td align="center">4290
(23.68%)</td>
      <td align="center">13828
(76.32%)</td>
    </tr>
    <tr>
      <td align="center">34</td>
      <td align="left">adm_trauma_date_time
[POSIXct, POSIXt]</td>
      <td align="left">min : 2007-03-12 22:00:00
med : 2016-11-01 17:30:00
max : 2018-12-26 15:30:00
range : 11y 9m 13d 17H 30M 0S</td>
      <td align="left" style="vertical-align:middle">6245 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAJVJREFUaN7t1ssJwCAQhGFbSErQDtz+e4sSQfI46USD/HPZ28eCyI5zpCVbV3xKnhIsmEWwSdieXlKHmRnYElj+4TIsK2BgYGATMF9unAQLRfkCy4vKsDQi2Cis9CgRdgpgYGDLYrViC7Aq/Am7Xt5O7CqAgYGBDcOeDa8HewhgYGLstWC0Yq8CGBgYGBjYDfOSONKSA7/B/rDFJ+g4AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwUCcpKwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMiswMTowMCF6kZcAAAAASUVORK5CYII="></td>
      <td align="center">6473
(35.73%)</td>
      <td align="center">11645
(64.27%)</td>
    </tr>
    <tr>
      <td align="center">35</td>
      <td align="left">adm_trauma_type
[numeric]</td>
      <td align="left">Mean (sd) : 2.2 (1.1)
min < med < max:
1 < 2 < 9
IQR (CV) : 0 (0.5)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">594</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">3.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">16769</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">93.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">469</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">93</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJkAAABoBAMAAAAQvE81AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAG9JREFUWMPt2MEJwCAQRFFLiB2YsYPYf29eQk5e1IEo/l/AOy0MbAg0mqQ43/VquTxoaGhoaFtr3l0wUEdqspS+C3GEhoaGhvaf5t2FlRdwZU26jVouaGhoaGh7a95dMFBHao7/BRoaGhoaWluj/irupIv5KOHReQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMiswMTowMFAnKSsAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDAhepGXAAAAAElFTkSuQmCC"></td>
      <td align="center">17925
(98.93%)</td>
      <td align="center">193
(1.07%)</td>
    </tr>
    <tr>
      <td align="center">36</td>
      <td align="left">adm_first_pres_hosp_date_time
[POSIXct, POSIXt]</td>
      <td align="left">min : 2007-05-04 17:30:00
med : 2016-06-01 21:23:00
max : 2018-12-29 14:27:00
range : 11y 7m 24d 20H 57M 0S</td>
      <td align="left" style="vertical-align:middle">17064 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAJ5JREFUaN7t2EEKgCAQhWGvkDfIbtDc/24pCBJp4TiL0P9tdPUtlHmgzhFNNn1CTN6OY4fICdaPxTvYzTARmRnz8bDssKiATYGlIjPDsvInLBe1DZYbzA4rQ2mAFQUMDEyJ+cdQjmAPRYvdi3oQqypgYGBg1TRbUYW1FDAwMDAwMDCwpbH04jPD0gK2HuZfvg36sQ8FDAysYMEkjmhyAdr4JUBpEpjdAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwUCcpKwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMiswMTowMCF6kZcAAAAASUVORK5CYII="></td>
      <td align="center">17161
(94.72%)</td>
      <td align="center">957
(5.28%)</td>
    </tr>
    <tr>
      <td align="center">37</td>
      <td align="left">adm_via_ed
[numeric]</td>
      <td align="left">Min : 1
Mean : 1.1
Max : 2</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">16400</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">90.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1718</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">9.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJQAAAA4BAMAAADpzMxyAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAEtJREFUWMPt1UENACAMBMFaQALgAPx76+cEQLgHgV0B82iaXATt1AyJ6vO4AQUFBQV1F2WciWLoF0qXqwZKzwAFBQUF9RBlnAlaKwGtlqjKDhwTYAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMiswMTowMFAnKSsAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDAhepGXAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">38</td>
      <td align="left">adm_ae_date_time
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-03-12 15:05:00
med : 2016-06-17 13:14:00
max : 2028-02-17 04:18:00
range : 15y 11m 4d 13H 13M 0S</td>
      <td align="left" style="vertical-align:middle">16147 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAHNJREFUaN7t2EEKgCAQQFGvYEewG9T97xZlCyMiLImQ9/fzmI0MGIKeFM+lXKzoGhvntQkGg/0FG/ILb4RtygyDwX6N1dz1W6xmP1i32H5KGmHFPAwGg8FgMBgMBoPBYDAYrFcsFV9Kr7HDJOx7LDUp6EkLZFXwWJT7v8UAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDBQJykrAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwIXqRlwAAAABJRU5ErkJggg=="></td>
      <td align="center">16233
(89.6%)</td>
      <td align="center">1885
(10.4%)</td>
    </tr>
    <tr>
      <td align="center">39</td>
      <td align="left">adm_ae_dis_date_time
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-01-28 01:38:00
med : 2016-07-25 19:20:00
max : 2018-12-29 16:05:00
range : 6y 11m 1d 14H 27M 0S</td>
      <td align="left" style="vertical-align:middle">12783 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAKJJREFUaN7t2EEKgCAQhWGvUDdIb1D3v1ukCyVRyhlS438LFzJ8Cx0RNYa0ZGmI9dmSGQHmjitgnbGwp0qYH3ewebHVt4MWFhmwh0tvlTAP7GBgM2Bp78uxhPknlq2WBHN3BqyC2XhByrG0XoDll7YEy+rBwMDAwMD6YaXnURtWqAcDAwMDGw2rfhC8xVytHgwM7BssnGolLEyDjYFZlRjSkhMT2t5Q/BJ6mwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMiswMTowMFAnKSsAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDAhepGXAAAAAElFTkSuQmCC"></td>
      <td align="center">12898
(71.19%)</td>
      <td align="center">5220
(28.81%)</td>
    </tr>
    <tr>
      <td align="center">40</td>
      <td align="left">adm_theatre_direct
[numeric]</td>
      <td align="left">Mean (sd) : 1.7 (0.7)
min < med < max:
0 < 2 < 2
IQR (CV) : 0 (0.4)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1991</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">13.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">808</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">5.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">11686</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">80.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIUAAABQBAMAAADFB6uTAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAGFJREFUWMPt1rsNwCAMAFFGgA34jJD9d6MBIkhl48q56/0KI1mEQGd1VZK0OIz2zDAwMDD+a1jcU/Ggc0O3zd1oqlfFwMDAwDgNi5usHHdr1Ivy5w8jDwMDA8OLYXFP6a0DVJHo6BZYahIAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDBQJykrAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwIXqRlwAAAABJRU5ErkJggg=="></td>
      <td align="center">14485
(79.95%)</td>
      <td align="center">3633
(20.05%)</td>
    </tr>
    <tr>
      <td align="center">41</td>
      <td align="left">adm_trauma_team_date_time
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-10-27 03:15:00
med : 2015-12-23 10:45:30
max : 2018-12-21 09:00:00
range : 6y 1m 24d 5H 45M 0S</td>
      <td align="left" style="vertical-align:middle">1649 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcgMF4z+gAAAJRJREFUaN7t1cENgCAMhWFW0A3EDWT/3Uykl5qmEqzR4P8uvcCXlkNJifRkusyca7wz7Vg5sn0Jk/kE86ZtwNaqFFUGwuR5YrCqFDAXkydfQjC5/g52WiU3Md0nGNhvMP1leZja1zZm9WljVgEDAwN7DLM2WDfmKGDn7yUGkwIGBgYGBgYGBgYGBgYGBjYulkOSSE92VULFMpuBs5sAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDBQJykrAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwIXqRlwAAAABJRU5ErkJggg=="></td>
      <td align="center">1658
(9.15%)</td>
      <td align="center">16460
(90.85%)</td>
    </tr>
    <tr>
      <td align="center">42</td>
      <td align="left">adm_hospital_fall
[logical]</td>
      <td align="left">1. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1299</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">100.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAAAgCAQAAAA7g2tDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfkBxUJNyAwXjP6AAAAiUlEQVRo3u3ZMQrCMABAUSO9oKMndOwRdax1kvZD0b43JQRC+JAsGc8Le12PPsA/EDEgYmB6nzw8kF+7j2U8rZduR5/tR8yrmescEDEgYkDEgIgBEQMiBkQMiBgQMSBiQMSAiAERAyIGRAyIGBAxIGJAxICIgY/fvnnbLic3fDXv5zoHRAyIGHgBq0kF8n47YVkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzIrMDE6MDBQJykrAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMyKzAxOjAwIXqRlwAAAABJRU5ErkJggg=="></td>
      <td align="center">1299
(7.17%)</td>
      <td align="center">16819
(92.83%)</td>
    </tr>
    <tr>
      <td align="center">43</td>
      <td align="left">adm_ward_type
[numeric]</td>
      <td align="left">Mean (sd) : 1.1 (0.6)
min < med < max:
1 < 1 < 9
IQR (CV) : 0 (0.5)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">16142</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">89.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1896</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">10.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">69</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJIAAABQBAMAAAAAdTECAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAFVJREFUWMPt1bENwCAMRUFWYISEDcj+u9GQnujTRNwb4ArLskvRanfelNqT1kkkEon0Wdp3x2veEdI7tlyaW9BJJBKJ9E9p30cIhKOki0QikUgkLTYA/vkHeGjxS08AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDD2UCKfAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAwhw2aIwAAAABJRU5ErkJggg=="></td>
      <td align="center">18107
(99.94%)</td>
      <td align="center">11
(0.06%)</td>
    </tr>
    <tr>
      <td align="center">44</td>
      <td align="left">adm_orth_ward_date_time
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-05-16 23:30:00
med : 2016-05-31 15:16:00
max : 2018-12-29 16:05:00
range : 6y 7m 12d 16H 35M 0S</td>
      <td align="left" style="vertical-align:middle">15523 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAANBJREFUaN7t120OgyAMBmCuIDew3mC9/90GVIxzZIn09WPb25D+MPYJGqgYAqMnht4QkbHmwYtNqmPNt8PSM+IwG8SI5YhpbVlGYKqPkvXnsfTCcFgZbkzKnNyYNdSpSj5s6YT9mK1QFFbWwe0x244gzIYXe2kRPmyzd3zYppLYCZi1iNjsN7sxuyE2Ky/H1j3Vja3LiBGrewmHvZcR+3dsPj+BMPt847BmGTFixE7D8iEHhuWrxIh9N7b820CwD2XEiBEjRowYsUMwgURg9MQTApEOzqeFlRoAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDD2UCKfAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAwhw2aIwAAAABJRU5ErkJggg=="></td>
      <td align="center">15883
(87.66%)</td>
      <td align="center">2235
(12.34%)</td>
    </tr>
    <tr>
      <td align="center">45</td>
      <td align="left">adm_pre_frac_indoor
[numeric]</td>
      <td align="left">Mean (sd) : 1.4 (1.3)
min < med < max:
0 < 2 < 3
IQR (CV) : 3 (0.9)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4794</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">41.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">530</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">4.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2496</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">21.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3662</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">31.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAEsAAABoBAMAAABLWBBBAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAGRJREFUSMft07ENgDAMRNGMEG9AYIOw/24QKUik4LgujnW/foVl6VLy3Y7bOjtOmJjY+ozcguHyTNbuJNj9kComFpqRWzDc9Dm/K58PGRITC8fILRjO1Zyffh7Sq2JiYRi5Ba9dl5uQol0lcPEAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDD2UCKfAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAwhw2aIwAAAABJRU5ErkJggg=="></td>
      <td align="center">11482
(63.37%)</td>
      <td align="center">6636
(36.63%)</td>
    </tr>
    <tr>
      <td align="center">46</td>
      <td align="left">adm_pre_frac_outdoor
[numeric]</td>
      <td align="left">Mean (sd) : 1.2 (1.3)
min < med < max:
0 < 1 < 3
IQR (CV) : 3 (1)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">5384</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">47.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">783</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">6.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2033</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">18.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3082</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">27.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFQAAABoBAMAAACd/cokAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAGZJREFUWMPt1sEJwDAMQ1Gv4BHabNDuv1shhECgbeSbDV/ndwgCmZjVyilk0HZvc0Gh0Pi2XEgW2t99SLSXBYVCNRrYlgvJQtebty9rXlIoFPpLA9tyIVno629JKOujMygUGt9WlTxCd6vHrQb35AAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMPZQIp8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDCHDZojAAAAAElFTkSuQmCC"></td>
      <td align="center">11282
(62.27%)</td>
      <td align="center">6836
(37.73%)</td>
    </tr>
    <tr>
      <td align="center">47</td>
      <td align="left">adm_pre_frac_shop
[numeric]</td>
      <td align="left">Mean (sd) : 1 (1.3)
min < med < max:
0 < 0 < 3
IQR (CV) : 2 (1.3)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">6704</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">59.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">601</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">5.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1113</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">9.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2790</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">24.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGYAAABoBAMAAADx+5ghAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAGtJREFUWMPt1rENwCAMRFFWyAgkG5j9d4uQSBUkbHc+/av9ClMcbk0vdyTLPMMfw2AwZUymD65ICpi5Wg+a+dYYDEbPZPrAO17FfJUfMev/MQwGo2UyfeCaLWQ2F/HR/G9yw2AwAibTB0p5AV9v5SeTY8DlAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAw9lAinwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMIcNmiMAAAAASUVORK5CYII="></td>
      <td align="center">11208
(61.86%)</td>
      <td align="center">6910
(38.14%)</td>
    </tr>
    <tr>
      <td align="center">48</td>
      <td align="left">adm_pre_frac_number
[numeric]</td>
      <td align="left">Mean (sd) : 3.7 (3.9)
min < med < max:
0 < 3 < 92
IQR (CV) : 8 (1.1)</td>
      <td align="left" style="vertical-align:middle">12 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAFNJREFUaN7t10ENwDAMBEFTCIQ6DGr+3JJKRZD4OSvdd/4XoZNy94zbfmxWFQwGg8FgMBgMBoNdYd9LacP2XhgMBoPBYDAYDAaDwWAwWBeWLYVOWl+dK+cHd4l/AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAw9lAinwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMIcNmiMAAAAASUVORK5CYII="></td>
      <td align="center">11218
(61.92%)</td>
      <td align="center">6900
(38.08%)</td>
    </tr>
    <tr>
      <td align="center">49</td>
      <td align="left">adm_amts_pre_op_performed
[numeric]</td>
      <td align="left">Mean (sd) : 2.1 (1.3)
min < med < max:
1 < 2 < 9
IQR (CV) : 0 (0.6)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1817</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">12.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">12648</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">84.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">56</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">499</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">3.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIsAAABoBAMAAAAz5x7gAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAG9JREFUWMPt1rENwCAMBVFGIBvEsEHYf7dQkCaKkGK7QOau5zVIH1KiWeVJDk15MLWNYGBgYGD+M05brDq8CVNsne8L1wUDAwOzN+O0xWs9MGsxAgMDAwMThbEpsZn+K/BgartgYGBgYLSM0xbTdzc4oV9Ev/8ZSQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMPZQIp8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDCHDZojAAAAAElFTkSuQmCC"></td>
      <td align="center">15020
(82.9%)</td>
      <td align="center">3098
(17.1%)</td>
    </tr>
    <tr>
      <td align="center">50</td>
      <td align="left">adm_amts_pre_op
[numeric]</td>
      <td align="left">Mean (sd) : 47.2 (45)
min < med < max:
0 < 10 < 99
IQR (CV) : 89 (1)</td>
      <td align="left" style="vertical-align:middle">13 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAFdJREFUaN7t2bENgDAMRUGvEDYg2QD23w0JWwyQIKW51/vaXzhCM/XsbEsVNu43GAwGg8F2YkeN2z9YXl8wGAwGg8FgMBgMBoPBYDAYDAaDwb4H82KhmR4JJYVktBWgbAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMPZQIp8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDCHDZojAAAAAElFTkSuQmCC"></td>
      <td align="center">3449
(19.04%)</td>
      <td align="center">14669
(80.96%)</td>
    </tr>
    <tr>
      <td align="center">51</td>
      <td align="left">adm_amts_4at_d1
[numeric]</td>
      <td align="left">Mean (sd) : 0 (0.2)
min < med < max:
0 < 0 < 2
IQR (CV) : 0 (8.8)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4694</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">98.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">25</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">41</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKAAAABQBAMAAABsc2MHAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAE1JREFUWMPt1TEVACEQQ0EsYAEccP69XYMDUsDb+QKmSZHWlGjE2uD8Qi0gEAgEPgbGP6XHqgsOIBAIBALLgDGvMHj/ykAgEAgsC+qsH6obKBcuApFUAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAw9lAinwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMIcNmiMAAAAASUVORK5CYII="></td>
      <td align="center">4760
(26.27%)</td>
      <td align="center">13358
(73.73%)</td>
    </tr>
    <tr>
      <td align="center">52</td>
      <td align="left">adm_amts_4at_d1s
[numeric]</td>
      <td align="left">Mean (sd) : 0 (0.3)
min < med < max:
0 < 0 < 12
IQR (CV) : 0 (28.5)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4709</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">99.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAACwBAMAAAB+wqi4AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAHdJREFUaN7t1TERgEAQBMG3gIQDB+DfGwkO2GTrewR0Omsp1ZnrE68n1U0kEonEejH/mSNXkThEIpFIJFaJOXBvcYhEIpFIrBJzYJM4RCKRSCRuLubAJnGIRCKRSKwSc+De4hCJRCKRWCXmwCZxiEQikUisEvW/F0CrEtrdxSnvAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAw9lAinwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMIcNmiMAAAAASUVORK5CYII="></td>
      <td align="center">4719
(26.05%)</td>
      <td align="center">13399
(73.95%)</td>
    </tr>
    <tr>
      <td align="center">53</td>
      <td align="left">adm_amts_4at_d3
[numeric]</td>
      <td align="left">Mean (sd) : 0 (0.2)
min < med < max:
0 < 0 < 2
IQR (CV) : 0 (8.4)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4694</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">98.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">15</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">55</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKAAAABQBAMAAABsc2MHAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAFBJREFUWMPt1TEVwCAQBUEsRAKHA/DvjSYO8pu8mxUw7Y6hRBXrBdcJtYFAIBD4MzD+lCdWX3ACgUAgENgGjHmNwZphcAGBQCCwKxh/ir51AR7jKWToLQuvAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAw9lAinwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMIcNmiMAAAAASUVORK5CYII="></td>
      <td align="center">4764
(26.29%)</td>
      <td align="center">13354
(73.71%)</td>
    </tr>
    <tr>
      <td align="center">54</td>
      <td align="left">adm_amts_4at_d3s
[numeric]</td>
      <td align="left">Mean (sd) : 0 (0.3)
min < med < max:
0 < 0 < 12
IQR (CV) : 0 (27.9)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4701</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">99.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAADKBAMAAADUe4YfAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAIRJREFUeNrt1TERgEAQBEEsIOHAAfj3RkJGyCZb3yOg09k2pTpyveJ5p7qIRCKRSPyI+XPtuYrEIRKJRCKxSsyBa4tDJBKJRGKVmAObxCESiUQisUrMgWuLQyQSiURilZgDm8QhEolEIrFKzIFri0MkEolEYpWYA5vEIRKJRCJxcVH/ewBHc5+NBdCQlgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMPZQIp8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDCHDZojAAAAAElFTkSuQmCC"></td>
      <td align="center">4709
(25.99%)</td>
      <td align="center">13409
(74.01%)</td>
    </tr>
    <tr>
      <td align="center">55</td>
      <td align="left">adm_amts_4at_dx
[numeric]</td>
      <td align="left">Mean (sd) : 0 (0.2)
min < med < max:
0 < 0 < 2
IQR (CV) : 0 (7.7)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4694</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">98.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">35</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">51</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKAAAABQBAMAAABsc2MHAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAE1JREFUWMPt1TEVACEQQ0EsYAEccP69XYMDUsDb+QKmSZHWlGjE2uD8Qi0gEAgEPgbGP6XHqgsOIBAIBALLgDGvMHj/ykAgEAgsC+qsH6obKBcuApFUAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAw9lAinwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMIcNmiMAAAAASUVORK5CYII="></td>
      <td align="center">4780
(26.38%)</td>
      <td align="center">13338
(73.62%)</td>
    </tr>
    <tr>
      <td align="center">56</td>
      <td align="left">adm_amts_4at_dxs
[numeric]</td>
      <td align="left">Mean (sd) : 0 (0.4)
min < med < max:
0 < 0 < 12
IQR (CV) : 0 (18.4)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4707</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">99.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAADKBAMAAADUe4YfAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAIRJREFUeNrt1TERgEAQBEEsIOHAAfj3RkJGyCZb3yOg09k2pTpyveJ5p7qIRCKRSPyI+XPtuYrEIRKJRCKxSsyBa4tDJBKJRGKVmAObxCESiUQisUrMgWuLQyQSiURilZgDm8QhEolEIrFKzIFri0MkEolEYpWYA5vEIRKJRCJxcVH/ewBHc5+NBdCQlgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMPZQIp8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDCHDZojAAAAAElFTkSuQmCC"></td>
      <td align="center">4728
(26.1%)</td>
      <td align="center">13390
(73.9%)</td>
    </tr>
    <tr>
      <td align="center">57</td>
      <td align="left">adm_fracture_side
[numeric]</td>
      <td align="left">Mean (sd) : 1.5 (0.5)
min < med < max:
1 < 1 < 3
IQR (CV) : 1 (0.3)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">9131</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">50.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">8799</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">49.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">18</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFkAAABQBAMAAACAKsRUAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAE5JREFUSMdjYBi6QIkooABVrWxMDBhVPap6VDVlqknLl4JEAYFBp5ooT8JVExOCRqOqR1WPqqaratJy8eApfUhTrTiqelT1qOohrnooAgCFBoZ+UGFBJwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMPZQIp8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDCHDZojAAAAAElFTkSuQmCC"></td>
      <td align="center">17948
(99.06%)</td>
      <td align="center">170
(0.94%)</td>
    </tr>
    <tr>
      <td align="center">58</td>
      <td align="left">adm_fracture_type
[numeric]</td>
      <td align="left">Mean (sd) : 2.7 (2)
min < med < max:
1 < 3 < 9
IQR (CV) : 2 (0.8)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">6577</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">36.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1942</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">10.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">6518</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">36.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1236</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">6.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">302</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">385</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1005</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">5.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAEMAAACwBAMAAACm4s73AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAIJJREFUWMPt1cEJwCAUA1BHaDaoukG7/26FUg89pP6D2AjJ+YF8iCQlrRSe/SH1pDEx+Y8EuguebShpD2dO2kUmJlIk0F3wTCeeLJNVidxk5U9yX2RisiAJ1Bs8g79a7pJqYqJIAt0FdEgp/aMPExNBEuguMInw9XyNsImJHAl0VyUXlcD8f3E6ZFAAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDD2UCKfAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAwhw2aIwAAAABJRU5ErkJggg=="></td>
      <td align="center">17965
(99.16%)</td>
      <td align="center">153
(0.84%)</td>
    </tr>
    <tr>
      <td align="center">59</td>
      <td align="left">adm_fracture_type_other
[character]</td>
      <td align="left">1. greater trochanter
2. GT
3. subcapital
4. Greater Trochanter
5. greater troch
6. GT #
7. displaced subcapital
8. # GT
9. impacted subcapital
10. Subcapital
[ 198 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">42</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">35</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">17</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">234</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">61.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGkAAAESBAMAAAAMPua/AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAALdJREFUaN7t1MENgzAQRFFKgA6C3QH031sOgIQ47YwUEe/+OfsdWKQ/TXnXzq1LZPOp+n4MhUJVVF43Qo8HVNIxnpdHoVAlldeN2Os3VfybHjdEoVBlldeNuBhLSce4XR6FQtVVXjcE8pJqzVF9Q6FQdZXXDcXQQxQKlVlR0bv6//+FQqF+p9L2cHVUR6FQhZXXDcWMpKgoCoVSVdaK0kMUCqWqrD30VJP2uS6/K0OhULmU142M+wLcvwILyF+D4AAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMPZQIp8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDCHDZojAAAAAElFTkSuQmCC"></td>
      <td align="center">379
(2.09%)</td>
      <td align="center">17739
(97.91%)</td>
    </tr>
    <tr>
      <td align="center">60</td>
      <td align="left">adm_fracture_type2
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">61</td>
      <td align="left">adm_fracture_type_other2
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">62</td>
      <td align="left">adm_pathological
[numeric]</td>
      <td align="left">Mean (sd) : 3.4 (1.6)
min < med < max:
1 < 3 < 9
IQR (CV) : 0 (0.5)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">338</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">324</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">15502</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">88.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1280</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">7.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJIAAABoBAMAAADoXLTCAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAG5JREFUWMPt1tsJgDAMQNGu4Ap1g7r/boKPby0JpeK5A5yPEpKWorfVukS7pLWRSCQSabyUt8fDzk8kl5NEIpG+Lbmco6Ua756CLVojkUgkUreUt8dnvFIzSuejZUjHFMT+UCQSiUTqlvL2uJ7bAWqjcrsQnjVLAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAw9lAinwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMIcNmiMAAAAASUVORK5CYII="></td>
      <td align="center">17444
(96.28%)</td>
      <td align="center">674
(3.72%)</td>
    </tr>
    <tr>
      <td align="center">63</td>
      <td align="left">adm_fragility
[numeric]</td>
      <td align="left">Mean (sd) : 2.3 (2)
min < med < max:
1 < 2 < 9
IQR (CV) : 0 (0.9)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4048</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">23.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">12070</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">68.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1401</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">8.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHQAAABQBAMAAAA6iUw0AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAFlJREFUWMPt1LEJACAMBdGs4AjqBrr/bhZaCRJItFDv6rwq8EX+Ks3FoDZorlNQKBS6izq2ST98hyZDq+foFSgUCj1NHbN23YS71z9aaH8OFAqFHqCObfqlBmIvxbxyAU/DAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAw9lAinwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMIcNmiMAAAAASUVORK5CYII="></td>
      <td align="center">17519
(96.69%)</td>
      <td align="center">599
(3.31%)</td>
    </tr>
    <tr>
      <td align="center">64</td>
      <td align="left">adm_pre_op_med_assess
[numeric]</td>
      <td align="left">Mean (sd) : 5.1 (2.2)
min < med < max:
1 < 6 < 9
IQR (CV) : 1 (0.4)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2725</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">15.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1287</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">7.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">80</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">761</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">4.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">11168</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">62.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">98</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1677</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">9.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">163</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGoAAADiBAMAAABU7E8RAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAJ9JREFUaN7t17EZgCAMhFFWcARhA91/Nxs+KSzMpTAY/qvzilAcUEre1JF9e09X7byDQqFQJuVrG8NksDJv9DxDFAq1qPL1hnk+TNlXQqFQqO+VhmhRFAqVV2ko6JetrNZVU97lKBQK5W4bQQSpqmWcoZADhUKlUr7e+EEfolAo1MRKQ4Gvyl1T/SZCoVBLKl9vGKcD1fx3CgqFWlllzAXkr3ExNua8YwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMPZQIp8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDCHDZojAAAAAElFTkSuQmCC"></td>
      <td align="center">17960
(99.13%)</td>
      <td align="center">158
(0.87%)</td>
    </tr>
    <tr>
      <td align="center">65</td>
      <td align="left">adm_ger_acute_assess
[numeric]</td>
      <td align="left">Mean (sd) : 1.3 (1)
min < med < max:
0 < 1 < 9
IQR (CV) : 1 (0.8)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1991</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">12.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">8173</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">50.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">5912</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">36.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">173</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFgAAABoBAMAAACHwSqqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAGBJREFUWMPt1LENwCAMRFFWYAScDWD/3WhIk0gWhyhs6f/6VZbOpeTM3lp1WvgZKzAYfAtLG6xbxcK21fd0Xh0MBgtY2mCQv3HrybQfdk4HBoPPsLRBad1BsIHB4Dw4WxOts7dCTb4nVgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMPZQIp8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDCHDZojAAAAAElFTkSuQmCC"></td>
      <td align="center">16249
(89.68%)</td>
      <td align="center">1869
(10.32%)</td>
    </tr>
    <tr>
      <td align="center">66</td>
      <td align="left">adm_ger_acute_assess_date_time
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">67</td>
      <td align="left">adm_ger_grade
[numeric]</td>
      <td align="left">Mean (sd) : 2.4 (2.3)
min < med < max:
1 < 1 < 9
IQR (CV) : 2 (1)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">6400</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">58.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1181</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">10.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1835</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">16.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1044</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">9.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">60</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">450</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">4.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGQAAACYBAMAAADgnFEFAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAIZJREFUWMPt1sENgCAMhWFWYARkA91/NxMjB73Y1wMU/N+5X0KatCWltbIJuUk9zNkhEEhQ4pj9LKQrae8sdtI6BoFA/kUc68JQOYY89rTWsesaQCCQOYlj9rOQ6ETY4q8mQyCQmYlj9i2lQ8jX6oZAIBA/EUT3L1wRSTUeCggEEpg4Zn+VnLEVbHeMQcT5AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAw9lAinwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMIcNmiMAAAAASUVORK5CYII="></td>
      <td align="center">10970
(60.55%)</td>
      <td align="center">7148
(39.45%)</td>
    </tr>
    <tr>
      <td align="center">68</td>
      <td align="left">adm_operation
[numeric]</td>
      <td align="left">Mean (sd) : 7.5 (12.5)
min < med < max:
0 < 5 < 99
IQR (CV) : 9 (1.7)</td>
      <td align="left" style="vertical-align:middle">16 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAGVJREFUaN7t2bENgDAMAEGvwAiEDfD+u5GCIrRxJFLc9z7JhStHaKbWO8q92JV5w2CwZVg/z3MZlpkwGAwGg8FgMBgMBoPBYDAYDAaDwWD/YcXP5Bcr/mXq2LBNHRtmtsfakkIzPR9ZOlzoNJSMAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAw9lAinwAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMIcNmiMAAAAASUVORK5CYII="></td>
      <td align="center">18040
(99.57%)</td>
      <td align="center">78
(0.43%)</td>
    </tr>
    <tr>
      <td align="center">69</td>
      <td align="left">adm_implant_type_fx_intracaps
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">70</td>
      <td align="left">adm_implant_type_fx_intertroc
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">71</td>
      <td align="left">adm_implant_type_fx_perip
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">72</td>
      <td align="left">adm_asa_grade
[numeric]</td>
      <td align="left">Mean (sd) : 3.1 (1.8)
min < med < max:
1 < 3 < 9
IQR (CV) : 1 (0.6)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">628</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">3.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">6219</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">36.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">7992</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">46.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">906</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">5.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">21</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1357</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">7.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFMAAACYBAMAAABqs8hEAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAH9JREFUWMPt10EKgDAMRNEewd7AxBvo/e8mol1JSYJUDfxZv1VghraUXFHVamS66LKtUCjUSwPdstxwqv3I7QLdQKHQBzRQwz9PRstsX6AFCoU2GujW5zsQnAzx0eNYUCjUSQPdqnbGUoFCoYmoLV/5bYiHnu8sKBTqooFuZckOxcwjOvWZh40AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDD2UCKfAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAwhw2aIwAAAABJRU5ErkJggg=="></td>
      <td align="center">17123
(94.51%)</td>
      <td align="center">995
(5.49%)</td>
    </tr>
    <tr>
      <td align="center">73</td>
      <td align="left">adm_anaesthesia
[numeric]</td>
      <td align="left">Mean (sd) : 4.4 (1.7)
min < med < max:
1 < 5 < 9
IQR (CV) : 0 (0.4)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2280</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">13.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1167</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">6.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">497</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">30</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">9787</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">57.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3054</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">17.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">56</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">127</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">46</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGMAAADiBAMAAACo+WTbAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAJ1JREFUaN7t18ENgCAMhWFGkA1EN8D9d/OiJMQDL02EUP537ndoE5oSgq8cJSk2sj3kvN5AIJCViGFdtOqGEa2N78QgEMjcxPD2peIRRG2kmhgEAlmRGNaFWt+dyJ1AIJDViS5GfEW17GXzy4FAII6IYV1MsvokUk0sQyCQKYnh7Uc9fUmCQCCQ34guep9wEAgEohFdcMJBIBA3xEtuCr9M3BENW9gAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDD2UCKfAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAwhw2aIwAAAABJRU5ErkJggg=="></td>
      <td align="center">17044
(94.07%)</td>
      <td align="center">1074
(5.93%)</td>
    </tr>
    <tr>
      <td align="center">74</td>
      <td align="left">adm_surgeon_grade
[numeric]</td>
      <td align="left">Mean (sd) : 1.7 (1)
min < med < max:
1 < 1 < 9
IQR (CV) : 1 (0.6)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">8506</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">52.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4570</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">28.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2905</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">17.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">115</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">89</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFsAAACYBAMAAAB5ZIiwAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAHNJREFUWMPt1MEJgDAMRuGOYDawdQPdfzcvXoSKf6DEVN47f4cQSEqZu6a1Xnw7pOBw+GjuvFXTWkJ4d9L6yLubgcPh6bjztE3ri7f0ym+b2eFweBh33qpppeQNDof/kWs6iFc4HA7P9ZZSPWw4HD6Kz9oJVjtIkJsfA3UAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDD2UCKfAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjMzKzAxOjAwhw2aIwAAAABJRU5ErkJggg=="></td>
      <td align="center">16187
(89.34%)</td>
      <td align="center">1931
(10.66%)</td>
    </tr>
    <tr>
      <td align="center">75</td>
      <td align="left">adm_surg_present_op_room
[numeric]</td>
      <td align="left">Mean (sd) : 0.8 (1.7)
min < med < max:
0 < 0 < 9
IQR (CV) : 1 (2.2)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4694</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">58.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2493</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">31.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">515</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">6.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">300</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGQAAABoBAMAAAD1DkgcAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTchR1kDbAAAAGlJREFUWMPt07ENwDAIRFFWYIQkGzj772Y5SpHGEVAB+lfzCk46kV45HXnJdZszIBBIUhLYvjqSnWw+PX7IpmQIBFKJBLavjmQnz7M+skoeEAikNgls33hdgtif/5RsrRgCgaQlge13yQT2dtwfxbzbbAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozMyswMTowMPZQIp8AAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzMrMDE6MDCHDZojAAAAAElFTkSuQmCC"></td>
      <td align="center">8002
(44.17%)</td>
      <td align="center">10116
(55.83%)</td>
    </tr>
    <tr>
      <td align="center">76</td>
      <td align="left">adm_anaesthetist_grade
[numeric]</td>
      <td align="left">Mean (sd) : 1.6 (1.8)
min < med < max:
1 < 1 < 9
IQR (CV) : 0 (1.1)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">13087</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">82.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">643</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">4.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1209</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">7.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">274</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">7</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">728</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">4.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIcAAACYBAMAAAA8Sed3AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAJdJREFUaN7t18sNgCAQhGFK0A58dKD99yZRD2I47azJuvnnzpcAycCWQnpZlEw3su5CQEBAQPIiLh07KhnCIXVns4zU2wEBAQEB+QhxKWozEBO5XmYROb8WGwgICAjIC3HpWOPy1IjwnD+uGAQEBASkh7h0rEBERJQjAQEBAQH5C6IYARFhFm3mYutUDAICApIZcelY0uYAx2EXVnJJ2+oAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDAz9xwRAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM0KzAxOjAwQqqkrQAAAABJRU5ErkJggg=="></td>
      <td align="center">15948
(88.02%)</td>
      <td align="center">2170
(11.98%)</td>
    </tr>
    <tr>
      <td align="center">77</td>
      <td align="left">adm_ana_present_op_room
[numeric]</td>
      <td align="left">Mean (sd) : 0.5 (1.8)
min < med < max:
0 < 0 < 9
IQR (CV) : 0 (3.3)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4694</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">81.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">636</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">11.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">167</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">238</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">4.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIcAAABoBAMAAAAp2/5uAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAHJJREFUWMPt1rENwDAIRFGPkGwQhxG8/25p7AIp1UF1+tfzCpBOjEH+8lbybCRWISAgICC+SEvH3pVcnsjZ0awg58QgICAgIAlp6Vhl1h0RV5qR0I4LAgIC4o60dKwu+CLqQ5CQEF8TEBAQEHOkpWNJzgdyN1APOCFt4gAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMDP3HBEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDBCqqStAAAAAElFTkSuQmCC"></td>
      <td align="center">5735
(31.65%)</td>
      <td align="center">12383
(68.35%)</td>
    </tr>
    <tr>
      <td align="center">78</td>
      <td align="left">adm_primary_surgery_date_time
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-06-26 12:00:00
med : 2016-05-20 02:23:30
max : 2018-12-30 15:47:00
range : 6y 6m 4d 3H 47M 0S</td>
      <td align="left" style="vertical-align:middle">16458 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAM5JREFUaN7t1tENwyAMBFBWiDco2SDef7dCXUFSFUWY+4jg7ieJ5DwhMIgQGE82Z2JK/RrEdtVjHSzN3AuGpQcIS8MCYKYcqgrA9o8yiom1Kggr005sDsw6FoQZ0YnJ90TAYGqFJfmkHsfyGMveHsbKj5NitqAgzGofil26qxOrfS/nv5zYeQ3nxmwrRgx2qSVGbB1MfjbRGPandjascZXox6R9lXBg7VpiS2G5P2FYfiNGjBgxYsSIebB6x0Zgt7XEiBEjRuwpWIQkMJ68AZoONT3epnJaAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM0KzAxOjAwM/ccEQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMEKqpK0AAAAASUVORK5CYII="></td>
      <td align="center">17226
(95.08%)</td>
      <td align="center">892
(4.92%)</td>
    </tr>
    <tr>
      <td align="center">79</td>
      <td align="left">adm_surgery_delay_reason
[numeric]</td>
      <td align="left">Mean (sd) : 1.1 (2.3)
min < med < max:
0 < 0 < 9
IQR (CV) : 1 (2.1)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">12739</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">74.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">201</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2018</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">11.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">53</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">575</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">3.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">14</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">55</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">402</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">797</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">4.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">257</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHwAAAD6BAMAAACR2T5IAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAL1JREFUaN7t2zEOwjAQBMB8gSck/kH4/99oIIIKZU8Kxp7tp3Czp9PJyzJ3tjBP3u5RdhzH8Ut5setuYUbg21riDcdx/B94sesy3Ak/Zl7GXwN6x3Ec75kXu+6kGoqvOI7j+Dce6j74+eH4wdvp0YzjOP4DXuy6yA7CVxzHcfwbD3UfvPh2HMfxGXioh+DhInXscdkah+M4fi0vdl2GO+HB7fydt/OXexzH8et5sesSOgr3dwDH8Rl4setmzQPqpEvuGu3HQwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMDP3HBEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDBCqqStAAAAAElFTkSuQmCC"></td>
      <td align="center">17111
(94.44%)</td>
      <td align="center">1007
(5.56%)</td>
    </tr>
    <tr>
      <td align="center">80</td>
      <td align="left">adm_opt_extra_delay_reason_other
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">81</td>
      <td align="left">adm_mobilised
[numeric]</td>
      <td align="left">Mean (sd) : 1.1 (0.9)
min < med < max:
0 < 1 < 9
IQR (CV) : 0 (0.8)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1991</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">12.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">10281</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">66.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3046</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">19.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">103</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHAAAABoBAMAAADbS2mOAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAGJJREFUWMPt10EKABAURVFbsAV2wP73ZiLF6Pkpfe4dOyP1JIQ/SqMo1mGuvQIEAoEyNG+OetwzTNut16FWgEAg0L45jnb11CDrcL4O5ZEEAoFA++YIJ91D+dcABAKBN+HrNfDJA7P3ol1AAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM0KzAxOjAwM/ccEQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMEKqpK0AAAAASUVORK5CYII="></td>
      <td align="center">15421
(85.11%)</td>
      <td align="center">2697
(14.89%)</td>
    </tr>
    <tr>
      <td align="center">82</td>
      <td align="left">adm_mobilised_by
[numeric]</td>
      <td align="left">Mean (sd) : 1.2 (1.5)
min < med < max:
0 < 1 < 9
IQR (CV) : 0 (1.3)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1991</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">16.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">9796</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">79.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">554</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">4.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">3</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIMAAABoBAMAAAAgMF4UAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAG9JREFUWMPt1ssJwCAQRVFLiB34KSH99+bCQIS4eTIQP/fu52yEGZ2jttQUvdT1EPl+g4CAgDiCMNid2tTeRBovdB5VDAICAmJNwmB3znEE5iD0g/4hsvytgICAgFicMNidg+NbEhECAgIC4g+CagV9rER/6ulTNwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMDP3HBEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDBCqqStAAAAAElFTkSuQmCC"></td>
      <td align="center">12344
(68.13%)</td>
      <td align="center">5774
(31.87%)</td>
    </tr>
    <tr>
      <td align="center">83</td>
      <td align="left">adm_physio_assess
[numeric]</td>
      <td align="left">Mean (sd) : 0.7 (0.8)
min < med < max:
0 < 1 < 9
IQR (CV) : 1 (1.1)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4694</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">40.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">5630</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">48.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1174</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">10.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">45</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFYAAABoBAMAAACZCBoZAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAF5JREFUWMPt1LENACEMBEFacAkPHfD994aEnAJnIiPtxhNZOpfyXnWfzdy2f1fHYrEHG9mbKSWyVUm6mV8Oi8UubWRvGf7DzS9RrN+sY7HYOxvZmyklsh8Wi01pX2oAD16zV94SQ78AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDAz9xwRAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM0KzAxOjAwQqqkrQAAAABJRU5ErkJggg=="></td>
      <td align="center">11543
(63.71%)</td>
      <td align="center">6575
(36.29%)</td>
    </tr>
    <tr>
      <td align="center">84</td>
      <td align="left">adm_amb_number_post_op
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">85</td>
      <td align="left">adm_re_op_30_days
[numeric]</td>
      <td align="left">Mean (sd) : 0.1 (0.8)
min < med < max:
0 < 0 < 9
IQR (CV) : 0 (8.2)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">15290</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">97.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">60</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">72</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">9</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">56</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">14</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">9</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">8</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">21</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">85</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJ8AAAD6BAMAAABNDIg6AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAJxJREFUeNrt1UEVgwAMBUEkFAcNSMC/Ny510H9IXmYFzHWPQ4muVN8feD+hgEAgEDgNjD/lTPXZCxYQCAQCgV3BlDcILCAQCAQCu4IpbzNYQCAQCAR2BVPeILCAQCAQCOwKprzNYAGBQCAQ2BVMeYPAAgKBQCCwK5jyNoMFBAKBQGBXMOUNAgsIBAKBwK5gytsMXkAgEAgEdgX1Xy+DyHJ71ea+SgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMDP3HBEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDBCqqStAAAAAElFTkSuQmCC"></td>
      <td align="center">15624
(86.23%)</td>
      <td align="center">2494
(13.77%)</td>
    </tr>
    <tr>
      <td align="center">86</td>
      <td align="left">adm_operation2
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">40.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">60.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGYAAAA4BAMAAAD9dZDWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAEBJREFUSMdjYBh+QAkvUBREAVA9ysb4wKieUT2jekaSHnLKEEFSwBDQo0QKICqsUYHRqJ5RPaN6hrUecsqQ4QQAtbRfemRMtK4AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDAz9xwRAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM0KzAxOjAwQqqkrQAAAABJRU5ErkJggg=="></td>
      <td align="center">15
(0.08%)</td>
      <td align="center">18103
(99.92%)</td>
    </tr>
    <tr>
      <td align="center">87</td>
      <td align="left">adm_pressure_ulcers
[numeric]</td>
      <td align="left">Mean (sd) : 2 (0.8)
min < med < max:
0 < 2 < 9
IQR (CV) : 0 (0.4)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">694</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">3.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">16869</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">94.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">211</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJsAAABoBAMAAAAUSZ8IAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAGtJREFUaN7t1rENgDAQBEGXAB1gU4L7740QQgQXWPZsARO9dF+K/lT3SBsOh8PhcC+5jLYm11qrQe7sHYfD4XCzceGtCFDLci3TcR9KIhwOh8ONxIW3YuxhHJuL/E+P/w6Hw+Fw83HhrdC3LsTnk6epycmlAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM0KzAxOjAwM/ccEQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMEKqpK0AAAAASUVORK5CYII="></td>
      <td align="center">17775
(98.11%)</td>
      <td align="center">343
(1.89%)</td>
    </tr>
    <tr>
      <td align="center">88</td>
      <td align="left">adm_spec_falls_assess
[numeric]</td>
      <td align="left">Mean (sd) : 0.6 (0.5)
min < med < max:
0 < 1 < 2
IQR (CV) : 1 (0.9)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">7812</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">44.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">9724</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">54.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">211</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAF8AAABQBAMAAACNNLQTAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAFVJREFUSMft1LsRABAQRVEl0IFPCfrvTYB4vcgy9+YnYGZfCH9UrUqaxQVaNwIAADeBfNPpNMfAfPQun37rDgAAPAHkEXA4ZPryFRE0AADgGcg3/XoDhYeVoo20S+kAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDAz9xwRAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM0KzAxOjAwQqqkrQAAAABJRU5ErkJggg=="></td>
      <td align="center">17747
(97.95%)</td>
      <td align="center">371
(2.05%)</td>
    </tr>
    <tr>
      <td align="center">89</td>
      <td align="left">adm_bone_protect_med
[numeric]</td>
      <td align="left">Mean (sd) : 1.6 (1.5)
min < med < max:
0 < 1 < 5
IQR (CV) : 2 (1)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4495</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">25.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">6507</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">37.2%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2500</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">14.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1061</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">6.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1974</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">11.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">968</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">5.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAEQAAACYBAMAAACvwVLVAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAH5JREFUWMPt1bENwCAMRFFW8AjABrD/blEkohTEJxdEvuJ+/RpLhyiFq7ZXbbVIn1siIvkksF0DHSUN5F/0NEREmElg3hlPzSPvRUNEhIcEtmuglKeGSf88V0QkmQS2a6B/vix80XSuEhFhJoF5G+j4U6uY3BeJiNCRwHZZugC3ONWsQYUC4gAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMDP3HBEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDBCqqStAAAAAElFTkSuQmCC"></td>
      <td align="center">17505
(96.62%)</td>
      <td align="center">613
(3.38%)</td>
    </tr>
    <tr>
      <td align="center">90</td>
      <td align="left">adm_multi_rehab_assess
[numeric]</td>
      <td align="left">Mean (sd) : 1.1 (0.6)
min < med < max:
1 < 1 < 9
IQR (CV) : 0 (0.5)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">16100</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">91.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1492</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">8.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">80</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJUAAABQBAMAAADiqSp7AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAFlJREFUWMPt1UERgDAMRcFKAAcUJNS/Nw5FAJ1+LnSfgD1kMkkpGu0MdDzW1eZjsVgs1jdW8t7vgbaFrD69GrH6TrBYLBbr71byd0whC1qVxWKxWKxBS++7AQJbEKtgDP0+AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM0KzAxOjAwM/ccEQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMEKqpK0AAAAASUVORK5CYII="></td>
      <td align="center">17672
(97.54%)</td>
      <td align="center">446
(2.46%)</td>
    </tr>
    <tr>
      <td align="center">91</td>
      <td align="left">adm_amb_number_acu_dis
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">92</td>
      <td align="left">adm_discharged_to
[numeric]</td>
      <td align="left">Mean (sd) : 2.3 (2.5)
min < med < max:
0 < 1 < 8
IQR (CV) : 4 (1.1)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4694</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">39.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1498</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">12.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">132</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">1.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2174</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">18.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1035</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">8.8%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">423</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">3.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">990</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">8.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">835</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">7.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAEgAAADKBAMAAAD0uxunAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAJlJREFUWMPt1lEKgCAQhGGvsEcwb1D3v1sEURA57kPiGv88fxDGzmpKMbPInKhsIisIND9yFcFkPkf39wW6TreCQNMh14ybzKBygkCggZfi29J4rp7X9QMChUauGTeZoeXUqNQfBSBQdOSacZPp0bs2KtWTgUDhkWvGTWbkpZhbv+AICDQlcs24yfTpXW6gog4HAv0AuYoQLTvbc0m+ARbnVwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMDP3HBEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDBCqqStAAAAAElFTkSuQmCC"></td>
      <td align="center">11781
(65.02%)</td>
      <td align="center">6337
(34.98%)</td>
    </tr>
    <tr>
      <td align="center">93</td>
      <td align="left">adm_dis_to_other
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">94</td>
      <td align="left">adm_case_complete
[numeric]</td>
      <td align="left">Min : 1
Mean : 1.1
Max : 2</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">17046</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">94.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">916</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">5.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJsAAAA4BAMAAAAYx5f/AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAE1JREFUWMPt1bEJACAMRNGMoBsE3UD3380I1hZ6lf4/wCtC4MzopqLJF1e7JDg4ODi4hznx9GRN6Udu3lHIxaM0ODg4ODi4HSeeHjprAGRPtVrtzMYYAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM0KzAxOjAwM/ccEQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMEKqpK0AAAAASUVORK5CYII="></td>
      <td align="center">17962
(99.14%)</td>
      <td align="center">156
(0.86%)</td>
    </tr>
    <tr>
      <td align="center">95</td>
      <td align="left">adm_nut_risk
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">96</td>
      <td align="left">adm_nerve_block
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">97</td>
      <td align="left">adm_bone_protect_med_change
[logical]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">98</td>
      <td align="left">bb1_start
[POSIXct, POSIXt]</td>
      <td align="left">min : 2007-05-04 17:30:00
med : 2016-05-27 10:29:00
max : 2100-01-01
range : 92y 7m 27d 6H 30M 0S</td>
      <td align="left" style="vertical-align:middle">17896 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAF1JREFUaN7t2MEJgEAMRcG0sHZgLMH+ezOCB/G40YvMK2DI7UMiNNOolqzW0eiO7RUMBoPBYD/HWtv5xLbOdTAYDAaDwWAwGAwGg8FgMBgMBoN9i50/8bywfKXQTAcKrz87UbYL/gAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMDP3HBEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzQrMDE6MDBCqqStAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">99</td>
      <td align="left">bb2_start
[POSIXct, POSIXt]</td>
      <td align="left">min : 2007-05-04 17:30:00
med : 2016-05-23 18:56:00
max : 2100-01-01
range : 92y 7m 27d 6H 30M 0S</td>
      <td align="left" style="vertical-align:middle">17930 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTci3lBS1gAAAFxJREFUaN7t2TERgEAMRcFYOBwQJODfG2GGAui4UO4TsJPqN4nQTKNaslpHozu2VzAYDPYNa83QG9s618FgMBgMBoPBYDAYDAaDwWAwGAwGg8EenY+cvLD8pdBMB6lyQ3PtOyENAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM0KzAxOjAwM/ccEQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNCswMTowMEKqpK0AAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">100</td>
      <td align="left">pres
[POSIXct, POSIXt]</td>
      <td align="left">min : 2007-05-04 17:30:00
med : 2016-05-30 10:59:00
max : 2018-12-29 14:27:00
range : 11y 7m 24d 20H 57M 0S</td>
      <td align="left" style="vertical-align:middle">16926 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAJ5JREFUaN7t2MsNgCAQRVFakA7UDpz+exOSSYiCGodZ+Ll3o6uzIOElGgJZGuxNKX3tx2aR5SdYOrbRDRORL2MxHZYflhQwsH15yNwwVTox3VYfTBfsoVi54Q5YUcDA/oTF6h71YJVixbbb2ok1FTAwMLBmh6towo4UMDAwMDAwMLC3YfkjzQ3LDzCw52Dx5B/EfexCAQMDK9jkUiBLKzGuKKaRxZwwAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAwlYAXpQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMOTdrxkAAAAASUVORK5CYII="></td>
      <td align="center">17022
(93.95%)</td>
      <td align="center">1096
(6.05%)</td>
    </tr>
    <tr>
      <td align="center">101</td>
      <td align="left">time_to_ortho
[numeric]</td>
      <td align="left">Mean (sd) : 1444.1 (8719.7)
min < med < max:
0 < 505 < 439261
IQR (CV) : 631 (6)</td>
      <td align="left" style="vertical-align:middle">3005 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAEZJREFUaN7tzEERABAQAMCrIIITQf9uHi4BXmY3wEZwIktvNyobc5PJZDKZTCaTyWQymUwmk8lkMplMJpPJZDLZf1k+EZxYmCxJwfEu5VUAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">15793
(87.17%)</td>
      <td align="center">2325
(12.83%)</td>
    </tr>
    <tr>
      <td align="center">102</td>
      <td align="left">time_to_ortho_grp
[numeric]</td>
      <td align="left">1 distinct value</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">-1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">18118</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">100.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAAAgCAQAAAA7g2tDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfkBxUJNyOpV2JAAAAAiUlEQVRo3u3ZMQrCMABAUSO9oKMndOwRdax1kvZD0b43JQRC+JAsGc8Le12PPsA/EDEgYmB6nzw8kF+7j2U8rZduR5/tR8yrmescEDEgYkDEgIgBEQMiBkQMiBgQMSBiQMSAiAERAyIGRAyIGBAxIGJAxICIgY/fvnnbLic3fDXv5zoHRAyIGHgBq0kF8n47YVkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">103</td>
      <td align="left">time_to_surg
[numeric]</td>
      <td align="left">Mean (sd) : 3028.7 (9622)
min < med < max:
0 < 1690 < 445206
IQR (CV) : 1784.2 (3.2)</td>
      <td align="left" style="vertical-align:middle">5397 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAEZJREFUaN7tzEERACAIADAqGEGMQP9ufkyAvrwtwCLoyMw5rp1sVclkMplMJpPJZDKZTCaTyWQymUwmk8lkMpns0yyfCDo2rcgHBDXmVmcAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">17128
(94.54%)</td>
      <td align="center">990
(5.46%)</td>
    </tr>
    <tr>
      <td align="center">104</td>
      <td align="left">time_to_surg_grp
[numeric]</td>
      <td align="left">1 distinct value</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">-1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">18118</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">100.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAAAgCAQAAAA7g2tDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfkBxUJNyOpV2JAAAAAiUlEQVRo3u3ZMQrCMABAUSO9oKMndOwRdax1kvZD0b43JQRC+JAsGc8Le12PPsA/EDEgYmB6nzw8kF+7j2U8rZduR5/tR8yrmescEDEgYkDEgIgBEQMiBkQMiBgQMSBiQMSAiAERAyIGRAyIGBAxIGJAxICIgY/fvnnbLic3fDXv5zoHRAyIGHgBq0kF8n47YVkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">105</td>
      <td align="left">surg_day
[character]</td>
      <td align="left">1. Friday
2. Monday
3. Saturday
4. Sunday
5. Thursday
6. Tuesday
7. Unknown...
8. Wednesday</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2617</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">14.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2481</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2409</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2223</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2415</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2378</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">892</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2703</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">14.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAACMAAADKBAMAAADdvOQgAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAHdJREFUSMft09EJgDAMBNCOYDfQdINm/91EUALN/VSSInL3+T4ayDWlxEYs201Nn3TSYgJ1VMsc2VOHn0hKJbD71z2y2k9RZLX2VHUTSbkEds8T/QelnKj4z9RJqQR2H32iA7VrPCmfwO4DTlT28TOpkhYTqCMqJ446YNDeYNJuAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAwlYAXpQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMOTdrxkAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">106</td>
      <td align="left">surg_day_int
[numeric]</td>
      <td align="left">Mean (sd) : 3 (2)
min < med < max:
-1 < 3 < 6
IQR (CV) : 4 (0.7)</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">-1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">892</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">4.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">4632</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">25.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2481</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">13.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2378</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">13.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2703</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">14.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2415</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">13.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2617</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">14.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADMAAACwBAMAAABQq0tvAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAIBJREFUWMPt1bENwCAMRFFGCBsE2MDef7ekQKDYkYUUIIXv2te4+IgQ9i7fi88dlQozgRyT0UbU+0ZZ7+wXyoE8kdHG9A6HEk0vj6gO5JKMNhZ2qKhdSCDQcDYLE23vQT8iBnkko43pHQ4lmiQVdTvIFf3zm2dJ/UICeSSjjV27AHZEo7q+RxWqAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAwlYAXpQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMOTdrxkAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">107</td>
      <td align="left">surg_time
[character]</td>
      <td align="left">1. 1400
2. 1300
3. 1100
4. 1200
5. 1500
6. 1000
7. 1130
8. 1230
9. 1600
10. 1430
[ 713 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">605</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">550</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">549</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">532</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">521</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">404</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">400</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">399</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">391</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">377</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">12498</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">72.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHkAAAESBAMAAAArkGdXAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAKtJREFUeNrt18ENAjEMRcEtAToAbwek/964QAHYWinY4/ucIr2vHMfci4j773f76HO9aJqmN9O1riVoC20NaJrupqeugZ7TNN1NT+15TUc8C/pcNE3Tu+la1xJ0E63nNE1303N7XtFn5kNF0zS9sa5VMWP30NaApuluWs8z+n/fm6bpvnpqz2vaGtA03U1PXQM9p2m6m57a85qO1D2+L7YyR9M0faWudW3ivQGtsI28TZRhUQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMJWAF6UAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDDk3a8ZAAAAAElFTkSuQmCC"></td>
      <td align="center">17226
(95.08%)</td>
      <td align="center">892
(4.92%)</td>
    </tr>
    <tr>
      <td align="center">108</td>
      <td align="left">ward_4hrs
[numeric]</td>
      <td align="left">Min : 0
Mean : 0.1
Max : 1</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">15826</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">87.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">2292</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">12.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAI8AAAA4BAMAAAA2grZtAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAExJREFUSMdjYBgFxAAlSoEC1CBlYwrBqEGjBo0aNGrQqEF0M4hqhb8gpUBg+BuECDUKDYJHv9GoQaMGjRo0atCoQYPdIKoV/qMAPwAAtM2iOgCOiekAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">109</td>
      <td align="left">surgery_48hrs_mon_sun_8_6
[numeric]</td>
      <td align="left">Min : 0
Mean : 0.7
Max : 1</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">5927</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">32.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">12191</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">67.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHEAAAA4BAMAAAA4BwpHAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAEVJREFUSMdjYBg5QAkXEMQFBKA6lY2xA6NRnaM6R3WO6qSTTvJLMEGSwdDUqUQyUCAQK7jBqM5RnaM6R3VSVyf5JdhIAADDnXJqmAOLEQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMJWAF6UAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDDk3a8ZAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">110</td>
      <td align="left">pressure_ulcer
[numeric]</td>
      <td align="left">Min : 0
Mean : 0
Max : 1</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">17503</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">96.6%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">615</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">3.4%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJ0AAAA4BAMAAAAV2ee4AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAEpJREFUWMPt1TEVACAMA9FKAAc86oD691YGDADZeifgD1liRr9NUeN4Hprw8PDw8Gp56j/qolpRb08p9TwWHh4eHh7etaf+I3ovAQVWuIpYUniYAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAwlYAXpQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMOTdrxkAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">111</td>
      <td align="left">no_pressure_ulcer
[numeric]</td>
      <td align="left">Min : 0
Mean : 0.9
Max : 1</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">1809</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">10.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">16309</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">90.0%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJMAAAA4BAMAAAALENcLAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAE1JREFUWMPt1cENABAQRFEl0IGsDui/N4nsxQ27B+H/At5pkgmBdhItnReVKm1UoaCgoKDeoRxvwkB8R4m9PI/BEhQUFBTUZZTjTdBaHX8yqJqxZFIuAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAwlYAXpQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMOTdrxkAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">112</td>
      <td align="left">pre_op_assessment
[numeric]</td>
      <td align="left">Min : 0
Mean : 0.5
Max : 1</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">9945</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">54.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">8173</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">45.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAF8AAAA4BAMAAABpkzkkAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAD9JREFUSMdjYBgeQIlYoADVoGxMJBjVMKphVMOQ0EByISBILBAYvBoI+xZNA8FgNRrVMKphVMNQ0kByITDUAQAwNFW6aFTe3gAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMJWAF6UAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDDk3a8ZAAAAAElFTkSuQmCC"></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">113</td>
      <td align="left">bone_medication
[numeric]</td>
      <td align="left">Min : 0
Mean : 0.7
Max : 1</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">5600</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">30.9%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">12518</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">69.1%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHQAAAA4BAMAAADeLsEDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAERJREFUSMdjYBhZQAk7UBTEA6BalY2xglGto1pHtY5qHVCtFBRrgmSAoapViQyAP3LwAaNRraNaR7WOaqW1VgqKtZECAK4CdcpRXrCcAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAwlYAXpQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMOTdrxkAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">114</td>
      <td align="left">falls_assessment
[numeric]</td>
      <td align="left">Min : 0
Mean : 0.5
Max : 1</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">8599</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">47.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">9519</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">52.5%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFsAAAA4BAMAAABgeJleAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAENJREFUSMdjYBjaQIkIICgoKABVrmxMEBiNKh9VPqp84JWTmLUFiQODUjkxXgUCBeIDEgRGlY8qH1U+wMpJzNpDFQAATqZPWiEKgmwAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">115</td>
      <td align="left">tariff_total
[numeric]</td>
      <td align="left">Min : 0
Mean : 0
Max : 1</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">0</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">17448</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">96.3%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 0 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px;border:0;" align="left">:</td><td style="padding:0 4px 0 6px;margin:0;border:0" align="right">670</td><td style="padding:0;border:0" align="left">(</td><td style="padding:0 2px;margin:0;border:0" align="right">3.7%</td><td style="padding:0 4px 0 0;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJ0AAAA4BAMAAAAV2ee4AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAEpJREFUWMPt1TEVACAMA9FKAAc86oD691YGDADZeifgD1liRr9NUeN4Hprw8PDw8Gp56j/qolpRb08p9TwWHh4eHh7etaf+I3ovAQVWuIpYUniYAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAwlYAXpQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMOTdrxkAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">116</td>
      <td align="left">diag1
[character]</td>
      <td align="left">1. S7211
2. S7200
3. S7201
4. S7203
5. S722
6. S7210
7. S7204
8. S7208
9. S7205
10. S723
[ 250 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5496</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">30.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5389</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">29.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2296</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2156</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">833</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">487</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">328</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">200</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">173</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">54</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">706</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADoAAAESBAMAAABeHdv0AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAKRJREFUaN7t1ssJwzAURFG38EqQXgdW/71lYxIIk3Fs9AnhzvZsJHMF3rZ1q3qHZlPbUfREfVehN1z1oYq9EYqeqe9qRs9Kn2feUfSK+q58k+P09bDsjVD0kvquQq9Tz581398min6lvqvQ69JzMZoNRfurry70etRenCaK3lLfVcQorSg6XWOR/ubXQP9bY5gWFJ2usUir/uk/NFtD0Rvqu1qxByOLXCp0vPBGAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAwlYAXpQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMOTdrxkAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">117</td>
      <td align="left">diag2
[character]</td>
      <td align="left">1. W19
2. W011
3. W010
4. W189
5. W109
6. W069
7. W188
8. W079
9. X59
10. S5250
[ 770 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5288</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">29.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2315</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1451</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1424</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">653</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">592</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">576</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">331</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">228</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">212</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5030</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">27.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADgAAAESBAMAAABa6AvJAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAJtJREFUWMPt2cEJgDAQRFFb2BI0Haz99+ZBUWPWCQgmCn+u72CEj4gOQ59N4TZMczAHwQxlQxbuXTwOEeB+Kw6Ctygbep6mxPV6Y4zraUFQomzIwhE1+G3sEfXlyX89rYNgDWVDFo5uwW8jUYN/xD7dCkwOglWUDZm1x+JFPLsVEKyjbMjsFaRb8I/dSgz/vRRfuE9zEMxRNtR6C3dlS+s4FvdVAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAwlYAXpQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMOTdrxkAAAAASUVORK5CYII="></td>
      <td align="center">18100
(99.9%)</td>
      <td align="center">18
(0.1%)</td>
    </tr>
    <tr>
      <td align="center">118</td>
      <td align="left">diag3
[character]</td>
      <td align="left">1. U739
2. Y9209
3. Y929
4. Y9214
5. U732
6. W19
7. U738
8. Y9205
9. Y9201
10. Y9204
[ 606 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3393</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">18.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2952</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">16.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1983</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1234</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">752</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">655</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">602</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">474</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">462</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">455</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5122</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">28.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADcAAAESBAMAAACr41BEAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAKBJREFUWMPt0lEKgzAURFGX0LeDxuyg7n9vQpGicTJSakyFO7/n5z24w9Bn42Yp3nssmKf1QFCibSjUGqM4R78CghW0DTXuNinM5aUg+GVDtr5GuL+mfAUEPdqGQu2UblMV8/5WECzRNhRqp3Rbxzy9QPAntIGFGlGD/bFPt8ldC4KHaBsKNaIG/xx7RE234B27tTiqPT+viIHgFm1DV28GkS5J2H7zFj8AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">18084
(99.81%)</td>
      <td align="center">34
(0.19%)</td>
    </tr>
    <tr>
      <td align="center">119</td>
      <td align="left">diag4
[character]</td>
      <td align="left">1. U739
2. Y9209
3. Y929
4. U732
5. U738
6. Y9214
7. Y9222
8. Y9201
9. Y9205
10. Y9204
[ 490 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7728</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">42.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1898</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1698</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">920</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">683</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">630</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">293</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">277</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">273</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">266</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3389</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">18.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAE0AAAESBAMAAABKiEUVAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAKxJREFUaN7t2rENgDAMRFFGwBsQskHYfzcaKEBKfA2Khf/VryCRPlWWJf52Z9vl6jEeDvdHp/ZhztbJ7v5ez1330nC4TE7tw5x93G8Rz4vDpXJqH+Zsthv9g1730nC4bE7tw5x92K/k6vi4ONwvndqHOaNfHC6uC9950VzF4RI6tQ+zOY5+cbi+i96v6ugch+u76J3TLw7Xd9H7Vd3zVUzpuue7Gxwuh1P7iLwT5boJb9vPqm0AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">18055
(99.65%)</td>
      <td align="center">63
(0.35%)</td>
    </tr>
    <tr>
      <td align="center">120</td>
      <td align="left">diag5
[character]</td>
      <td align="left">1. U739
2. N390
3. I10
4. D649
5. J22
6. F03
7. E119
8. I489
9. J189
10. Y9209
[ 1114 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1015</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">654</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">596</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">581</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">466</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">400</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">352</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">337</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">328</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">320</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10285</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">67.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHEAAAESBAMAAAA4RyejAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAALhJREFUaN7t18EJwkAQhtGUoB1o0oHbf29GUFDIZcaFIcz77+8yC1/IsvTZ+tr9GtjlLbexjyRJ8m+Z71DEnFlG7/PzKiRJkhNkvkMxVS31liTJatmlt3m5Xygpt/EgSZKcIPMdCrJiGf4gfd2WJElyhsx3KMiKpd6SJHle2afUWblFfzpIkiQPZb5DUae3JEn2ll16m5dKTZJktexSar0lSbJadultXq7h3T6vMqIjSZI8kvkOddgT6y5Ipg69aIwAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">15334
(84.63%)</td>
      <td align="center">2784
(15.37%)</td>
    </tr>
    <tr>
      <td align="center">121</td>
      <td align="left">diag6
[character]</td>
      <td align="left">1. I10
2. N390
3. D649
4. U739
5. I489
6. B962
7. J22
8. F03
9. J189
10. E119
[ 1167 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">703</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">416</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">372</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">299</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">283</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">273</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">266</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">261</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">240</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">224</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9513</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">74.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHsAAAESBAMAAAAvZbdqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAMJJREFUeNrt2jEOwjAQBMA8AX4AyQ/w//9GClAoyZ0U2b7ZfhqftNt4WWpn3fO8n87tw7fWGo7jePc82XXn5Tx8f7kM39oLx3G8f57suojthocG8vflcRzHB+DJrovYWXhsIY/DhfYZx3H8Yp7suhDuhet5HMcrcD0f5kPfHcdx/E9uJsJ86LvjOF6H6/kwH/ruOI7X4ZV7PsnNBI7jFXjlmYj9kzpeHsdxfASe7LoQnoSvsTy+h2uh4DiOX8uTXVc1bwDjoMm25xW9AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAwlYAXpQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNSswMTowMOTdrxkAAAAASUVORK5CYII="></td>
      <td align="center">12850
(70.92%)</td>
      <td align="center">5268
(29.08%)</td>
    </tr>
    <tr>
      <td align="center">122</td>
      <td align="left">diag7
[character]</td>
      <td align="left">1. I10
2. D649
3. N390
4. Y831
5. Y9222
6. Z8643
7. I489
8. U739
9. Z720
10. B962
[ 1062 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">502</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">292</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">278</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">251</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">220</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">216</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">206</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">206</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">192</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">190</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7905</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">75.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAH4AAAESBAMAAADJTHwuAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAK9JREFUeNrt17ENwzAQBEG1oBJMdSD235sdWHD+F1Dyz+UTPbAEt83GZ3tlX3/MefI8zz/Rp/0r2T/yY7wif0ye5/ln+rR/NXwfr/88z3f13fuf+uLv63e/2u+P53l+uU/7V9S38frP83xXr/+ZX30/nuf5Vd77kfnV9+N5nq96/c/86vvxPM9Xfff+p977wfN8V9/9/dB/nue7+u79T/2o7rrfrO3keZ5f7NP+dd4b7Dq2BwFZFaMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">10458
(57.72%)</td>
      <td align="center">7660
(42.28%)</td>
    </tr>
    <tr>
      <td align="center">123</td>
      <td align="left">diag8
[character]</td>
      <td align="left">1. Y9222
2. I10
3. D649
4. N390
5. Z720
6. Z8643
7. Y831
8. F03
9. I489
10. U739
[ 930 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">377</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">364</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">229</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">184</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">181</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">179</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">160</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">159</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">147</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">134</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6272</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">74.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAH0AAAESBAMAAAAie8ctAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcjqVdiQAAAAMFJREFUeNrt2bENwjAUBNCMABtA2ADvvxspQKS+X9iO3/WviE+6yPK2yX7kHuT29a/W3jzP8zP66v4l9kr+OL5nxR/98TzPT+mr+5fYkXz4+afz53men9NX9y/CF/LZ7evUX3T743me7++r+5fpcbz953l+VW//a753fzzP8728/0fN9+6P53k+9fa/5nv3x/M8n/rV97/qw+f7f388z/OT+ur+ZXocb/95nl/Vr77/Vb+Hefz6a1l4nud7++r+rZwPCJyz1hK6NOQAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzUrMDE6MDCVgBelAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM1KzAxOjAw5N2vGQAAAABJRU5ErkJggg=="></td>
      <td align="center">8386
(46.29%)</td>
      <td align="center">9732
(53.71%)</td>
    </tr>
    <tr>
      <td align="center">124</td>
      <td align="left">diag9
[character]</td>
      <td align="left">1. I10
2. Y9222
3. Z8643
4. D649
5. Z720
6. N390
7. I489
8. F03
9. Y831
10. Z921
[ 832 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">264</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">260</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">167</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">152</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">148</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">147</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">139</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">125</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">115</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">100</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5072</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">75.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAH4AAAESBAMAAADJTHwuAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAALJJREFUeNrt2bEVgzAMQEFWYISIDfD+u9EkpJcKY3TqrwC991V420xEfPbMfP0xBs/z/JK+2r+UfZF3P3ie7+q734/s5///P8/z/Jq+2r8cfo+PqPnj5HmeX9NX+5fUj/H6z/N8V6//NT97fzzP87O8+1Hzs/fH8zyf9fpf87P3x/M8n/Xd+1/12ef7e388z/OL+mr/kvoxXv95nu/qu/e/6iM7v/2N3Jw8z/OTfbV/necCefa04NLGp24AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">6689
(36.92%)</td>
      <td align="center">11429
(63.08%)</td>
    </tr>
    <tr>
      <td align="center">125</td>
      <td align="left">diag10
[character]</td>
      <td align="left">1. Y9222
2. I10
3. Z8643
4. N390
5. D649
6. I489
7. Z720
8. F03
9. Z7511
10. B962
[ 774 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">189</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">161</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">161</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">130</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">129</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">114</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">111</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">85</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">77</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">72</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4112</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">77.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIAAAAESBAMAAADHycAEAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAL1JREFUeNrt18EJAzEMBMBrwSWc3cG5/96SQBLylgwnnNm/5mGBFh+HvNJ7b7G8gTEvAAAA2AVI38Tg9FZA72cOGBMAAAC2AdI3MThdCdALAAAA0PTCSiD8afuuMfptBAAAgHpA+iZGxwsBegEAAACaXlj5BvevEQAAAOoAikWxAAAAwC+gF55vcCaBAQAAAPsA6ZsYHd8JUCwAAADQFMvKN7h/jQAAAKAXKgE9nM8aZzAXAAAAlAPSN/Hf8wDk7cPiKMuTcwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">5341
(29.48%)</td>
      <td align="center">12777
(70.52%)</td>
    </tr>
    <tr>
      <td align="center">126</td>
      <td align="left">diag11
[character]</td>
      <td align="left">1. I10
2. Y9222
3. Z8643
4. D649
5. Z720
6. N390
7. B962
8. I489
9. Z921
10. Z7511
[ 703 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">149</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">125</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">106</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">95</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">94</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">71</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">68</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">64</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">64</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">62</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3359</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">78.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIMAAAESBAMAAAAs/nsHAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAL5JREFUeNrt2sENwjAQRcGUAB0QuwPcf28cAClX766EQ+bfM4dE2ickts2Oa63dg7t9iD6eCAQCcS2i4HZGn/9HorU9S/SBQCAQFyMKbmf0+eUIHUEgEIh5QkeKU5QmevhnKgKBQJyUKLidYWA1QkcQCARintCRw7vY00RHIBAIxDRRcH7DwGqEFCEQCMQ8oSM6gkAgEBlCR6QIgUAgfkxIkY4gEAhEhtCR4j+ehff4ftQRHgKBQJyTKLid9t4Ls0HnnPFcLOEAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">4257
(23.5%)</td>
      <td align="center">13861
(76.5%)</td>
    </tr>
    <tr>
      <td align="center">127</td>
      <td align="left">diag12
[character]</td>
      <td align="left">1. I10
2. Z8643
3. Y9222
4. Z720
5. D649
6. N390
7. I489
8. U739
9. Z921
10. Z7511
[ 639 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">119</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">107</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">78</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">71</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">70</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">63</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">59</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">57</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">52</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">51</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2621</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">78.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIIAAAESBAMAAADDPBA5AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAKxJREFUeNrt1cENgCAMQFFWcARhA91/Ny9yJaY1RMnrve8ASX8ppk+tdQvOLbTzIBAIhIWF/J2Mrq8mKA6BQCCMBcXp75AVWvgrCAQC4Q9C/k6G9xcTFIdAIBDGguLoBYFAIDwR9EIvCAQCYY6gOPc77FmhEQgEwtJC/k6G9z8l6AWBQCCMBb1QHAKBQJgjKI5eEAgEwhNBL14rTnz6b57ROQgEAuEHQv5OmlIuaN7W0XaCOrcAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">3348
(18.48%)</td>
      <td align="center">14770
(81.52%)</td>
    </tr>
    <tr>
      <td align="center">128</td>
      <td align="left">diag13
[character]</td>
      <td align="left">1. I10
2. Z8643
3. Z720
4. D649
5. Y9222
6. Z515
7. K590
8. Z7511
9. N390
10. I489
[ 582 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">93</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">82</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">58</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">56</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">54</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">47</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">46</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">43</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">40</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">39</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2075</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">78.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIMAAAESBAMAAAAs/nsHAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAL5JREFUeNrt2r0NwjAQgNGMABsQewO8/24UgEjru5PIz7ver4il+1xkWcx2Wmv34Nw+RB9PBAKBuBZRsDuj589ItLZmiT4QCATiYkTB7oye3x0Rr/LvRsJvAwQCgTgoUbA7w8AJCSlCIBCIeUKKdASBQCAyhI5svsWaJjoCgUAgpomC9RsG9kZIEQKBQMwTOqIjCAQCkSF0RIoQCATiz4QU6QgCgUBkCB0p/vEsPI/vpY7wIBAIxDGJgt1p3vMCIwHmOdDh3OsAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">2633
(14.53%)</td>
      <td align="center">15485
(85.47%)</td>
    </tr>
    <tr>
      <td align="center">129</td>
      <td align="left">diag14
[character]</td>
      <td align="left">1. Z8643
2. I10
3. Z7511
4. Y9222
5. Z515
6. D649
7. I489
8. Z602
9. Z720
10. N390
[ 473 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">63</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">61</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">46</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">44</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">44</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">37</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">36</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">36</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">33</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">32</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1670</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">79.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIQAAAESBAMAAADOImB+AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAALtJREFUeNrt1bENwzAMBECv4BEsbWDvv1uKxIBaSoSg2Pc9ryAB/rZJm1KOvTc/ol4IBALxMiLhd3bPP5BQRQgEAhEnVFG7i2GinggEAvEyIuF39gPPI1QRAoFAxAlVlLqLNY6KQCAQEwk90uziGCYqAoFAIMJEwvvtBxYjVBECgUDECT2Suos1jopAIBATCT2SSqgiBAKBiBOqKHUXaxwVgUAgJhJ6JJUoA7mPenXnRCAQiL8kEn6nfPMBk43nQ2OIv78AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">2102
(11.6%)</td>
      <td align="center">16016
(88.4%)</td>
    </tr>
    <tr>
      <td align="center">130</td>
      <td align="left">diag15
[character]</td>
      <td align="left">1. Z8643
2. I10
3. Z515
4. Z720
5. Z7511
6. Y9222
7. D649
8. I489
9. R296
10. I500
[ 443 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">55</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">54</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">41</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">41</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">41</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">36</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">30</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">29</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">23</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">22</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1328</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">78.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIIAAAESBAMAAADDPBA5AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAKxJREFUeNrt1cENgCAMQFFWcARhA91/Ny9yJaY1RMnrve8ASX8ppk+tdQvOLbTzIBAIhIWF/J2Mrq8mKA6BQCCMBcXp75AVWvgrCAQC4Q9C/k6G9xcTFIdAIBDGguLoBYFAIDwR9EIvCAQCYY6gOPc77FmhEQgEwtJC/k6G9z8l6AWBQCCMBb1QHAKBQJgjKI5eEAgEwhNBL14rTnz6b57ROQgEAuEHQv5OmlIuaN7W0XaCOrcAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">1700
(9.38%)</td>
      <td align="center">16418
(90.62%)</td>
    </tr>
    <tr>
      <td align="center">131</td>
      <td align="left">diag16
[character]</td>
      <td align="left">1. Z8643
2. Z720
3. I10
4. Y9222
5. Z7511
6. E86
7. Z515
8. Z921
9. D649
10. Z602
[ 401 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">57</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">44</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">40</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">37</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">27</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">24</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">23</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">22</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">20</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">20</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1047</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">76.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIAAAAESBAMAAADHycAEAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAMNJREFUeNrt18sJAzEMBcBtwSXE7mDdf29JIB9ylQwrnHl3zcECPXwc8kzv/dZCeQFjTgAAANgFSN/E2PBewOMRc8CYJwAAAOwCpG9icLoSEO7W7xYAAABgGyB9E4PTWwGKBQAAAJpi+XmDJDCivz4AAACoB6RvYnS8EBCuxs8WAAAAALDuqEbHCwGKBQAAAJpeWPkG168RAAAA9EIlQLEAAABAUywr3+D6NQIAAIBeqAT0cN5rnMGcAAAAUA5I38R/zx2ZqsVStSzZfAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">1361
(7.51%)</td>
      <td align="center">16757
(92.49%)</td>
    </tr>
    <tr>
      <td align="center">132</td>
      <td align="left">diag17
[character]</td>
      <td align="left">1. I10
2. Z8643
3. Z515
4. Y9222
5. Z7511
6. Z720
7. Z921
8. R296
9. D649
10. E871
[ 365 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">35</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">34</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">27</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">24</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">23</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">22</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">22</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">13</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">852</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">79.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIMAAAESBAMAAAAs/nsHAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAMFJREFUeNrt1rENgzAUBFBGSDYI9gZh/91SBCm0nC0F7He9X/GR7lgWOaaU8gzz2Im6vREIBGIuokN3pu9HJEwRAoFAnCdM0fEWaytRNwQCgZiM6NCd6fsRiXyVfx81/jdAIBCImxIdujMGrkbYEQQCgThP2BE7gkAgEH8mTJEpQiAQiBbCjhxusTYTFYFAIGYjOnRnDAxI5KuMQCAQiAYiFy5GXOOcCAQCMR2RC+MRJc9rJ+oWB4FAIO5JdOhO+eYDqMXothS1NbkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">1076
(5.94%)</td>
      <td align="center">17042
(94.06%)</td>
    </tr>
    <tr>
      <td align="center">133</td>
      <td align="left">diag18
[character]</td>
      <td align="left">1. Z8643
2. Z515
3. Z7511
4. I10
5. Y9222
6. D649
7. Z921
8. Z720
9. F03
10. R296
[ 311 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">35</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">23</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">23</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">21</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">21</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">18</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">17</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">16</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">15</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">13</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">667</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">76.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAH8AAAESBAMAAAAmjhcQAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAALZJREFUeNrt1cEJwzAMQNGMkG7QyBvU++9WAi34LBlq3Ke73sEG/eMw90TE9cjM+QFa7wAAALALUL6JqeXNgOwbDt8IAAAA2wDlm5jbXgrQBQAAANCFqUBEEWgvAAAA2AYo38Tk+kqALgAAAIAuTH2D338jAAAArAMIi7AAAADACOiCLgAAAMAI6MKMsFxFoAEAAMA+QPkmJtdXAnQBAAAAdGEqENl5fr+xJwcAAADWA8o38d/nDYXUxDv4Z4AjAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAwpGgNOAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMNU1tYQAAAAASUVORK5CYII="></td>
      <td align="center">869
(4.8%)</td>
      <td align="center">17249
(95.2%)</td>
    </tr>
    <tr>
      <td align="center">134</td>
      <td align="left">diag19
[character]</td>
      <td align="left">1. Z8643
2. Z515
3. Z7511
4. Z720
5. Y9222
6. I10
7. I500
8. K590
9. Z223
10. Z921
[ 274 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">33</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">27</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">26</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">17</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">13</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">541</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">76.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAH4AAAESBAMAAADJTHwuAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAALBJREFUeNrt1bEVwjAQREG3QAnYHVj99waBDfldIMHO5ZNo3/vaNre/71G5yx9jnDzP87/ou/0r2T/y1ef77lebj+d5frbv9q+G1/H6z/N8qk/vf9dXn++zX3E+nuf52b7bv6Jexus/z/OpPr7/z54/eJ7nQ323n0W9jPd/8Dyf6vW/52fvx/M8X/Xp/e96/wfP86k+/f/Qf57nU316/7t+r96936jdyfM8P9l3+5d8L3/Bsifn7ih+AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAwpGgNOAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMNU1tYQAAAAASUVORK5CYII="></td>
      <td align="center">711
(3.92%)</td>
      <td align="center">17407
(96.08%)</td>
    </tr>
    <tr>
      <td align="center">135</td>
      <td align="left">diag20
[character]</td>
      <td align="left">1. Z8643
2. Z515
3. Z720
4. I10
5. D649
6. Y9222
7. Z921
8. R33
9. Z223
10. Z602
[ 273 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">22</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">21</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">14</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">11</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">452</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">78.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIIAAAESBAMAAADDPBA5AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAALpJREFUeNrt1bENxCAMQFFWyAiBDcL+u90VSUqE7NMpQc+9XwGSfynmmlrrvsXmFFrvBAKBsLCQv5PB7eWE70smhdYPAoFAWFjI38no+rOE+DPcfxH+CgKBQHiDkL+T4f3FBMUhEAiEsaA4ekEgEAgzgl6c77BnhUYgEAiEoZC/tOH9RwmKQyAQCGNBL/SCQCAQZgS9UBwCgUD4j6A4ekEgEAgzgl78rDjxuX6zR+cgEAiEFwj5O2lK+QABEtbe6PAfXQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">574
(3.17%)</td>
      <td align="center">17544
(96.83%)</td>
    </tr>
    <tr>
      <td align="center">136</td>
      <td align="left">diag21
[character]</td>
      <td align="left">1. Z8643
2. Z515
3. I10
4. Z7511
5. Z720
6. D649
7. Y9222
8. Z921
9. E86
10. I489
[ 230 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">20</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">19</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">14</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">14</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">13</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">358</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">75.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAH0AAAESBAMAAAAie8ctAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAKhJREFUeNrt1bkRwzAQA0CVIHdg0SWw/96c2CPFd4EeLPINeJwBlkXGGNurkPXnP3PyPM/f0nf7r2Kf5O0Hz/OpPn0/is8/3J/nef6evtt/Jfwgbz94nk/16fuh/3meT/Xx/V97/n5/nuf5UN/tz5q+jrcfPM+nev3f82f/H8/zfNWn93/X2w+e51N9+n7of57nU316/3f9KOb9/79ZC8/z/Nm+23/J+QInabF32IK4xwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">476
(2.63%)</td>
      <td align="center">17642
(97.37%)</td>
    </tr>
    <tr>
      <td align="center">137</td>
      <td align="left">diag22
[character]</td>
      <td align="left">1. Z8643
2. Z515
3. Z720
4. Z921
5. Y9222
6. I10
7. N390
8. U739
9. Z7511
10. R13
[ 192 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">19</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">16</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">285</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">74.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHsAAAESBAMAAAAvZbdqAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAMJJREFUeNrt2cENwjAMBdCOABtA2YDsvxs5gOgNYUtVEr9/f4fa0reUblvt7D3X/3N580drTxzH8eF5susCdBneJ3dP8L44HMfx8Xmy6wJ0HB779MPkcRzHJ+DJrovYVbgzgeN4BV75TITeyw6Tj7zW4TiOn82TXRfCo3A9j+M4/pM7E2E+9d5xHK/D9XyYT713HMfr8Mo9n+TOBI7jFXjlMxH7Af6dPI7j+Aw82XUhvAjfY7l9FtdCwXEcP5cnu65qXu6uoiyWV67zAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAwpGgNOAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMNU1tYQAAAAASUVORK5CYII="></td>
      <td align="center">385
(2.12%)</td>
      <td align="center">17733
(97.88%)</td>
    </tr>
    <tr>
      <td align="center">138</td>
      <td align="left">diag23
[character]</td>
      <td align="left">1. Z7511
2. Z515
3. Z720
4. Z8643
5. Y9222
6. B962
7. D649
8. F03
9. K590
10. Z950
[ 156 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">14</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">11</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">227</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">73.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHoAAAESBAMAAADAp9xUAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAALRJREFUeNrt2LENwzAMBECvkBEibWDtv5tTJEgdEgYU8r6/RgT+AR1H34xXHr/nredaJ03T9F4612sBWULHHu17scjBaJqm79S5XovQPfQYz4Sei6Zpejed67UIraCtAU3T1XTXNdDnNE1X0337PKNn6IOMpml6X51rxZDdQlsDmqaraX0e0f97b5qm6+qufZ7T1oCm6Wq66xroc5qmq+mufZ7TI5bPxVYkJ03T9I0612sdcwG+kJFuittMPQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">311
(1.72%)</td>
      <td align="center">17807
(98.28%)</td>
    </tr>
    <tr>
      <td align="center">139</td>
      <td align="left">diag24
[character]</td>
      <td align="left">1. Z515
2. Z8643
3. I10
4. Z7511
5. F03
6. Z720
7. E877
8. K590
9. R410
10. Z921
[ 139 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">13</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">182</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">74.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAH0AAAESBAMAAAAie8ctAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAALpJREFUeNrt1bERwjAQRUGXAB1gqwPUf284gIGUu0CSby/fRJp5f9vccd5+//9ub9967zzP8yv6bP8C9FL+fL6Ub/3J8zy/pM/2L4Qn8rH1/H1/nuf5NX22fyF8IR+cz+//xeab53l+uM/2L6bn8frP83xVr/85P/r/eJ7nR/ny+7HnfON5nl/UZ/sX0/N4/ed5vqqv3v+stx88z1f11fdD/3mer+qr9z/rj+A9Pv/XY8fzPD/aZ/tX+V6e47FMfDffAgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">243
(1.34%)</td>
      <td align="center">17875
(98.66%)</td>
    </tr>
    <tr>
      <td align="center">140</td>
      <td align="left">diag25
[character]</td>
      <td align="left">1. Z515
2. Z8643
3. I10
4. Y9222
5. Z720
6. F059
7. R296
8. Z0661
9. Z602
10. Z7511
[ 112 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">11</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">131</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">70.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHYAAAESBAMAAADamzzaAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAMRJREFUeNrt18sJw0AMQEG3kBLidGD331sw5ONjJME6Ykf3OViCZ3ZZ5pv1mFtwXvax7/vGsiw7yFZ6FWXd7bGqe9IeN2JZlh1lK72Ksn+wmc897ZllWXaYrfQq7JrbxCvldKPw64hlWTZtK72Kw+tt5lf23TPLsuw4W+lVHF5vM5/72TPLsmwTW2ldQl5utZ1l2S5Wn3+3He/LsmxfO1ufK1bbWZbtYmdruz6zLNvFztbnil0z877RHp+NZVk2aSu9mmmeTsBtAOMjlmQAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">186
(1.03%)</td>
      <td align="center">17932
(98.97%)</td>
    </tr>
    <tr>
      <td align="center">141</td>
      <td align="left">diag26
[character]</td>
      <td align="left">1. Z7511
2. Z8643
3. F03
4. Z515
5. D649
6. Y831
7. Z720
8. F3290
9. I501
10. I693
[ 97 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">109</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">72.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHkAAAESBAMAAAArkGdXAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAMZJREFUeNrt2MENwjAQBMCUAB1A0gHpvzfyAOGv72TpsGf/8/FJu0q2bd3sV+7duX30cZ4vmqbpWjrXa/1yDn092jOur4vRNE0X07le65dVdGgEmzcPDDBN0/RQneu1AJ1CWwOapmfTq65B6KOmeXOapulqOtdrAVpE63OapulWW4OI/t970zQ9r163zzP6iPwgo2maHqpzvRaxM+jQCP4uRtM0XU7nei1ia2h9TtP0bHrVPs/pPZTH92JnJDRN0yN1rtdWzBtXfJNZWGsakgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">151
(0.83%)</td>
      <td align="center">17967
(99.17%)</td>
    </tr>
    <tr>
      <td align="center">142</td>
      <td align="left">diag27
[character]</td>
      <td align="left">1. Z720
2. U739
3. Z7511
4. Z8643
5. Z867
6. Y9222
7. I2511
8. I500
9. I959
10. J440
[ 85 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">94</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">74.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHwAAAESBAMAAADNuawTAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAALBJREFUeNrt2bENwzAMRUGvkBEibWDtv5tTJEhPAoGcf+yvoYDHQseRPWOM56Mwbz7XwnEc3583W1eh/8Jfq+vwuU4cx/H9ebN1JbsL13kcxxN4cueb3JnAcTyBJ58JncdxPIFnd77FZ23xOI7jt+LNVNbwJrz2ff7dPI7j+B14s3U1vAnXeRzHE3hy55vcmcBxPIEnnwmdx3E8gSd3vslHcT4Pt0pz4jiO/5Q3W5c6F6zTozYu1AP8AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAwpGgNOAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMNU1tYQAAAAASUVORK5CYII="></td>
      <td align="center">126
(0.7%)</td>
      <td align="center">17992
(99.3%)</td>
    </tr>
    <tr>
      <td align="center">143</td>
      <td align="left">diag28
[character]</td>
      <td align="left">1. Z8643
2. Y9222
3. Z515
4. D649
5. R418
6. Z0651
7. Z720
8. A099
9. F059
10. Z0652
[ 60 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">61</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">62.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGsAAAESBAMAAAAIyzaCAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAALdJREFUaN7t2MENglAQRVFK0A4UOpD+e1OMJiZsmOFH/ON5a8/GSW6AYai98bnreeNOLzbNyzAMw/a1ZOvve2TLH5JgjwPcMAzD9rYkQI5jOolhWAtWuZNJFngq/2TT9ncADMP+gSVbEjGHMZ3EMKwF08kV6+JuGIb9PJPXFevibhiGfY/V7mSKTZGvyhiG1WfJloRQZ0xeMQxrwSrnVScxDGvBKncyycbYLu8DzKFhGFadJVtSdXdl+hEA1mpGIAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">97
(0.54%)</td>
      <td align="center">18021
(99.46%)</td>
    </tr>
    <tr>
      <td align="center">144</td>
      <td align="left">diag29
[character]</td>
      <td align="left">1. Z515
2. Z8643
3. Z0661
4. Z720
5. Z7511
6. Z921
7. F059
8. I10
9. Z0652
10. Z602
[ 46 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">47</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">59.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGYAAAESBAMAAAD9Nb0yAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAJhJREFUaN7t1MEJwzAQRFG3kBIid6D035uDMSHHzRoCGt6c9Q7aw9+2vI1zj9ous7/emwzDpJlOD4qvlzGayDBMahPrn/m+W/VoDMOsZDo9qIM1jCYyDJPaRH1jGEbf7t2NYZhMk9fEZ+NuDMMkmk4P6uD/Rt8YhkntW8doIsMwqU3UN4ZhUvvWMeOXfW5d32QYZhnT6UHSDldK35iBnB0NAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAwpGgNOAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMNU1tYQAAAAASUVORK5CYII="></td>
      <td align="center">79
(0.44%)</td>
      <td align="center">18039
(99.56%)</td>
    </tr>
    <tr>
      <td align="center">145</td>
      <td align="left">diag30
[character]</td>
      <td align="left">All NA's
</td>
      <td align="left" style="vertical-align:middle"></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"></td>
      <td align="center">0
(0%)</td>
      <td align="center">18118
(100%)</td>
    </tr>
    <tr>
      <td align="center">146</td>
      <td align="left">ha_dx1
[logical]</td>
      <td align="left">1. FALSE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">100.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAAAgCAQAAAA7g2tDAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAAmJLR0QA/4ePzL8AAAAHdElNRQfkBxUJNyQ3M/fjAAAAiUlEQVRo3u3ZMQrCMABAUSO9oKMndOwRdax1kvZD0b43JQRC+JAsGc8Le12PPsA/EDEgYmB6nzw8kF+7j2U8rZduR5/tR8yrmescEDEgYkDEgIgBEQMiBkQMiBgQMSBiQMSAiAERAyIGRAyIGBAxIGJAxICIgY/fvnnbLic3fDXv5zoHRAyIGHgBq0kF8n47YVkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">1991
(10.99%)</td>
      <td align="center">16127
(89.01%)</td>
    </tr>
    <tr>
      <td align="center">147</td>
      <td align="left">ha_dx2
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">89.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">231</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJMAAAA4BAMAAAALENcLAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAExJREFUWMNjYBgFpAAlyoEC1ChlY4rBqFGjRo0aNWrUqFGDzCgqVhOClAOBkWIULOyoYBQ0MRiNGjVq1KhRo0aNGjV8jKJiNTEKiAMATI2omlGyOlgAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">2222
(12.26%)</td>
      <td align="center">15896
(87.74%)</td>
    </tr>
    <tr>
      <td align="center">148</td>
      <td align="left">ha_dx3
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">88.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">268</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJAAAAA4BAMAAADgJ2wIAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAEtJREFUSMdjYBgFxAAligHUIGVjCoHRqEGjBo0aNGrQqEH0Mohqhb8gxWD4GwQPM0UKDYJH/6hBowaNGjRq0KhBg94gqhX+owA/AADLZqJqiAzLLwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">2259
(12.47%)</td>
      <td align="center">15859
(87.53%)</td>
    </tr>
    <tr>
      <td align="center">149</td>
      <td align="left">ha_dx4
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">88.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">256</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJEAAAA4BAMAAAAP5Qc2AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAExJREFUWMNjYBgFxAIlioEC1CRlY0rBqEmjJo2aNGrSqEkDaRL1agRBioHAiDAJHnAUmwRLBUajJo2aNGrSqEmjJg1Jk6hXI4wCwgAA4aSlav0J+l8AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">2247
(12.4%)</td>
      <td align="center">15871
(87.6%)</td>
    </tr>
    <tr>
      <td align="center">150</td>
      <td align="left">ha_dx5
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">47.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2214</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">52.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFsAAAA4BAMAAABgeJleAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAENJREFUSMdjYBjaQIkIICgoKABVrmxMEBiNKh9VPqp84JWTmLUFiQODUjkxXgUCBeIDEgRGlY8qH1U+wMpJzNpDFQAATqZPWiEKgmwAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">4205
(23.21%)</td>
      <td align="center">13913
(76.79%)</td>
    </tr>
    <tr>
      <td align="center">151</td>
      <td align="left">ha_dx6
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">55.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1625</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">44.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAF8AAAA4BAMAAABpkzkkAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAD9JREFUSMdjYBgeQIlYoADVoGxMJBjVMKphVMOQ0EByISBILBAYvBoI+xZNA8FgNRrVMKphVMNQ0kByITDUAQAwNFW6aFTe3gAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">3616
(19.96%)</td>
      <td align="center">14502
(80.04%)</td>
    </tr>
    <tr>
      <td align="center">152</td>
      <td align="left">ha_dx7
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">58.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1390</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">41.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGUAAAA4BAMAAAAWQivVAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAD9JREFUSMdjYBh+QIkEoADVo2xMPBjVM6pnVM/w1kNOGSJIAhAYAnoIeBurHvxhbTSqZ1TPqJ4RpIecMmQ4AQD+619KnM2iBwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">3381
(18.66%)</td>
      <td align="center">14737
(81.34%)</td>
    </tr>
    <tr>
      <td align="center">153</td>
      <td align="left">ha_dx8
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">54.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1663</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">45.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAF4AAAA4BAMAAACGUVIaAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAD5JREFUSMdjYBj6QIlYAFWvbEwcMBpVP6p+VP2gU09qfhckFgxS9YQ9qoiinnB4jqofVT+qfrCqJzW/D2UAAIXnUrrC1Tj6AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAwpGgNOAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMNU1tYQAAAAASUVORK5CYII="></td>
      <td align="center">3654
(20.17%)</td>
      <td align="center">14464
(79.83%)</td>
    </tr>
    <tr>
      <td align="center">154</td>
      <td align="left">ha_dx9
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">60.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1319</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">39.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGcAAAA4BAMAAAASt/voAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAD9JREFUSMdjYBieQIkUoADVpGxMAhjVNKppVNOI00RWwSJIChAYGprw+xyHJrxBbjSqaVTTqKaRromsgmW4AQAVR2J6cWs/LwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">3310
(18.27%)</td>
      <td align="center">14808
(81.73%)</td>
    </tr>
    <tr>
      <td align="center">155</td>
      <td align="left">ha_dx10
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">66.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1024</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">34.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAG8AAAA4BAMAAAABYLscAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAENJREFUSMdjYBgZQIlUoADVqGxMIhjVOKpxVOOoRgo0kl1YCZIKBIaeRtyhQEAjzugwGtU4qnFU46hG6msku7Aa7gAA2rdvOl3gnJEAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">3015
(16.64%)</td>
      <td align="center">15103
(83.36%)</td>
    </tr>
    <tr>
      <td align="center">156</td>
      <td align="left">ha_dx11
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">71.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">812</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">29.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAHcAAAA4BAMAAAA1GXoAAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAERJREFUSMdjYBiZQIkcoADVrGxMBhjVPKp5VPOo5kGimaICUJAcIDC0NWMPESI1Y40qo1HNo5pHNY9qHhqaKSoARxoAAICie/pW7gLQAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAwpGgNOAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMNU1tYQAAAAASUVORK5CYII="></td>
      <td align="center">2803
(15.47%)</td>
      <td align="center">15315
(84.53%)</td>
    </tr>
    <tr>
      <td align="center">157</td>
      <td align="left">ha_dx12
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">81.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">448</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">18.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIcAAAA4BAMAAAAlVfaZAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAEtJREFUSMdjYBgF2IASJUABaoiyMQVg1JBRQ0YNGTVk1BC8hlCloBakBAgMT0NQQ4pMQ1Ci2GjUkFFDRg0ZNWTUEGoaQpWCehSgAgBtrZV6hYsLYAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">2439
(13.46%)</td>
      <td align="center">15679
(86.54%)</td>
    </tr>
    <tr>
      <td align="center">158</td>
      <td align="left">ha_dx13
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">84.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">357</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">15.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAIsAAAA4BAMAAAA/aRYXAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAExJREFUSMdjYBgF+IASZUABaoyyMUVg1JhRY0aNGTVm1BgqGEOlIl2QMiAwnI1BDi8KjEGKcKNRY0aNGTVm1JhRYwbGGCoV6aMAOwAAFTeb2j0Ap/wAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">2348
(12.96%)</td>
      <td align="center">15770
(87.04%)</td>
    </tr>
    <tr>
      <td align="center">159</td>
      <td align="left">ha_dx14
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">87.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">297</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAI8AAAA4BAMAAAA2grZtAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAExJREFUSMdjYBgFxAAlSoEC1CBlYwrBqEGjBo0aNGrQqEF0M4hqhb8gpUBg+BuECDUKDYJHv9GoQaMGjRo0atCoQYPdIKoV/qMAPwAAtM2iOgCOiekAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">2288
(12.63%)</td>
      <td align="center">15830
(87.37%)</td>
    </tr>
    <tr>
      <td align="center">160</td>
      <td align="left">ha_dx15
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">89.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">226</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJMAAAA4BAMAAAALENcLAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAExJREFUWMNjYBgFpAAlyoEC1ChlY4rBqFGjRo0aNWrUqFGDzCgqVhOClAOBkWIULOyoYBQ0MRiNGjVq1KhRo0aNGjV8jKJiNTEKiAMATI2omlGyOlgAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDCkaA04AAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAw1TW1hAAAAABJRU5ErkJggg=="></td>
      <td align="center">2217
(12.24%)</td>
      <td align="center">15901
(87.76%)</td>
    </tr>
    <tr>
      <td align="center">161</td>
      <td align="left">ha_dx16
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">92.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">173</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJYAAAA4BAMAAADtORxPAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAEtJREFUWMPt1UENACAMBMFaQELBAfXvjUcRAOEeBHYFzKNpcma0W1U0rRbndSwsLCys6y3ldhRFH1l5PJdY+RNYWFhYWK9byu2g9QZ7uqv6RUVLmAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">2164
(11.94%)</td>
      <td align="center">15954
(88.06%)</td>
    </tr>
    <tr>
      <td align="center">162</td>
      <td align="left">ha_dx17
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">93.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">138</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJkAAAA4BAMAAAAcMkfCAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAEtJREFUWMPt1cEJACAMBMGUYDoQ7SD235soNqCcH90tYB4hcGZ0WpGUl1abIjQ0NDS0VzTtyrik9J02jyjTxocEGhoaGhralZWh/ToBWrIqOREL8QAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMKRoDTgAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzYrMDE6MDDVNbWEAAAAAElFTkSuQmCC"></td>
      <td align="center">2129
(11.75%)</td>
      <td align="center">15989
(88.25%)</td>
    </tr>
    <tr>
      <td align="center">163</td>
      <td align="left">ha_dx18
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">94.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">114</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJoAAAA4BAMAAAD3BfzBAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTckNzP34wAAAEpJREFUWMPt1cEJACAMBMG0YAmaDrT/3kLABiLnR3cLmEcInBmdNjRtzZeiiYaGhob2iKZdmabpOy1P2GVafggaGhoaGtqdlaF6AdILslpv20liAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM2KzAxOjAwpGgNOAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNiswMTowMNU1tYQAAAAASUVORK5CYII="></td>
      <td align="center">2105
(11.62%)</td>
      <td align="center">16013
(88.38%)</td>
    </tr>
    <tr>
      <td align="center">164</td>
      <td align="left">ha_dx19
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">95.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">88</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJwAAAA4BAMAAAD6G4yGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAEpJREFUWMPt1bERABAQBVEtKAEd0H9vLhAL2IjdAl5wczM/JbupQi2uDaQuJycnJ/cuB09PhvqRiysWkItHkZOTk5OT23Lw9NhZE1pHtYoDB+i2AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">2079
(11.47%)</td>
      <td align="center">16039
(88.53%)</td>
    </tr>
    <tr>
      <td align="center">165</td>
      <td align="left">ha_dx20
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">96.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">78</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJ0AAAA4BAMAAAAV2ee4AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAEpJREFUWMPt1TEVACAMA9FKAAc86oD691YGDADZeifgD1liRr9NUeN4Hprw8PDw8Gp56j/qolpRb08p9TwWHh4eHh7etaf+I3ovAQVWuIpYUniYAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">2069
(11.42%)</td>
      <td align="center">16049
(88.58%)</td>
    </tr>
    <tr>
      <td align="center">166</td>
      <td align="left">ha_dx21
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">97.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">61</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJ4AAAA4BAMAAAD+7ly7AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAEVJREFUWMPt1TEBACAMxMBaQAJfB9S/NxYMAL81EXBrIug3uTpelqeFh4eHh9fKc/9ouGrqSdPqZeHh4eHh4d177h/Rexsghri6wYEXXgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">2052
(11.33%)</td>
      <td align="center">16066
(88.67%)</td>
    </tr>
    <tr>
      <td align="center">167</td>
      <td align="left">ha_dx22
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">98.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">41</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJ8AAAA4BAMAAAARLDeFAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAERJREFUWMPt1TERACAMwMBKAAdc6wD8e2PBAdmaCPg1EUaUVOuBdaAEBQUFBduD+KQm1egLZsJgbUFBQUFBQQbEJ2V/XeRRu7q+1u7aAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">2032
(11.22%)</td>
      <td align="center">16086
(88.78%)</td>
    </tr>
    <tr>
      <td align="center">168</td>
      <td align="left">ha_dx23
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">97.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">42</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJ8AAAA4BAMAAAARLDeFAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAERJREFUWMPt1TERACAMwMBKAAdc6wD8e2PBAdmaCPg1EUaUVOuBdaAEBQUFBduD+KQm1egLZsJgbUFBQUFBQQbEJ2V/XeRRu7q+1u7aAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">2033
(11.22%)</td>
      <td align="center">16085
(88.78%)</td>
    </tr>
    <tr>
      <td align="center">169</td>
      <td align="left">ha_dx24
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">98.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">36</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKAAAAA4BAMAAACI1O4wAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAEJJREFUWMPt1UEBACAIwEAqGEFooP278bGB+7EFuO8ijCixHlgX6ggKCgoKTgfxSS2suWBuGCxBQUFBQUEIxCdlfzUkyLvqjbzYBQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">2027
(11.19%)</td>
      <td align="center">16091
(88.81%)</td>
    </tr>
    <tr>
      <td align="center">170</td>
      <td align="left">ha_dx25
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">98.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">22</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKEAAAA4BAMAAABnFoUOAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAD9JREFUWMPt1bERABAABEEl0IGhBP33JpEJfWavgE2vFKUasfoR50pFJBKJROIt5s/VYtWvxUEkEolE4uei3tsBbb7qilnrFgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">2013
(11.11%)</td>
      <td align="center">16105
(88.89%)</td>
    </tr>
    <tr>
      <td align="center">171</td>
      <td align="left">ha_dx26
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">99.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">16</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKEAAAA4BAMAAABnFoUOAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAD9JREFUWMPt1bERABAABEEl0IGhBP33JpEJfWavgE2vFKUasfoR50pFJBKJROIt5s/VYtWvxUEkEolE4uei3tsBbb7qilnrFgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">2007
(11.08%)</td>
      <td align="center">16111
(88.92%)</td>
    </tr>
    <tr>
      <td align="center">172</td>
      <td align="left">ha_dx27
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">98.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">23</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKEAAAA4BAMAAABnFoUOAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAD9JREFUWMPt1bERABAABEEl0IGhBP33JpEJfWavgE2vFKUasfoR50pFJBKJROIt5s/VYtWvxUEkEolE4uei3tsBbb7qilnrFgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">2014
(11.12%)</td>
      <td align="center">16104
(88.88%)</td>
    </tr>
    <tr>
      <td align="center">173</td>
      <td align="left">ha_dx28
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">99.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">17</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKEAAAA4BAMAAABnFoUOAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAD9JREFUWMPt1bERABAABEEl0IGhBP33JpEJfWavgE2vFKUasfoR50pFJBKJROIt5s/VYtWvxUEkEolE4uei3tsBbb7qilnrFgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">2008
(11.08%)</td>
      <td align="center">16110
(88.92%)</td>
    </tr>
    <tr>
      <td align="center">174</td>
      <td align="left">ha_dx29
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">99.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAAA4BAMAAACMIT4NAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAD5JREFUWMPt1TEBABAABVEVREAD+nez2Iz+5l2At14pStVzHXGsVJNIJBKJxEvMn6vm+lpsRCKRSCR+Luq9DZcnwFokJcz/AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">1999
(11.03%)</td>
      <td align="center">16119
(88.97%)</td>
    </tr>
    <tr>
      <td align="center">175</td>
      <td align="left">ha_dx30
[logical]</td>
      <td align="left">1. FALSE
2. TRUE</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1991</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">99.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAKIAAAA4BAMAAACMIT4NAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAD5JREFUWMPt1TEBABAABVEVREAD+nez2Iz+5l2At14pStVzHXGsVJNIJBKJxEvMn6vm+lpsRCKRSCR+Luq9DZcnwFokJcz/AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">1993
(11%)</td>
      <td align="center">16125
(89%)</td>
    </tr>
    <tr>
      <td align="center">176</td>
      <td align="left">proc1
[character]</td>
      <td align="left">1. 4752200
2. 4751900
3. 4752801
4. 4931800
5. 9555003
6. 4753100
7. 4931500
8. 4792100
9. 4932400
10. 9555002
[ 145 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7864</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">43.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6269</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">34.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1757</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">473</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">353</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">231</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">210</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">106</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">66</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">52</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">557</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAE4AAAESBAMAAAChv/4WAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAKBJREFUaN7t2bENgDAMRFFW8AgmG8D+u9HQUIQ7CYEj8q9+jSP9Kssy/la107X9fhsO90Pn9hFqxa5/QF5c/11wuP86t4/iflO5djkOh5vDuX2EWnnnabm243DzObePUHutX8+1DYebz7l9hNpb/aZ5Lw6H6zq3o1Cjcxzuczd8vzgc7rFTrNolDod77BSjXxxuXKdYtePfCofrO7ePkXcAYZwOCYAtt34AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDACHwaMAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwc0K+MAAAAABJRU5ErkJggg=="></td>
      <td align="center">17938
(99.01%)</td>
      <td align="center">180
(0.99%)</td>
    </tr>
    <tr>
      <td align="center">177</td>
      <td align="left">proc2
[character]</td>
      <td align="left">1. 9250829
2. 9250839
3. 9250830
4. 9251439
5. 9250820
6. 9250899
7. 9251429
8. 9251430
9. 9251499
10. 9251420
[ 232 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2329</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2321</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2159</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1520</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1490</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1338</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1087</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1063</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">632</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">606</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3201</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">18.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAACgAAAESBAMAAAB9RoohAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAJFJREFUWMPt1MENwCAMA0BWyAiUDdL9d2sfKAXV/BIRIft5jwbJVkuJyWWRNx3b3aPEBAg7kik+yDHkx4gx2Ccruk7MgLCjwJ/AjO3bIXE/wo5ceq/oOjEJwo5cehdwXYmZERbnMQYB15WYBWFH7P14jOh9NYY/tuFBxO0IO2Lvx2NE76sxDLEnDVHiZoQdeecB1Wy8LCfH8voAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDACHwaMAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwc0K+MAAAAABJRU5ErkJggg=="></td>
      <td align="center">17746
(97.95%)</td>
      <td align="center">372
(2.05%)</td>
    </tr>
    <tr>
      <td align="center">178</td>
      <td align="left">proc3
[character]</td>
      <td align="left">1. 9555003
2. 1370602
3. 9555002
4. 9250839
5. 9555009
6. 9250829
7. 9555000
8. 9250830
9. 9555001
10. 5600100
[ 369 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7749</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">45.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2078</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1150</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">293</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">291</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">289</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">221</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">208</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">202</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">197</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4205</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">24.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFEAAAESBAMAAAB3GiRzAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAKFJREFUaN7t2kEKgCAQRmGPkDfIvEHd/25tQijTmZDAYd6//hYlPFeGYGebuPWS+ZCGRHqV+o6iuGUKWT48SbKcEhKJfEh9R1Hc770njczd/0YiPUt9R1HcHLL/N7dTQiKRDanvSHL0jkTOLukdiUTWkpsBifQj6R2J9COt9K6X3AxI5Li0cjPQOxI5Lq30rpcvT5tap1S9ltqRSOTHjizsBH41LhHnML4XAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">16883
(93.18%)</td>
      <td align="center">1235
(6.82%)</td>
    </tr>
    <tr>
      <td align="center">179</td>
      <td align="left">proc4
[character]</td>
      <td align="left">1. 9555003
2. 9555002
3. 1370602
4. 9555000
5. 9555005
6. 9555001
7. 9555009
8. 9251599
9. 5600100
10. 9555012
[ 307 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4780</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">35.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4174</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">30.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">773</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">543</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">440</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">412</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">403</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">249</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">126</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">96</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">0.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1670</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAEEAAAESBAMAAABQtKWbAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAALBJREFUaN7t2cENg0AQQ1FKYDrIsh2Q/nuLEiHEIcaHoNkR+T6/AyPZ4rDTVCeLzGMT/amCQGQJ39OQmVOF+MyD+H7tikAkCt/TvL20U/G+BYEYK3xPQyZ9Ue1cdHUsApEmfE9D5uK9GNE/f04EYqTwPQ2Za/fS7C0IRH3hmxwyLArxb6LOXpzoKwIxWvieRtQQCwJxCxEposq1CMRvIoqI/QWqKbG/aSEQw4TvaYW8AFUkoJhLkOeSAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">13666
(75.43%)</td>
      <td align="center">4452
(24.57%)</td>
    </tr>
    <tr>
      <td align="center">180</td>
      <td align="left">proc5
[character]</td>
      <td align="left">1. 9555002
2. 9555003
3. 9555000
4. 9555001
5. 9555005
6. 9555009
7. 1370602
8. 9555012
9. 9251599
10. 9555011
[ 229 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2333</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">28.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1915</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">23.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">722</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">708</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">487</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">388</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">350</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">131</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">97</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">95</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1048</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADcAAAESBAMAAACr41BEAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAKRJREFUWMPt2MENgzAQRFFKyHYQxx04/ffGIYkAeRgLyYYg/bm+A2vpn5ima/ZSe34xv8VAcIu2oVB7jMXqmLTC6ikgWKNtaGy3Gj/XFhB0aBsKNaIG/xyviFp8cXttAUGPtqFQ69PtLmZxLAgeQRtYqHWJOrlrQbCFtqFQ69BtMphBsI22oYjzkajBO0ZNt+Adu7W4/KBWT/n92S4guIu2obM3A/h/SyH6F3R/AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">8274
(45.67%)</td>
      <td align="center">9844
(54.33%)</td>
    </tr>
    <tr>
      <td align="center">181</td>
      <td align="left">proc6
[character]</td>
      <td align="left">1. 9555002
2. 9555003
3. 9555000
4. 9555001
5. 9555005
6. 9555009
7. 1370602
8. 9555012
9. 9251599
10. 9555011
[ 180 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">962</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">21.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">748</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">16.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">593</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">542</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">374</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">253</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">182</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">93</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">74</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">69</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">674</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">14.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAACwAAAESBAMAAAB0rSpbAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAKhJREFUWMPt2EEKhTAQA1CvMEeovUG9/93cqG3HZlGYCpHM8i00kPD5uG1rb3d3cT66K2ICBl2au0huX5cqtwHFJAy6DN5Jx0+SIqZh0OUnPzNpHFDMw6DLwJ0kz7mNIeZg0GXYTtKbc5dDzMyg4rmdAHaPbpKI2Rh0CZqf4/sfkk9SxHQMujRbx/0wa0AxH4MuzQJYO/kPr9wJYPfZZ/CVSMzCoMtVdwLGK9+nKpsvSQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">4564
(25.19%)</td>
      <td align="center">13554
(74.81%)</td>
    </tr>
    <tr>
      <td align="center">182</td>
      <td align="left">proc7
[character]</td>
      <td align="left">1. 9555002
2. 9555000
3. 9555001
4. 9555003
5. 9555005
6. 9555009
7. 1370602
8. 9555012
9. 9555011
10. 9251599
[ 138 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">437</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">17.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">345</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">14.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">332</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">305</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">214</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">148</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">90</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">58</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">51</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">46</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">416</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">17.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAACgAAAESBAMAAAB9RoohAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAJhJREFUWMPt2LENwCAMRFFWYATiDcz+u6VIIkxyHSZ2cS5fY6SPKChlzxzT3CjdjBKDETaq0/ig2TJwHEmJ8QgbuXVvaDsxAcJGWx+BVsGRiBkQNvLpPuO1XYk5EDby6P5GMbuJORGGW78MXxSzmxiOsNFyd4CixEQIGy12h8jLkB93XAZ2z48/PgL2p+E5Uh+jxGiEjbznBHNYvApa/GXAAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">2442
(13.48%)</td>
      <td align="center">15676
(86.52%)</td>
    </tr>
    <tr>
      <td align="center">183</td>
      <td align="left">proc8
[character]</td>
      <td align="left">1. 9555002
2. 9555000
3. 9555001
4. 9555003
5. 9555005
6. 9555009
7. 1370602
8. 9555012
9. 9251599
10. 9555011
[ 106 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">232</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">16.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">171</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">169</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">142</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">142</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">102</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">56</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">40</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">35</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">35</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">267</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">19.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAACkAAAESBAMAAACShOEfAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAJJJREFUWMPt1cENgCAQBEBKkA5EOsD+e/NzwQM3fuTMEXaf8/GS3UgIdjl04iaazzuF6lBxb7HJOK1fSlrrZVSninvjHlZVqz28r6RVuaxQvSrujXtYVW330GtWF1DnUdzmkJWkp2Z52aheFfc2Yg8pohuovhX39n0PWLmSOdVqJdzDnPr3X0Nnr5fpUP0p7s0iFz13zmueIx6PAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">1391
(7.68%)</td>
      <td align="center">16727
(92.32%)</td>
    </tr>
    <tr>
      <td align="center">184</td>
      <td align="left">proc9
[character]</td>
      <td align="left">1. 9555002
2. 9555000
3. 9555003
4. 9555001
5. 9555005
6. 9555009
7. 1370602
8. 9555012
9. 9251599
10. 9555011
[ 92 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">111</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">105</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">105</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">96</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">64</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">50</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">33</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">21</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">20</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">15</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">185</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">23.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAC8AAAESBAMAAACfmpFYAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAKNJREFUWMPt1VEOQDAQBFBHsDdQvUHd/24SobrLREQrsmZ+34dNZtB172TMCbKkXyFOWwjOAHYuNg1gf7iBfG4iOAPYOXdF+PiurgcX0LkEbwA7r76rcISoTiI4Ath57V2dQSy+rIR/ABzD/V1B0IvWVxF8AuxcbJ7sKpxDnAhOAXYuNhwcoQK8MTj9By6vSgSnADsXaQ+jzZBfAxOCF4Cdt84MNe4DVsL5fdkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDACHwaMAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwc0K+MAAAAABJRU5ErkJggg=="></td>
      <td align="center">805
(4.44%)</td>
      <td align="center">17313
(95.56%)</td>
    </tr>
    <tr>
      <td align="center">185</td>
      <td align="left">proc10
[character]</td>
      <td align="left">1. 9555002
2. 9555000
3. 9555003
4. 9555005
5. 9555001
6. 9555009
7. 1370602
8. 9617500
9. 9555012
10. 9251599
[ 71 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">80</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">15.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">64</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">57</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">53</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">52</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">35</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">16</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">11</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">121</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">23.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADAAAAESBAMAAABJP0s9AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAJ5JREFUWMPt1NEJwCAMBFBXyAiaDXT/3QqlLSXx6Ee10Hj3+z4M3GFK36TcInsO0HalEkIB7FxcxoN92p9bCcEAdj5jVxbUHkWIArDzgbt6HJwDtdcSogDsnLsi/GFXuQP7VYSlAI5BXF4MLvdBGyEowM7F5cWuAGglBAXYuch84ODWgy8G5/7K6ypCVICdi8yH4nKe20wqIQjAzmdnAwT9AY0Ng3MBAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">508
(2.8%)</td>
      <td align="center">17610
(97.2%)</td>
    </tr>
    <tr>
      <td align="center">186</td>
      <td align="left">proc11
[character]</td>
      <td align="left">1. 9555000
2. 9555003
3. 9555001
4. 9555002
5. 9555005
6. 9555009
7. 9555011
8. 9251599
9. 9555010
10. 1370602
[ 51 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">49</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">14.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">41</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">38</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">35</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">34</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">22</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">78</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">23.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADAAAAESBAMAAABJP0s9AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAKBJREFUWMPt1MENgDAMA0BWyAglG7T774aEKIgEiwdtkVL7ew8i2XRZxmS9kmTPAVrOEGIB7Fxc2oP9tD+XEA1g5z12ZaFelQnRAHbecFevg0voXEI4gJ132JUDtX8BIQrAzlvvKj2A3qdOmADgGMTlw+DSM2ghBAXYubh82BUAzYSgADsX6Q8c3HwwYnDc1Xzw80NmU88tJpkQBGDnvbMB1xIBq5RNd+gAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDACHwaMAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwc0K+MAAAAABJRU5ErkJggg=="></td>
      <td align="center">328
(1.81%)</td>
      <td align="center">17790
(98.19%)</td>
    </tr>
    <tr>
      <td align="center">187</td>
      <td align="left">proc12
[character]</td>
      <td align="left">1. 9555000
2. 9555002
3. 9555005
4. 9555003
5. 9555001
6. 9555009
7. 9555010
8. 9617500
9. 1370602
10. 9251439
[ 42 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">30</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">29</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">26</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">18</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">17</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">16</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">61</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">27.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADYAAAESBAMAAABEITt6AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAKRJREFUWMPt1EEOgkAQRFGuUEeAuQHe/25utI122RiUkWR+bd+CJvkwTf23xGbFbtYu92HYdi9yO9Aet2SLd1gxbLuXQ/s01syZ2NhW9bK3wb2W/vHpHTBMH/Uit5/06a2lDwwb3ape5Eaf2EnsD+2+tZaOxEa3qhe5fd3nXNyJYc9W9SI32sVOYr3bdY+LOzHsxapepL62uMU3lrdiQ1vVS89dASJzNrpp4Jb8AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">222
(1.23%)</td>
      <td align="center">17896
(98.77%)</td>
    </tr>
    <tr>
      <td align="center">188</td>
      <td align="left">proc13
[character]</td>
      <td align="left">1. 9555002
2. 9555003
3. 9555000
4. 9555005
5. 9555001
6. 9555009
7. 9617500
8. 1370602
9. 9555011
10. 9555012
[ 32 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">17</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">16</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">11</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">45</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">29.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADkAAAESBAMAAAC1KmD3AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAK1JREFUaN7t1sENwjAQRNGUwHYQsx2E/nvLASIQGo9lYWKQ/lzfZSN9S1mWebsei9ddHpq3+zYU7VLfVch9X4+jiv0iFO1T31XIjeu5VDTFxSjaVt9VyFE7+p86q3bxg/R+84aiveq7CrlhPVc11cko+qH66kKO2tFf1Zk9F3szivar7yrkzqm9rqkeKIo21XcVcoN6NprqZBRtqu8q5E6pXWx9vlAxFG2p72rGdqzAXjI+0BjRAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">151
(0.83%)</td>
      <td align="center">17967
(99.17%)</td>
    </tr>
    <tr>
      <td align="center">189</td>
      <td align="left">proc14
[character]</td>
      <td align="left">1. 9555000
2. 9555002
3. 1370602
4. 9555003
5. 9555001
6. 9555005
7. 9068601
8. 9555011
9. 9555009
10. 9555014
[ 23 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">11</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">11</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">28</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">27.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADYAAAESBAMAAABEITt6AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAKRJREFUWMPt08ENgzAQRFFa2BLMdgD998YBJ0ri8QoErCL5z/UdbEvf05S/ua7Yx6r5ug/DXhb1YmoPGu1iZyy7XXXczz0x7FAvpka72J9Ydrv1PGn7PRcMO9SLqd3RZ9Hm7S/CsK5FLZnaHe12zNsfhg1uUS+mdr3P0jNvfxE2uEW9mNqj7Zau+Yph3xb1Ymr0iSVadp+RzWrvN7RbsKEt6iVzG93aOCofqLhqAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">102
(0.56%)</td>
      <td align="center">18016
(99.44%)</td>
    </tr>
    <tr>
      <td align="center">190</td>
      <td align="left">proc15
[character]</td>
      <td align="left">1. 9555003
2. 9555002
3. 9555005
4. 9555009
5. 9555000
6. 9555001
7. 9555012
8. 1381501
9. 9251430
10. 1310000
[ 17 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">14</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">18.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">7</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">20</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">26.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADQAAAESBAMAAABA1OtHAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAJZJREFUWMPt1MENgCAQRFFa2BKQDrD/3kwMCeKuY6KBEHbm+g7s4WsIY7c1k3OF0n5ZJrkj0IYY60Xl/WhQOZ7klUAboKhvxA5JM3QIiImSZkhUv9ReSPJLoA0x9rvDaFPSB5JIb9mIMSZKWqHD+EBJH0jyRKANMcZESSsnajxVLyS5JtCGGOv4q1SrH9F9meSIQBujdgCggyppN1wwIQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">76
(0.42%)</td>
      <td align="center">18042
(99.58%)</td>
    </tr>
    <tr>
      <td align="center">191</td>
      <td align="left">proc16
[character]</td>
      <td align="left">1. 9555000
2. 1370602
3. 9555001
4. 9555002
5. 9555005
6. 9555003
7. 9555009
8. 9251599
9. 9251439
10. 9555012
[ 17 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">9</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">14.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">17</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">27.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADYAAAESBAMAAABEITt6AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAI9JREFUWMPt1LsNgDAQBFFauBLAHUD/vUHAT7A+IPAZwWz6Ep80ctPEr9vW2rLZ0rAOwy57MbWCdnzG+QYMs1u9mBp9Yh/u0zPaxZ4Yfyv2ZqvSZ6stiWdiWM68lkyNdrFAq9FnzqZ39hi2N68XUyvbbtaSOAH7t3m9mBp9YoEW3adnndp6w3k99mvzeoncCPdROW+0RuVjAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">61
(0.34%)</td>
      <td align="center">18057
(99.66%)</td>
    </tr>
    <tr>
      <td align="center">192</td>
      <td align="left">proc17
[character]</td>
      <td align="left">1. 9555002
2. 9555000
3. 9555003
4. 9555001
5. 9068601
6. 9555005
7. 9555011
8. 9555012
9. 1310000
10. 1370603
[ 12 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">8</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">17.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">8.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">12</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">26.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADUAAAESBAMAAACvFoB5AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAJxJREFUWMPt1tsJgDAMRmFHMBt42aDdfzfBC9g2RC0aCp7/9Xtp4Ah2nf+m80ZZ1+82x9Mw7KIXUfalFQ9Rb8Cw616+7HNUbC5eif3drF5qG6y1/SmqbTcEDLvVi9VZrWWfSf5ODEvM6kWU0SfWitEu1rLRJ9ayefdpWfaLnN4QMCw1qxeR940+sSfm3adlk7LhuCGWw/5tVi+eWwB2ADQ0HcLb5AAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">45
(0.25%)</td>
      <td align="center">18073
(99.75%)</td>
    </tr>
    <tr>
      <td align="center">193</td>
      <td align="left">proc18
[character]</td>
      <td align="left">1. 9555002
2. 9555001
3. 9555003
4. 9555005
5. 1310000
6. 9251429
7. 9251599
8. 9555012
9. 3453005
10. 5600100
[ 10 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">10</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">27.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAADUAAAESBAMAAACvFoB5AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAIpJREFUWMPt1MENgCAMRmFGsBsIjuD+u3kRoharmFhJfP/1u9DkhRD8l8qi5A2rTXMehl33IpW9afol+gYMu9PL0wYto0+sxbz7tIx2sRb74m+NJzYd3ohhVi9SGX1ivRjtYj0bfWI9m3eflumXbG/AsL1ZvUhl9Il5mneflqXKxnKDHvZvs3rx3AIwXzh/L4bIQwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">37
(0.2%)</td>
      <td align="center">18081
(99.8%)</td>
    </tr>
    <tr>
      <td align="center">194</td>
      <td align="left">proc19
[character]</td>
      <td align="left">1. 9555000
2. 9555005
3. 1370602
4. 9555003
5. 5012400
6. 9555001
7. 9555002
8. 9555009
9. 1381501
10. 3002900
[ 4 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">5</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">17.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">4</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">13.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAACcAAAESBAMAAACMTdGsAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAIZJREFUWMPt2LENgDAMRNGMABsA2SDsvxuNkYPidDac8Ll8TUDfihClxMzRzyZYz26IX6PZaO1n8UE9ZVfURyICoNnIqfsD5fRGhECzUeQlAPTuxBeW4b5TxtOJKGg2YvecyGXIieyeEyO6z5ZhxCqfIEQINBux++8xovtsGfgvCBzNRt5zAVbnugiulSQmAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwAh8GjAAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMHNCvjAAAAAASUVORK5CYII="></td>
      <td align="center">29
(0.16%)</td>
      <td align="center">18089
(99.84%)</td>
    </tr>
    <tr>
      <td align="center">195</td>
      <td align="left">proc20
[character]</td>
      <td align="left">1. 9251439
2. 9555000
3. 9555001
4. 9555003
5. 9555005
6. 9555009
7. 9555010
8. 1388201
9. 3453004
10. 5650700
[ 6 others ]</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">11.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">2</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">3.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">6</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">23.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAC8AAAESBAMAAACfmpFYAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAHtJREFUWMPt1MENgCAMRmFGsBuobKD776aJGAOhN0Fp33/9LiR9IYQ+W+9J2pQg7tc2wBqoN5dyDYDg/EGP4OjKH/zgI6tAzN4KGAL15nQF0BUwChAcMHBXSxXOVwE2Qb25lCM44AXoERxd+YOvP7J88/PcfIAVUG/eegfnsQH3X77jPQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozNyswMTowMAIfBowAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDBzQr4wAAAAAElFTkSuQmCC"></td>
      <td align="center">26
(0.14%)</td>
      <td align="center">18092
(99.86%)</td>
    </tr>
    <tr>
      <td align="center">196</td>
      <td align="left">proc_date1
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-05-17
med : 2016-05-20
max : 2018-12-30
range : 6y 7m 13d</td>
      <td align="left" style="vertical-align:middle">2229 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTclQDTHdQAAAM1JREFUaN7t130KgzAMh+FeYb3B6g3M/e+2frggtPpHGpzb3h8iWMhDxdhqCMSShzUppadezGKLCNjnse2Z+mDb/GawmCeUmXaexkRkeR83wcoN+mEiK9hXYq0POiyPWrA6jW6oHnfBksYB08oV7GKs9a0d06+IranaUm/EdEccdCjYGRaHL6IVG1ZasP36MI3ty8DAanS98cD6MrBrsHi0D5mwo33Iig3LwPyxsl+4YWUUDAwMDAzsnzD9H3TBTsrAwMDAwH4VSy4JxJIXp9IMPGid9tIAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzcrMDE6MDACHwaMAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM3KzAxOjAwc0K+MAAAAABJRU5ErkJggg=="></td>
      <td align="center">17938
(99.01%)</td>
      <td align="center">180
(0.99%)</td>
    </tr>
    <tr>
      <td align="center">197</td>
      <td align="left">proc_date2
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-05-17
med : 2016-05-20
max : 2018-12-30
range : 6y 7m 13d</td>
      <td align="left" style="vertical-align:middle">2228 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAMdJREFUaN7t1wsKgzAMBuBeYb3BshuY+99tfbggVmVLfobQPxTBQD4i9qEpMTzx8IaIPO0mir1Uibmw9TVgsLU/AFbawmF9RLHce4pilSlX/UgxTHUhRqxPqgErWQ/W2hhSbdwF69uWtAcMY7bfLBisD2JfYNIChO0qf8bskwSB2Vk9A5YPF6IH2y7pMLYtI0YMj9nmhcDGMmL/wfLZOeTCzsqIzYTVCQXDapYYMWLEiBGbCbOfSwh2UUaMGDFixG6ECSQSwxNvvgAMoTGgMXgAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDD0V3ZlAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAwhQrO2QAAAABJRU5ErkJggg=="></td>
      <td align="center">17746
(97.95%)</td>
      <td align="center">372
(2.05%)</td>
    </tr>
    <tr>
      <td align="center">198</td>
      <td align="left">proc_date3
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-06-26
med : 2016-06-07
max : 2018-12-30
range : 6y 6m 4d</td>
      <td align="left" style="vertical-align:middle">2204 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAANhJREFUaN7t1wEOgyAMBVCuoDdYucF6/7sNKWDmiHHlLyPmN8REk74gaK0hMDyxeENEHu1kFIuqxFxY2QYMVuY3G5buEYfZ8GNrmo0dEZjqMx+V2DdYWn0clseNMHtC95C8Wl4sb90esUoTYVYDQVirNyDMxn2xt0o4hh3e6jHskPlfrDVLCKx1ESBM7IuGwWLdRxTWzSRGbD6sVUIE9plGjBgQK20iCLPGAod1uwov1k0jRozYGbY1hjBsu0qMGLHfYGv964JgJ2nEiBEjRozYBUwgERieeAEjOAQ+ZURiOwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMPRXdmUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDCFCs7ZAAAAAElFTkSuQmCC"></td>
      <td align="center">16883
(93.18%)</td>
      <td align="center">1235
(6.82%)</td>
    </tr>
    <tr>
      <td align="center">199</td>
      <td align="left">proc_date4
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-05-28
med : 2016-06-30
max : 2018-12-31
range : 6y 7m 3d</td>
      <td align="left" style="vertical-align:middle">2096 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAONJREFUaN7t2WEKhCAQBeCusN5g7QZ5/7tt+kqlZKHxwdr2Bv8UzYdDOA00TQpLvKzhvX/ni15sDkHYday8AwJWNjcM5tYCgW2VdmEhSWVzA2CxQB4WwjIutlZKwHxilrS6sXmX/hXDqSFhyHkChq5DwrDsGFoEC8Opzm2VgdWZwu6JObRVEoY0Knb4evRhh8zLGNoqCcMDPKz+QnZjddooWG5eDOycJkzYI7BtsCBhqeEL+ynWHOusWDNNmDBhws6Y28dOCvYl7b5YnMxpWLwrTJgwYcKEkTHX/M9iwTwlJoUlPno7+4sZx1TGAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAw9Fd2ZQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMIUKztkAAAAASUVORK5CYII="></td>
      <td align="center">13666
(75.43%)</td>
      <td align="center">4452
(24.57%)</td>
    </tr>
    <tr>
      <td align="center">200</td>
      <td align="left">proc_date5
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-05-22
med : 2016-07-06
max : 2018-12-27
range : 6y 7m 5d</td>
      <td align="left" style="vertical-align:middle">1887 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAANdJREFUaN7t12EKwyAMBWCvMG8wdwNz/7tNjUsLSqHpG1j6gj/aUj8CrYmGwPDEyxsppbfd+LBYDL36iGyeExPJhpUBwGp+OEyatDTWvwEG68kR+zNmCweB2R+Fw0p+CYPpcswYTEfFWn4orA1ixJbEtONufe0aNi5EYnfDtHvEaY0+jekLcVqjPVhvHWON9mD7aZnYbTErXghsnEaM2COwfvoGYXr6fgI23Tx5sek0YsSIERux+NsQQ7CDacTaqAcQGFafEiNGjBgxYitjttG4jCVIBIYnvulaDQx1O2WsAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAw9Fd2ZQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMIUKztkAAAAASUVORK5CYII="></td>
      <td align="center">8274
(45.67%)</td>
      <td align="center">9844
(54.33%)</td>
    </tr>
    <tr>
      <td align="center">201</td>
      <td align="left">proc_date6
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-05-18
med : 2016-06-22
max : 2018-12-27
range : 6y 7m 9d</td>
      <td align="left" style="vertical-align:middle">1650 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAKNJREFUaN7t2MENgCAMhWFW0A2EDXT/3YzlYKNRA60Y9X8HDtB8ByChIQRSk64iUTKoGQOWpiVg5Vg+BidMxhGsKdbLCXphKwP2YixfiuiECTCCgd2E6etqxxTzTWy3WxYsbZlHsV61hXZMKuP6QNoxXQ8GBgbWADvq5+qwg3owMDAwMDAwMLDdYm7DnLA8/Ufs9LunFEvX9WBgYO/FoksCqckM4P71UGra5JkAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDD0V3ZlAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAwhQrO2QAAAABJRU5ErkJggg=="></td>
      <td align="center">4564
(25.19%)</td>
      <td align="center">13554
(74.81%)</td>
    </tr>
    <tr>
      <td align="center">202</td>
      <td align="left">proc_date7
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-07-21
med : 2016-06-01 12:00:00
max : 2018-12-28
range : 6y 5m 7d</td>
      <td align="left" style="vertical-align:middle">1306 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAKBJREFUaN7t2EEKgCAQhWGvkDdIb6D3v1uULibERTNTUP1vl/Q+RBqoQiCaLNqkI2u7sGK57gF7ORbbQ+GEHUr9LtYOK/lgrV/AwG7C5GybsSz6YNPTTj5Y77hicn9mTO4P7BEsjvNc5NI1rA6dUxMMDOxpLI4vmAZsvA0MDAwMDAzsP1j/NvXB+hIYGBiYCpN/0s3YtAkGBqacTWMC0WQDbSA0pMO0GmoAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDD0V3ZlAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAwhQrO2QAAAABJRU5ErkJggg=="></td>
      <td align="center">2442
(13.48%)</td>
      <td align="center">15676
(86.52%)</td>
    </tr>
    <tr>
      <td align="center">203</td>
      <td align="left">proc_date8
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-07-21
med : 2015-07-13
max : 2017-12-27
range : 5y 5m 6d</td>
      <td align="left" style="vertical-align:middle">760 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAJJJREFUaN7t2MENgCAMhWFW0BFgA9l/NxOFg009+Frjwf/dCPSDQHqhFKJkkVJH5jiEtX5kAwP7F7aONsrBTqRrmOnoGGaqNKz6l6Nhza/6EDNvH8Suq8HARGx2XQo2htub2DxwCmamLebvJWLdnQYDAwMDAwMDAwMDAwMDAwMDczD7VRzCbqrAwMCeYzUlhSjZAZ+TfDNKbmosAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAw9Fd2ZQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMIUKztkAAAAASUVORK5CYII="></td>
      <td align="center">1099
(6.07%)</td>
      <td align="center">17019
(93.93%)</td>
    </tr>
    <tr>
      <td align="center">204</td>
      <td align="left">proc_date9
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-07-21
med : 2015-05-20 12:00:00
max : 2017-12-27
range : 5y 5m 6d</td>
      <td align="left" style="vertical-align:middle">521 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAI1JREFUaN7t2MEJwCAMhWFX0A3abqD77+ahBhpRCJpSKP+7CEa/g8aLIZCVRJ106hzRlAlW7lxtBHuesAvWVuXvsaQ7ZhPT03/HpCVcsFbOYANMTtoFk11gb2PdA9nDujIYmBEbt+EiVoZlMDAwMDAwMDAwMDAwMDAwMDAwMDsmX3Yu2GQXmOEC9hLISipkiKpOPeiqHwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMPRXdmUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDCFCs7ZAAAAAElFTkSuQmCC"></td>
      <td align="center">644
(3.55%)</td>
      <td align="center">17474
(96.45%)</td>
    </tr>
    <tr>
      <td align="center">205</td>
      <td align="left">proc_date10
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-07-29
med : 2015-03-04
max : 2017-12-06
range : 5y 4m 7d</td>
      <td align="left" style="vertical-align:middle">366 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAJVJREFUaN7t2FEKgCAMxnGvYDeobpD3v1uQ62EhI3XEgv/3Mnz54QRFTYmMJKtsNWvuTBPby5XwmDTtg9XREQmT/nwwVcDAPsQWa6d2Y8WYZyDs0fQkpucJBgYGBuaIyXntg+nyM0xdPB+YXqUXWEu5sWIUMDAwMDAwMDAwMDAwMLDwmLySfTApYGA2ZvzbDGOTSWQkJyZJJz+fTVVKAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAw9Fd2ZQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMIUKztkAAAAASUVORK5CYII="></td>
      <td align="center">404
(2.23%)</td>
      <td align="center">17714
(97.77%)</td>
    </tr>
    <tr>
      <td align="center">206</td>
      <td align="left">proc_date11
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-07-29
med : 2015-02-21
max : 2017-11-27
range : 5y 3m 29d</td>
      <td align="left" style="vertical-align:middle">237 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAJBJREFUaN7t18EJgDAMQNGuUDewbmD2303QHIyEQNsgCv9fcnsENKCl0EjV1K7W2pmLbXIGBgaWhjXTJGbGDgYGlowt0aV2YxLsCfYbTN+JHEzM+Dr2uIdJzO4JBpaMuZc6inl7goGB3TC9uBzMU8DAwMDAwMDAwF7B9LsuB9MBBhZjwd9EPxYoYPEDmKzQSAfuGwIgRuL5MAAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMPRXdmUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDCFCs7ZAAAAAElFTkSuQmCC"></td>
      <td align="center">256
(1.41%)</td>
      <td align="center">17862
(98.59%)</td>
    </tr>
    <tr>
      <td align="center">207</td>
      <td align="left">proc_date12
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-07-31
med : 2015-03-02 12:00:00
max : 2017-12-01
range : 5y 4m 1d</td>
      <td align="left" style="vertical-align:middle">164 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAJFJREFUaN7t1k0KgCAQQGGvYDfIbpD3v1uQs5kYxD/C7L3NLIIPF4bjHLXkVSG1+8pM7Ih3YKtjm1ybMVj6dIKBTYkFVSemxgkG9m9M/qoxWFRjduzxinZi+pxgYGBgYGBg62GyOhRg5oKlMUuxMeucYGBgYGBgYCWYPMljMBlgYC9imf2zHssoYJ/DwpActXQBGmgBcEwVx34AAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDD0V3ZlAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAwhQrO2QAAAABJRU5ErkJggg=="></td>
      <td align="center">176
(0.97%)</td>
      <td align="center">17942
(99.03%)</td>
    </tr>
    <tr>
      <td align="center">208</td>
      <td align="left">proc_date13
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-07-31
med : 2014-12-10
max : 2017-12-15
range : 5y 4m 15d</td>
      <td align="left" style="vertical-align:middle">120 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAJpJREFUaN7t1tEJwCAMRVFXsBtUN6j771ao+agSpGootN73IwgegmjUOTISXyTk7L4zKhbTFTCwN7Dus9vCugsEAzPCNjnJNlieO8DAwMDADLGiUc9i8b58Sax6+Caxsk6wCpO9tsFSMYCBgYEthEk3fYBpfbfCNEXHtDrBwD6EyX2wwWQAAwMD+xnW+GT0Yw0FDMwMCyZxZCQn9VXWOyyIhxMAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDD0V3ZlAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAwhQrO2QAAAABJRU5ErkJggg=="></td>
      <td align="center">123
(0.68%)</td>
      <td align="center">17995
(99.32%)</td>
    </tr>
    <tr>
      <td align="center">209</td>
      <td align="left">proc_date14
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-08-02
med : 2014-07-04 12:00:00
max : 2017-09-19
range : 5y 1m 17d</td>
      <td align="left" style="vertical-align:middle">79 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAIFJREFUaN7t1sEJwCAMQNGsYDdo3MDuv1sLaQ4WghikhfL/RYj4DnpRhDKVvk2tvUwVYIcFBgYGBgYGBnb/MXQJVg1pYGBgMRb97HNYsA0GBgYGBvYCpkEprParjxvYld/sHOanHlhwaoD5GOxjzF91CeZjMDAwMDAwsB9huiShTCeKHJlfW0Kb/AAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMPRXdmUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDCFCs7ZAAAAAElFTkSuQmCC"></td>
      <td align="center">80
(0.44%)</td>
      <td align="center">18038
(99.56%)</td>
    </tr>
    <tr>
      <td align="center">210</td>
      <td align="left">proc_date15
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-08-02
med : 2014-07-18
max : 2017-10-04
range : 5y 2m 2d</td>
      <td align="left" style="vertical-align:middle">58 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAIhJREFUaN7t17sNwCAMAFFWgA1iNgj775YCucDCSCEUCbkr+TxRICRCoJliW5LaEW/lYKUGBgYGBgYGBgYGBgYGBvZ6TPo/Yu+jPMZy/4TewcE2xMTUx5KZdrDc7j4drLTTYDthelOWYLoa7FOYeS2eYWYYbGdMb84STIfBwMDAwH6PyZICzXQBvEN8GrD4CkQAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDD0V3ZlAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAwhQrO2QAAAABJRU5ErkJggg=="></td>
      <td align="center">58
(0.32%)</td>
      <td align="center">18060
(99.68%)</td>
    </tr>
    <tr>
      <td align="center">211</td>
      <td align="left">proc_date16
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-08-02
med : 2014-07-07
max : 2017-09-04
range : 5y 1m 2d</td>
      <td align="left" style="vertical-align:middle">46 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAJNJREFUaN7t18ENgCAMhWFWwA2sG+D+u3mAHiRWKSEqyf9uNOELB5pCCKQn8ZxFctboioHtOWBgYGBgYGBg02Diew3dY5vvhGBgH2B65a8x/R5IG1Z2JwMrywQG9nusaoxkjIY2rCqn84HBwMDAwKbGdGL4sPqFVTBj1wOmZTCw6TDthCGYlsHAwMDAXsJkSALpyQEKt7TKFgOUBQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMPRXdmUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDCFCs7ZAAAAAElFTkSuQmCC"></td>
      <td align="center">47
(0.26%)</td>
      <td align="center">18071
(99.74%)</td>
    </tr>
    <tr>
      <td align="center">212</td>
      <td align="left">proc_date17
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-08-07
med : 2014-08-14
max : 2017-09-12
range : 5y 1m 5d</td>
      <td align="left" style="vertical-align:middle">32 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAH5JREFUaN7t1rERgDAIQFFWiBuIG5j9d7MAinCmSMTu/w6ir8upCO3Uxg61zrbUBOsWGBgYGBgYGBgYGNgL5j/fWoJdNt5gYGB/YfnKfsLyGgwMrBrTlGMxxlvpqQnm6x7H45jX6RgMDAwMDAxsAYuPcgkWazAwsGpMSxLa6QHkq3l1lx0wpQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMPRXdmUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDCFCs7ZAAAAAElFTkSuQmCC"></td>
      <td align="center">33
(0.18%)</td>
      <td align="center">18085
(99.82%)</td>
    </tr>
    <tr>
      <td align="center">213</td>
      <td align="left">proc_date18
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-08-07
med : 2014-07-16
max : 2017-09-11
range : 5y 1m 4d</td>
      <td align="left" style="vertical-align:middle">27 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAIpJREFUaN7t1sENgCAQRFFawA7EDqT/3jzgHNywGpBEQ/4cl+wLp8mGQHoSr1lSyRqb4mC5BAwMDAwMDAwMbGIs1S9I77C8x7b6D72Pg4GBgb3CVGAG07gNO7d3g2kMBgYG9ntM7feAme40nSnMbjlYrj7vYGBgYLNgKskhmMZgYGBg32NpSALpyQEAEZ7Pcx1hSgAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMPRXdmUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDCFCs7ZAAAAAElFTkSuQmCC"></td>
      <td align="center">27
(0.15%)</td>
      <td align="center">18091
(99.85%)</td>
    </tr>
    <tr>
      <td align="center">214</td>
      <td align="left">proc_date19
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-08-13
med : 2014-09-21 12:00:00
max : 2017-05-02
range : 4y 8m 19d</td>
      <td align="left" style="vertical-align:middle">20 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAIhJREFUaN7t18EJwCAMhWFXsBs0bqD779aLycEgioi09H9HEz88JRgCWUlsc0nNHefTxUoNGBgYGNgnMVsKsgPTgwwGBgYG9h7MJv0Y80uhxZJeGWPJPRUMDAwM7HeYbZYdmFXAwMDAwA5hNsZdh/tl5G6rYloorsNf6VfAwMDAwA5hsiWBrOQBRWGnu1wUL0cAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDD0V3ZlAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAwhQrO2QAAAABJRU5ErkJggg=="></td>
      <td align="center">20
(0.11%)</td>
      <td align="center">18098
(99.89%)</td>
    </tr>
    <tr>
      <td align="center">215</td>
      <td align="left">proc_date20
[POSIXct, POSIXt]</td>
      <td align="left">min : 2012-08-13
med : 2014-05-23
max : 2017-05-02
range : 4y 8m 19d</td>
      <td align="left" style="vertical-align:middle">19 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAH5JREFUaN7t18EJwCAMQNGsYDcw3cDuv1sP6qGhsUSKIPx/FPLwZFCEZkrPDq3lFMrBrhoYGBgYGBgYGBgY2BaYxv4DY+yM3RAMDAwMbGesbxCD6Xt5jLXpYjBzXJwLg4GBgYEtwvqrHsPsTmiYM/WB2WMwMDAwsEWY/pLQTDe8eFcqbNNvowAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMPRXdmUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDCFCs7ZAAAAAElFTkSuQmCC"></td>
      <td align="center">19
(0.1%)</td>
      <td align="center">18099
(99.9%)</td>
    </tr>
    <tr>
      <td align="center">216</td>
      <td align="left">mdro
[character]</td>
      <td align="left">1. No
2. Yes</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">17319</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">95.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">799</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJwAAAA4BAMAAAD6G4yGAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAEpJREFUWMPt1bERABAQBVEtKAEd0H9vLhAL2IjdAl5wczM/JbupQi2uDaQuJycnJ/cuB09PhvqRiysWkItHkZOTk5OT23Lw9NhZE1pHtYoDB+i2AAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAw9Fd2ZQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMIUKztkAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">217</td>
      <td align="left">anticoag
[character]</td>
      <td align="left">1. No
2. Yes</td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">16933</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">93.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1185</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">6.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAAA4BAMAAADz8Cz8AAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqb39/f///+DdZCQAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAEpJREFUWMPt1cEJACAMxdCu4AjqBrr/bkJxASUXMRngHUrhR9hNDWljfQINMTExMbEXMXRQCtJfWN6vQli+hpiYmJjYlxg6KHbWAofhryoil+ogAAAAJXRFWHRkYXRlOmNyZWF0ZQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAw9Fd2ZQAAACV0RVh0ZGF0ZTptb2RpZnkAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMIUKztkAAAAASUVORK5CYII="></td>
      <td align="center">18118
(100%)</td>
      <td align="center">0
(0%)</td>
    </tr>
    <tr>
      <td align="center">218</td>
      <td align="left">adm_to_surg
[difftime]</td>
      <td align="left">min : -1091.66666666667
med : 37.1666666666667
max : 9136.5
units : hours</td>
      <td align="left" style="vertical-align:middle">2694 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAFVJREFUaN7t2LENwCAMRFGv4IzgEcL+u0WiQ3SYLu8P8HT1ReiknD1VlY1WbIwXBoPBYDAYDAaDwWAwGAwGg8FuYp0Pc8M642AwGAwGg8F+jdWVQid9je4TY4B2afoAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDD0V3ZlAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAwhQrO2QAAAABJRU5ErkJggg=="></td>
      <td align="center">17226
(95.08%)</td>
      <td align="center">892
(4.92%)</td>
    </tr>
    <tr>
      <td align="center">219</td>
      <td align="left">adm_to_orth
[difftime]</td>
      <td align="left">min : -8739.96666666667
med : 17.5
max : 8777.45
units : hours</td>
      <td align="left" style="vertical-align:middle">2687 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAFdJREFUaN7t2UENwCAQRNG1gAXqoOvfGyiADemhJO8LeJn7ROiktq7P2r4a9mS+MBgMBoPBYDAYDAaDwWAwGAwGg8FgMNjvsMIrVsdyvw4GuxXrnxQ6aQDmUBMzfgvczQAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozOCswMTowMPRXdmUAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDCFCs7ZAAAAAElFTkSuQmCC"></td>
      <td align="center">15883
(87.66%)</td>
      <td align="center">2235
(12.34%)</td>
    </tr>
    <tr>
      <td align="center">220</td>
      <td align="left">adm_ae_diff
[difftime]</td>
      <td align="left">min : -87678.5
med : 4.9
max : 8990.56666666667
units : hours</td>
      <td align="left" style="vertical-align:middle">2603 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcm2T2WzwAAAFJJREFUaN7tzDEBgDAMAMFYAAekDoh/b62GNkzcL79dhHa6jroz81nvwaoKBoPBYDAYDAaDwWAwGAwGg8FgMBgMBoPBvsBy1YaNqveXWLYU2mkCfTMPxCtoozgAAAAldEVYdGRhdGU6Y3JlYXRlADIwMjAtMDctMjFUMDg6NTU6MzgrMDE6MDD0V3ZlAAAAJXRFWHRkYXRlOm1vZGlmeQAyMDIwLTA3LTIxVDA4OjU1OjM4KzAxOjAwhQrO2QAAAABJRU5ErkJggg=="></td>
      <td align="center">16233
(89.6%)</td>
      <td align="center">1885
(10.4%)</td>
    </tr>
    <tr>
      <td align="center">221</td>
      <td align="left">adm_leave_ae_diff
[numeric]</td>
      <td align="left">Mean (sd) : 10.8 (521.3)
min < med < max:
-26265 < 17.6 < 9002.4
IQR (CV) : 12.1 (48.3)</td>
      <td align="left" style="vertical-align:middle">2296 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent"><img style="border:none;background-color:transparent;padding:0" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAJgAAABuBAMAAAApJ8cWAAAABGdBTUEAALGPC/xhBQAAACBjSFJNAAB6JgAAgIQAAPoAAACA6AAAdTAAAOpgAAA6mAAAF3CculE8AAAAD1BMVEX////9/v2mpqby8vL///8shn5hAAAAAnRSTlMAAHaTzTgAAAABYktHRACIBR1IAAAAB3RJTUUH5AcVCTcnrjqmWQAAAFFJREFUaN7tzKEVgFAMBMG0AB1wlJD+e/tYBII8BGJWrpgqTdrel6vjvubY2d0wGAwGg8FgMBgMBoPBYDAYDAaDwWAwGAwG+wW2J3nG8kmlSQvW7BSR8ZmhqwAAACV0RVh0ZGF0ZTpjcmVhdGUAMjAyMC0wNy0yMVQwODo1NTozOSswMTowMFIgfdEAAAAldEVYdGRhdGU6bW9kaWZ5ADIwMjAtMDctMjFUMDg6NTU6MzkrMDE6MDAjfcVtAAAAAElFTkSuQmCC"></td>
      <td align="center">12863
(71%)</td>
      <td align="center">5255
(29%)</td>
    </tr>
  </tbody>
</table>
<p>Generated by <a href='https://github.com/dcomtois/summarytools'>summarytools</a> 0.9.6 (<a href='https://www.r-project.org/'>R</a> version 3.6.3)<br/>2020-07-21</p>
</div><!--/html_preserve-->


```
## 
## System: Windows 10 x64 build 18363
## Nodename: DESKTOP-JKQ7LTN, User: Darren
## Total Memory: 16168 MB
## 
## R version 3.6.3 (2020-02-29) 
## x86_64-w64-mingw32/x64 (64-bit) 
## 
## Loaded Packages: 
##  flextable (0.5.10), viridis (0.5.1), viridisLite (0.3.0), forcats (0.5.0), stringr (1.4.0), dplyr (0.8.5), purrr (0.3.4), readr (1.3.1), tidyr (1.1.0), tibble (3.0.1), ggplot2 (3.3.0), tidyverse (1.3.0), descr (1.1.4)
```



