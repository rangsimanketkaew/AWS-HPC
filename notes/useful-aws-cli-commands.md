# Useful AWS CLI Commands

## Prerequisites

- AWS CLI

## AWS Spot price

- Spot price history

```
aws ec2 describe-spot-price-history \
    --start-time $(date -u +"%Y%m%dT%H0000") \
    --product "Linux/UNIX" \
    --instance-type "c5.xlarge" \
    --region us-east-1 \
    --output table
```

Output:

```
-------------------------------------------------------------------------------------------------------
|                                      DescribeSpotPriceHistory                                       |
+-----------------------------------------------------------------------------------------------------+
||                                         SpotPriceHistory                                          ||
|+------------------+---------------+---------------------+------------+-----------------------------+|
|| AvailabilityZone | InstanceType  | ProductDescription  | SpotPrice  |          Timestamp          ||
|+------------------+---------------+---------------------+------------+-----------------------------+|
||  us-east-1d      |  c5.xlarge    |  Linux/UNIX         |  0.077100  |  2019-11-03T14:18:52.000Z   ||
||  us-east-1c      |  c5.xlarge    |  Linux/UNIX         |  0.077400  |  2019-11-03T13:11:51.000Z   ||
||  us-east-1b      |  c5.xlarge    |  Linux/UNIX         |  0.076200  |  2019-11-03T11:48:36.000Z   ||
||  us-east-1f      |  c5.xlarge    |  Linux/UNIX         |  0.066600  |  2019-11-03T08:52:22.000Z   ||
||  us-east-1a      |  c5.xlarge    |  Linux/UNIX         |  0.079300  |  2019-11-02T23:23:00.000Z   ||
|+------------------+---------------+---------------------+------------+-----------------------------+|
```

You can specify start and end date.

```
aws ec2 describe-spot-price-history \
        --instance-types c5.xlarge \
        --product-description "Linux/UNIX (Amazon VPC)" \
        --start-time 2019-10-06T07:08:09 \
        --end-time 2019-11-06T08:09:10 \
        --output table
```

Output:

```
-------------------------------------------------------------------------------------------------------
|                                      DescribeSpotPriceHistory                                       |
+-----------------------------------------------------------------------------------------------------+
||                                         SpotPriceHistory                                          ||
|+------------------+---------------+---------------------+------------+-----------------------------+|
|| AvailabilityZone | InstanceType  | ProductDescription  | SpotPrice  |          Timestamp          ||
|+------------------+---------------+---------------------+------------+-----------------------------+|
||  us-east-1d      |  c5.xlarge    |  Linux/UNIX         |  0.078400  |  2019-11-02T07:02:52.000Z   ||
||  us-east-1b      |  c5.xlarge    |  Linux/UNIX         |  0.077100  |  2019-11-02T06:21:21.000Z   ||
||  us-east-1c      |  c5.xlarge    |  Linux/UNIX         |  0.078100  |  2019-11-02T05:23:06.000Z   ||
||  us-east-1f      |  c5.xlarge    |  Linux/UNIX         |  0.067300  |  2019-11-02T05:05:57.000Z   ||
||  us-east-1a      |  c5.xlarge    |  Linux/UNIX         |  0.080400  |  2019-11-02T02:26:51.000Z   ||
||  us-east-1c      |  c5.xlarge    |  Linux/UNIX         |  0.078200  |  2019-11-02T00:38:24.000Z   ||
||  us-east-1b      |  c5.xlarge    |  Linux/UNIX         |  0.076900  |  2019-11-01T23:39:34.000Z   ||
||  us-east-1d      |  c5.xlarge    |  Linux/UNIX         |  0.078600  |  2019-11-01T23:30:52.000Z   ||
||  us-east-1f      |  c5.xlarge    |  Linux/UNIX         |  0.067400  |  2019-11-01T22:15:25.000Z   ||
||  us-east-1a      |  c5.xlarge    |  Linux/UNIX         |  0.080000  |  2019-11-01T19:02:51.000Z   ||
||  us-east-1d      |  c5.xlarge    |  Linux/UNIX         |  0.078500  |  2019-11-01T18:46:21.000Z   ||
||  us-east-1b      |  c5.xlarge    |  Linux/UNIX         |  0.076500  |  2019-11-01T18:29:23.000Z   ||
||  us-east-1c      |  c5.xlarge    |  Linux/UNIX         |  0.078100  |  2019-11-01T18:21:23.000Z   ||
||  us-east-1f      |  c5.xlarge    |  Linux/UNIX         |  0.067500  |  2019-11-01T16:07:23.000Z   ||
||  us-east-1a      |  c5.xlarge    |  Linux/UNIX         |  0.079700  |  2019-11-01T13:44:52.000Z   ||
||  us-east-1c      |  c5.xlarge    |  Linux/UNIX         |  0.078300  |  2019-11-01T12:12:52.000Z   ||
||  us-east-1d      |  c5.xlarge    |  Linux/UNIX         |  0.078100  |  2019-11-01T11:30:53.000Z   ||
||  us-east-1f      |  c5.xlarge    |  Linux/UNIX         |  0.067400  |  2019-11-01T10:15:22.000Z   ||
||  us-east-1a      |  c5.xlarge    |  Linux/UNIX         |  0.080000  |  2019-11-01T07:03:04.000Z   ||
||  us-east-1c      |  c5.xlarge    |  Linux/UNIX         |  0.078600  |  2019-11-01T05:55:51.000Z   ||
||  us-east-1d      |  c5.xlarge    |  Linux/UNIX         |  0.078200  |  2019-11-01T05:05:53.000Z   ||
||  us-east-1b      |  c5.xlarge    |  Linux/UNIX         |  0.076800  |  2019-11-01T05:05:53.000Z   ||
||  us-east-1f      |  c5.xlarge    |  Linux/UNIX         |  0.067000  |  2019-11-01T03:08:21.000Z   ||
|+------------------+---------------+---------------------+------------+-----------------------------+|
```

- Estimate spot price per month

```
I=c5.xlarge ; printf "\$%.2f/mo\n" $(echo "$(aws ec2 describe-spot-price-history --instance-types $I --start-time=$(date +%s) --product-descriptions="Linux/UNIX" | jq -r '.SpotPriceHistory[0].SpotPrice') * 24 * 30" | bc)
```

Output:

```
$55.51/mo
```

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
