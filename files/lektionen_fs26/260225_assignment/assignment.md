### Orientation
Es geht bei dieser Aufgabe darum, dass Sie lernen, einen Text mit integrierten statistischen Auswertungen und Grafiken zu erstellen. Dabei sollen ausschliesslich Open Source Werkzeuge verwendet werden. Darüber hinaus sollen Sie sich mit den Vor- und Nachteilen des Einsatzes von Open Source Software auseinandersetzen.

### Intent
I want 

* as a first priority, that you use the possibilities of Markdown and Jupyter Notebooks to perform your analysis;
* as a second priority, that you create a traceable data visualisation within your text and
* as a third priority, that you can create overview graphics and schematic representations with tools from the 'Diagrams as Code' family (Mermaid, PlantUML).

### Assignment
Write an analysis of the opportunities and risks of using open-source software in both private and corporate environments.

### Specific Requirements
#### Content
* The term *Open-Source Software* must be defined.
* The analysis should also address quantitative aspects of using open-source software. Use publicly available sources for this.
* The analysis must address the costs of using open-source software.
* The analysis must address security issues.

#### Formal Requirements
* The analysis must include all necessary directories (Contents, Sources, Tables, Figures).
* All graphics must be created within the analysis.
* Sources must be cited.
* The use of generative AI must be declared.

#### Sources

The following sources can be used for the quantitative aspects of the analysis.

1. Usage Statistics & Market Shares
   
   These sources show how deeply OSS is already rooted in infrastructure.
   
    * **GitHub – The State of the Octoverse (2025)**:    
        * **Content**: Statistics on the number of repositories, the most active languages (Python, TypeScript) and the growth of AI projects.        
        * **Key Value**: Shows enormous growth (e.g. over 395 million repositories worldwide).       
        * **Link**: [github.blog/octoverse](https://github.blog/news-insights/octoverse/)
        
    * **Linux Foundation – World of Open Source Survey (2025)**:    
        * **Content**: Focus on adoption in companies and governments.        
        * **Key Metric**: OSS penetration in areas such as Cloud (49%), Web development (46%) and AI/ML (40%).        
        * **Link**: [linuxfoundation.org/research](https://www.linuxfoundation.org/research)
        
    * **W3Techs – Web Technology Surveys**:    
        * **Content**: Real-time data on the use of web servers (Nginx, Apache) and operating systems on the web.        
        * **Link**: [w3techs.com](https://w3techs.com/)

2. Economic Aspects & Costs (TCO)

   Arguments on "licence fees vs. operating costs".

    * **State of Open Source Report (Perforce/OSI)**:    
        * **Content**: Annual survey of IT decision-makers on the reasons for using OSS.        
        * **2025 Metric**: 53% of companies cite "no licence fees/cost reduction" as the main reason (a significant increase over previous years).        
        * **Link**: [opensource.org](https://opensource.org/)
        
    * **Quandary Peak Research (2025)**:    
        * **Content**: Scientific analysis of the economic value of OSS.        
        * **Statement**: Companies would have to spend **3.5 times** as much for proprietary software to obtain the same functionality if OSS did not exist.
        

 3. Security & Risks

    These sources are essential for the "Security" section of the assignment.

    * **Synopsys (Black Duck) – Open Source Security and Risk Analysis (OSSRA) Report**:    
        * **Content**: Analysis of over 1,000 commercial codebases for security vulnerabilities and licence conflicts.        
        * **2025 Metric**: 97% of all applications contain OSS components; 81% have at least one critical security vulnerability (often due to outdated versions).        
        * **Link**: [blackduck.com/ossra](https://www.blackduck.com/blog/open-source-trends-ossra-report.html)
        
    * **Tidelift – State of the Open Source Maintainer Report**:    
        * **Content**: Highlights the "risk side" of maintenance. How many projects are managed by only one person? (Keyword: Supply Chain Security).        
        * **Link**: [tidelift.com](https://tidelift.com/)


#### Evaluation

The work will be evaluated according to the following criteria. The weighting reflects the priorities of the assignment.

| Criterion | Weight | 3 Points (Very Good) | 2 Points (Sufficient) | 1 Point (Insufficient) |
| :--- | :--- | :--- | :--- | :--- |
| **Use of Markdown and Jupyter Notebook** | 25% | Notebook is cleanly structured, code and text are meaningfully integrated, results are reproducible. | Notebook works fundamentally but has flaws in structure or reproducibility. | Notebook is incomplete, code does not run, or is separated from the text. |
| **Data Visualisation** | 20% | At least two meaningful graphics, correctly labelled, interpreted in the text and with source citation. | Graphics present, but with flaws in labelling, interpretation or source citation. | No or faulty graphics; missing reference to the text. |
| **Diagrams as Code** | 10% | At least one diagram (Mermaid/PlantUML) used meaningfully, correctly rendered and embedded in the text. | Diagram present, but with technical or content-related flaws. | No diagram or not created as code. |
| **Content Quality** | 25% | OSS term defined, opportunities and risks presented in a differentiated manner, costs and security handled soundly, sources correctly incorporated. | Essential content present, but arguments are superficial or incomplete. | Central content is missing or factually incorrect. |
| **Formal Requirements** | 10% | All directories present, sources fully cited, AI use declared, all source texts submitted. | Small gaps in directories, source citations or scope of submission. | Essential formal requirements not met. |
| **Language and Presentation** | 10% | Clear, precise expression; appropriate use of technical terminology; good readability. | Understandable, but linguistic or design improvements needed. | Difficult to understand or consistently erroneous. |

**Grading Scale:** The total score is calculated from the weighted sum. Maximum: 3.00 points. A linear grading scale applies. Grades are rounded to the nearest half-grade.

#### General Information
* **Deadline**: Submission deadline is 11 March 2026.
* **Tech Stack**: Use Jupyter Notebooks with Python and Quarto to create your final product.
* **Format**: The analysis can be submitted as a PDF or HTML. In any case, all source files used (depending on the workflow .qmd or .ipynb, as well as the .yml file and any images/data) must be submitted.
* **Basic Configuration**: Along with this assignment, you will receive a file `_quarto.yml` with a basic configuration for creating a PDF.

### Contact
For questions, I am available during lessons, via Teams or by appointment during office hours.
