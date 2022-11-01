# fdd-bigburp

![R](https://img.shields.io/badge/r-%23276DC3.svg?style=for-the-badge&logo=r&logoColor=white)

As a challenge submission to Gitcoin Open Data Science, Big Burp is a data-backed exploratory analysis into how text processing and analysis can potentially be utilized to grade grants for their eligibility.

# Table of Contents

- [Introduction](#introduction)
- [Methodology](#methodology)
- [Results](#results)
- [Discussion](#discussion)
- [Contributing](#contributing)

# Introduction

As part of the Gitcoin grants review process, human incentives are very much relied on. By doing so, there exists a level of transparency, equitability, and inclusivity that an algorithm will likely fall short of. The reason being is that 

Big Burp takes a look at one key factor of this grants application process: the project description. This serves as the _first impression_ a reviewer has on a project. Based off the results of Gitcoin Grants Round 15, Big Burp aims to provide insight into what forms of applications, with respect to their project descriptions, are approved and denied.

How can text processing and analysis be potentially utilized to grade grants for their eligibility?

# Methodology

The essence of Big Burp is calculating the term frequency-inverse document frequency (TF-IDF) of the project description. This metric is a statistical measure of the weight a word has with respect to:

- a larger phrase or sentence it is a part of, and
- other individual words, phrases, and sentences.

By measuring both its independent and relative frequency, it answers the question of how significant and relevant a word is. 

1. To start, the data set used is the provided `grants_applications_gr15`. This can be retrieved [here](https://drive.google.com/drive/folders/17OdrV7SA0I56aDMwqxB6jMwoY3tjSf5w). Attempts are made to make the data easier to manipulate and interpret in R.

2. After the data is subset into relevant information (i.e. title, approved, description), the project descriptions are split into individual words. Their relation to the aforementioned relevant information remains intact. Thereafter, significant efforts are made to clean the data. Steps include:

- removing rows with words that are likely not part of the English dictionary,
- removing rows with project descriptions that include numbers, and
- removing rows with project descriptions that include special characters and URLs.

# Results

1. Between 808 grant applications for Gitcoin Grants Round 15, 448 (55.45%) were accepted. 360 (44.55%) were denied.
2. As visualized below, the top 50 most common words that comprised project descriptions were:

 <img src="https://i.imgur.com/Rvc8mAu.png" width="800"/>
 
### Approved Projects
 
3. As the above does not indicate whether or not these words correlate with project approval, visualized below is the top 28 (~55%) most common words comprising project descriptions of approved projects:

<img src="https://i.imgur.com/2rk1uwx.png" width="800"/>

4. Between the approved projects, the five least relevant keywords were:
```
research (n = 1, tf_idf = 6.928), education (n = 1, tf_idf = 0.012), information (n = 1, tf_idf = 0.018), creating (n = 1, tf_idf = 0.027), organizations (n = 1, tf_idf = 0.027)
```

5. As follows, the five most unique (i.e. distinctive) keywords were:
```
offends (n = 1, tf_idf = 6.928), aggressively (n = 1, tf_idf = 6.928), ported (n = 1, tf_idf = 6.523), outs (n = 1, tf_idf = 6.928), hatch (n = 1, tf_idf = 6.012)
```

6. Now, the five most relevant keywords were:
```
review (n = 21, tf_idf = 1.15), cognitive (n = 19, tf_idf = 2.414), research (n = 15, tf_idf = 0.164), property (n = 14, tf_idf = 1.453), action (n = 13, tf_idf = 0.589)
```

7. Diving deeper into the lattermost metric, visualized below is a graph of the relevance of other words, relative to other approved project descriptions, used in the projects who have keywords ranking in the top three:

<img src="https://i.imgur.com/e9BlGfA.png" width="800"/>
<img src="https://i.imgur.com/Kbf9gG9.png" width="800"/>
<img src="https://i.imgur.com/yWTsXFF.png" width="800"/>

### Denied Projects

8. As follows, visualized below is the top 22 (~44%) most common words comprising project descriptions of denied projects:

<img src="https://i.imgur.com/21AMuf3.png" width="800"/>

9. Between the denied projects, the five least relevant keywords were:

```research, education, crypto, information, creating```

10. As follows, the five most unique (i.e. distinctive) keywords were:

```lyrics, cancelled, impersonated, fathers, direly```

11. Now, the five most relevant keywords were:

```coffee, combustion, translated, editor, converter```

12. Diving deeper into the lattermost metric, visualized below is a graph of the relevance of other words, relative to other approved project descriptions, used in the projects who have keywords ranking in the top three:

<img src="https://i.imgur.com/Mqfy9xY.png" width="800"/>
<img src="https://i.imgur.com/OwM5WUv.png" width="800"/>
<img src="https://i.imgur.com/U56QNTN.png" width="800"/>

# Contributing

[Zachary Will Sy](https://www.linkedin.com/in/zwcsy/)<br>
Junior at Purdue University, IN<br>

BSc Computer Science – Specialization in Security<br>
BA Political Science – Public Policy and Methodologies in Tech<br>

Email: alpinemail (at) zsy (dot) sh<br>
Discord: zachio (hashtag) 1557
