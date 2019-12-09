.. _converting:

=======================
Converting data to BIDS
=======================

.. raw:: html

    <style> .blue {color:blue} </style>
    <style> .red {color:red} </style>

.. role:: blue
.. role:: red

Benefits of using BIDS format
=============================

BIDS is a standard and widely-used format of structuring data. It facilities:

* **Using and re-using data:** by arranging data in a standard way, using datasets collaboratively within and across labs will be facilitated (no need to rearrange data). It also facilitates future usages of the same datasets (easier to figure out old codes).
* **Data analysis:** There are several software packages that accept only BIDS format as input -- such as fMRIprep and MRIQC. And the number of these BIDS apps are growing. 
* **Sharing data:** Data sharing is an important element of reproducible science and a standard data sharing formatting is required for this purpose. Currently OpenNeuro accepts datasets in BIDS format. Some grants require public data sharing and using BIDS from the beginning of data collection can save time and energy at the time of sharing. 
* **Checking data integrity:** By validating your data structure through bids-validator, potential problems or errors in the data can be discovered.

`Find out more about BIDS data specifications here <https://bids-specification.readthedocs.io/en/stable/>`_.

.. image:: ../images/return_to_timeline.png
  :width: 300
  :align: center
  :alt: return to timeline
  :target: 02-01-overview.html

















