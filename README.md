# fdd-bigburp

![R](https://img.shields.io/badge/r-%23276DC3.svg?style=for-the-badge&logo=r&logoColor=white)

As a challenge submission to Gitcoin Open Data Science, Big Burp is a data-backed exploratory analysis into how text processing and analysis can potentially be utilized to grade grants for their eligibility.

<img src="https://i.imgur.com/JlrZUC0.png" width="400"/>

# Table of Contents

- [Introduction](#introduction)
- [Methodology](#methodology)
- [Results](#results)
- [Discussion](#discussion)
- [Conclusion](#conclusion)
- [Contributing](#contributing)

# Introduction

As part of the Gitcoin grants review process, human incentives are very much relied on. By doing so, there exists a level of transparency, equitability, and inclusivity that an algorithm will likely fall short of.

Big Burp takes a look at one key factor of this grants application process: the project description. This serves as the _first impression_ a reviewer has on a project. Based off the results of Gitcoin Grants Round 15, Big Burp aims to provide insight into what forms of applications, with respect to their project descriptions, are approved and denied.

**How can text processing and keyword analysis be potentially utilized to grade grants for their eligibility?**

# Methodology

The essence of Big Burp is calculating the term frequency-inverse document frequency (TF-IDF) of the project description. This metric is a statistical measure of the weight a word has with respect to:

- a larger phrase or sentence it is a part of, and
- other individual words, phrases, and sentences.

By measuring both its independent and relative frequency, it answers the question of how significant and relevant a word is. 

1. To start, the data set used is the provided `grants_applications_gr15`. This can be retrieved [here](https://drive.google.com/drive/folders/17OdrV7SA0I56aDMwqxB6jMwoY3tjSf5w). Attempts are made to make the data easier to manipulate and interpret in R.

2. After the data is subset into relevant information (i.e. title, approved, description), the project descriptions are split into individual words. Their relation to the aforementioned relevant information remains intact. Thereafter, significant efforts are made to clean the data. Steps include:

- removing rows with words that are likely not part of the English dictionary,
- removing rows that include numbers, and
- removing rows that include special characters and URLs.

# Results

1. Between 808 grant applications for Gitcoin Grants Round 15, 448 (55.45%) were accepted. 360 (44.55%) were denied.
2. As visualized below, the top 50 most common words that comprised project descriptions were:

 <img src="https://i.imgur.com/Rvc8mAu.png" width="800"/>
 
### Approved Projects
 
3. As the above does not indicate whether or not these words correlate with project approval, visualized below is the top 28 (~55%) most common words comprising project descriptions of approved projects:

<img src="https://i.imgur.com/2rk1uwx.png" width="800"/>

4. Between the approved projects, the five least relevant keywords were:

```research (n = 1, tf_idf = 0.012), education (n = 1, tf_idf = 0.012), information (n = 1, tf_idf = 0.018), creating (n = 1, tf_idf = 0.027), organizations (n = 1, tf_idf = 0.027)```

5. As follows, the five most unique (i.e. distinctive) keywords were:

```offends (n = 1, tf_idf = 6.928), aggressively (n = 1, tf_idf = 6.928), ported (n = 1, tf_idf = 6.523), outs (n = 1, tf_idf = 6.928), hatch (n = 1, tf_idf = 6.012)```

6. Now, the five most relevant keywords were:

```review (n = 21, tf_idf = 1.15), cognitive (n = 19, tf_idf = 2.414), research (n = 15, tf_idf = 0.164), property (n = 14, tf_idf = 1.453), action (n = 13, tf_idf = 0.589)```

7. Diving deeper into the lattermost metric, visualized below is a graph of the relevance of other words, relative to other approved project descriptions, used in the projects who have keywords ranking in the top three:

<img src="https://i.imgur.com/e9BlGfA.png" width="800"/>
<img src="https://i.imgur.com/Kbf9gG9.png" width="800"/>
<img src="https://i.imgur.com/yWTsXFF.png" width="800"/>

### Denied Projects

8. As follows, visualized below is the top 22 (~44%) most common words comprising project descriptions of denied projects:

<img src="https://i.imgur.com/21AMuf3.png" width="800"/>

9. Between the denied projects, the five least relevant keywords were:

```research (n = 1, tf_idf = 0.012), education (n = 1, tf_idf = 0.017), crypto (n = 1, tf_idf = 0.017), information (n = 1, tf_idf = 0.021), creating (n = 1, tf_idf = 0.025)```

10. As follows, the five most unique (i.e. distinctive) keywords were:

```lyrics (n = 1, tf_idf = 7.621), cancelled (n = 1, tf_idf = 7.621), impersonated (n = 1, tf_idf = 6.928), fathers (n = 1, tf_idf = 6.928), direly (n = 1, tf_idf = 6.928)```

11. Now, the five most relevant keywords were:

```coffee (n = 29, tf_idf = 2.607), combustion (n = 18, tf_idf = 3.884), translated (n = 18, tf_idf = 3.116), editor (n = 15, tf_idf = 2.261), converter (n = 14, tf_idf = 3.884)```

12. Diving deeper into the lattermost metric, visualized below is a graph of the relevance of other words, relative to other denied project descriptions, used in the projects who have keywords ranking in the top three:

<img src="https://i.imgur.com/Mqfy9xY.png" width="800"/>
<img src="https://i.imgur.com/OwM5WUv.png" width="800"/>
<img src="https://i.imgur.com/U56QNTN.png" width="800"/>

# Discussion

With respect to the entire data set, each word's TF-IDF can be modeled as a distribution. What this allows us to conclude is the assumption of the application of [Zipf's law](https://en.wikipedia.org/wiki/Zipf%27s_law). Zipf, an American linguist, stated that the frequency that a word appears is inversely proportional to its rank.

In the calculations performed above, `n` represents the significant frequency a word has. `tf_idf` is its combined independent and relative score. Mathematically, this can be calcuated as:

<img src="https://monkeylearn.com/static/e791e1f0a45f11873c2a849987c38252/64bef/1.webp" width="800"/>
<img src="https://monkeylearn.com/static/ef94a0124c99f471176df096a9ea692a/64bef/2.webp" width="800"/>
<img src="https://monkeylearn.com/static/b233220f6fc177312a39e57ede405f3f/905c1/3.webp" width="800"/>

<sub>Retrieved from: [MonkeyLearn](https://monkeylearn.com/)</sub>

Now, the results visualized above show notable observations that can be made from the data, specifically:

- finding the top used keywords in project descriptions represent common use cases, purposes, and ideas that applicants pitch to Gitcoin,
- finding the top used keywords in **approved** project descripions may open discussions on preferred current and predicted industry trends, and 
- finding the top used keywords in **denied** project descriptions may offer insight into lesser preferred or relevant topics at a given period.

As for the focus of the exploratory analysis, the `tf_idf`, broken into three parts:

1. least relevant keywords ```(n = 1, tf_idf = 0.0xy)```

- there exist common least relevant keywords between approved and denied projects
- the `tf_idf` is inconsequential, relative to the entire scale

2. most unique keywords ```(n = 1, tf_idf > 6.xyz)```

- the `tf_idf` of these words are among the highest in the entire data set

3. most relevant keywords ```(n > 10, tf_idf > 0.1)```

- the `n` of these words are among the highest in the entire data set

Now, notice that the most relevant keywords category, with respect to its `tf_idf` scale, somewhat exists in between the least relevant keywords category and the most unique keywords category.

# Conclusion

With the points discussed and notable observations in mind, the following conclusions can be made:

1. Projects within the sphere of education seem to be common between approved and denied projects.

- a reason for this might be that education continues to play a large role in the growing adoption of the blockchain in the real-world, and
- there is no shortage of initiatives in the space that continue to inform and develop different aspects of Web 3 knowledge.

2. There seems to be a focus in social, connections, credibility, and work in approved projects.

- a reason for this might be the increasingly popular take that wallets are immutable Web 3 identities,
- as it becomes prevalent that the blockchain proves advantageous in the real-world through its ability to instantaneously and permanently retain a traceable record of events, social platforms such as Lens Protocol, DeSo, and Mirror continue to grow rapidly in its user base,
- in fact, Jack Dorsey (co-founder of Twitter) is building Bluesky, a social internet built on the blockchain with these identities. 

3. Denied projects seem to be broader in nature, containing keywords such as crypto and application. Additionally, there exists some concentration in the keywords creators and minted.

- a reason for this might be the timing of the grants round, where during this period, NFTs were at its bear,
- as the keywords creators and minted likely relate to NFTs, little interest was paid attention as their long-term feasibility, legitimacy, and adoption were questioned, and
- as for the keywords crypto and application, broader projects might just fail to fill a current need in the space.

4. Approved and denied projects share some common least relevant keywords.

- as mentioned in the first point, these might refer to the more prevalent themes that individuals in the space identify as a problem needing a solution.

5. Notably, the most relevant keywords show some form of relation between their definition and whether or not their project is accepted or denied.

- arguably, it could be said that these keywords hold the heaviest weight in swaying their project application's decision,
- keywords such as cognitive, research, and property are buzzwords that easily attract attention given their timely relation to both the space and industry, and
- keywords such as coffee, combustion, and translated likely hold little relevance and relation to either the space or industry.

6. As visualized by the graphs in orange, a pattern is revealed with the way project descriptions are phrased and how words are used, relative to their project acceptance.

- with accepted projects, a healthy and varying distribution of a selection of relevant words is seen, and
- with denied projects, an over-congestion of somewhat off-topic words is seen.

**Thus, bringing all these points together, there are arguments to be made that:**

- applicants must pay significant attention to how they phrase their project desciription, what words they use, and how it shines a light on the project's timeliness and widespread potential. All these together, they hold significant weight in their project's acceptance into a given Gitcoin grants round.
- by utilizing project descriptions as an eligibility signal, Big Burp's text processing and keyword analysis can crucially better assist grant reviewers by cutting through the noise and identifying what is important, relative to other project applications.

_<sub>Personal note: given time constraints, I was not able to extend the exploration to sentiment analysis and the [Flesch–Kincaid readability tests](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests). As I had hoped to do so originally, I would be very much interested in seeing what work I would produce for said aspect if given the opportunity.</sub>_

# Contributing

[Zachary Will Sy](https://www.linkedin.com/in/zwcsy/)<br>
Junior at Purdue University, IN<br>

BSc Computer Science – Specialization in Security<br>
BA Political Science – Public Policy and Methodologies in Tech<br>

Email: alpinemail (at) zsy (dot) sh<br>
Discord: zachio (hashtag) 1557
