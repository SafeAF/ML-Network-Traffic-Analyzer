# Development
Projects underway using our inhouse semi formalized agilesque development methodolgy "Dexterity". BareMetal Management and Team goals include Fostering open communication, ownership and pride in work, self organization, happy people, high productivity and code quality

NOTIFY_ARGS=(--session
             --dest org.freedesktop.Notifications
             --object-path /org/freedesktop/Notifications)
## Attrition.IO Top Tier Project 

### Distributed and Aggregated IPS


### Suggested audit controls ###
Content of Audit Records
Response to Audit Processing Failures
Audit Reduction and Report Generation
Timestamps
Protection of Audit Information
Non-repudiation
Audit Generation
Session Audit
Alternate Audit Capability
Note that not all of these will be necessary in all environments.

### How and why to invest in detection of intrusions

__Detecting intrusions requires three elements:__

the capability to log security-relevant events
procedures to ensure the logs are monitored regularly
procedures to properly respond to an intrusion once detected
You should log all security relevant information. Perhaps you can detect a problem by reviewing the logs that you couldn't detect at runtime. But you must log enough information. In particular, all use of security mechanisms should be logged, with enough information to help track down the offender. Additionally, the logging functionality in the application should also provide a method of managing the logged information. If the security analyst is unable to parse through the event logs to determine which events are actionable, then logging events provide little to no value.

Detecting intrusions is important because otherwise you give the attacker unlimited time to perfect an attack. If you detect intrusions perfectly, then an attacker will only get one attempt before he is detected and prevented from launching more attacks. Remember, if you receive a request that a legitimate user could not have generated - it is an attack and you should respond appropriately. Logging provides a forensic function for your application/site. If it is brought down or hacked, you can trace the culprit and check what went wrong. If the user uses an anonymizing proxy, having good logs will still help as "what happened" is logged and the exploit can be fixed more easily.

Don't rely on other technologies to detect intrusions. Your code is the only component of the system that has enough information to truly detect attacks. Nothing else will know what parameters are valid, what actions the user is allowed to select, etc. It must built into the application.


### Suggested solutions or remediations

The Council on CyberSecurity Critical Security Controls includes Maintenance, Monitoring and Analysis of Audit Logs as one of the twenty critical controls. The implementation guidance for this control includes validation of audit log settings (CSC 14-2) as one of the "quick wins". This element deals with the content and format of log data generated by the application. It should be easy to see why this is necessary to support access controls, incident response and compliance requirements. Other implementation elements of this control that would be reflected directly in software requirements for coding include:

Validation of audit log settings (CSC 14-2)
Centralized log aggregation and analysis tools (CSC 14-8)
Ability to specify events to be monitored (CSC 14-9)
Response to log collection failures (CSC 14-10)


### More controls

What is a control
As an abstract category of concepts, it can be difficult to grasp where controls fit into the collection of policies, procedures, and standards that create the structures of governance, management, practices and patterns necessary to secure software and data. Where each of these conceptual business needs is addressed through documentation with differing levels of specificity, it is useful to look at where controls fit in relation to these other structures. Security controls can be categorized in several ways. One useful breakdown is the axis that includes administrative, technical and physical controls. Controls in each of these areas support the others. Another useful breakdown is along the categories of preventive, detective and corrective.

ISACA defines control as the means of managing risk, including policies, procedures, guidelines, practices or organizational structures, which can be of an administrative, technical, management, or legal nature.[1]

While the ISACA COBIT standard is frequently referenced with regard to information security control, the design of the standard places its guidance mostly at the level of governance with very little that will help us design or implement secure software. U.S. National Institute of Standards and Technology (NIST) Special Publication 800-53, Security and Privacy Controls for Federal Information Systems and Organizations is widely referenced for its fairly detailed catalog of security controls. It does not, however, define what a control should be.

The Council on CyberSecurity Critical Security Controls list provides very little detail on specific measures we can implement in software. Among the 20 critical controls we find "Application Software Security" with 11 recommended implementation measures:

Patching
Implement a Web Application Firewall (WAF)
Error checking all input
Use an automated scanner to look for security weaknesses
Output sanitization of error messages
Segregation development and production environments
Secure code analysis, manual and automated
Verify vendor security processes
Database configuration hardening
Train developers on writing secure code
Remove development artifacts from production code
Of these 11, it is interesting to note that two relate to infrastructure architecture, four are operational, two are part of testing processes, and only three are things that are done as part of coding.

While many controls are definitely of a technical nature, it is important to distinguish the way in which controls differ from coding techniques. Many things we might think of as controls, should more properly be put into coding standards or guidelines. As an example, NIST SP800-53 suggests five controls related to session management:

Concurrent Session Control
Session Lock
Session Termination
Session Audit
Session Authenticity
Note that three of these are included within the category of Access Controls. In most cases, NIST explicitly calls for the organization to define some of the elements of how these controls should be implemented.

In contrast, the OWASP Session_Management_Cheat_Sheet does a very good job at illustrating session management implementation techniques and suggests some standards. These kinds of standards and guidelines spell out specific implementation of controls.

While different organizations and standards will write controls at differing levels of abstraction, it is generally recognized that controls should be defined and implemented to address business needs for security. COBIT 5 makes this explicit by mapping enterprise goals to IT-related goals, process goals, management practices and activities. The management practices map to items that were described in COBIT 4 as control objectives. Each organization and process area will define their controls differently, but this alignment of controls to objectives and activities is a strong commonality between different standards. Activities are often the means by which controls are implemented. They are written out in procedures that specify the intended operation of controls. A procedure is not, in itself, a control. A given procedure may address multiple controls and a given control may require more than one procedure to fully implement.

So, we've found that the concept of a security control is hard to define clearly in a way that enables practitioners to begin writing controls and putting them to use. Some definitions exist, but are open to wide interpretation and may not be adaptable to every need. At this point we can hazard some statements that may provide further clarity. Control statements should be concisely worded to specify required process outcomes. While this is very similar to a policy statement, policies are generally more oriented toward enterprise goals, whereas controls are more oriented toward process goals.

A control differs from a standard in that the standard is focused on requirements for specific tools that may be used, coding structures, or techniques.

Figure 1 - Relationship of control statements to control objectives and other documentation

Necessary controls in an application should be identified using risk assessment. Threat modeling is one component of risk assessment that examines the threats, vulnerabilities and exposures of an application. Threat modeling will help to identify many of the technical controls necessary for inclusion within the application development effort. It should be combined with other risk assessment techniques that also take into account the larger organizational impacts of the application.

Examples of controls


### Attack types

https://www.owasp.org/index.php/Architectural_Principles_That_Prevent_Code_Modification_or_Reverse_Engineering

Application Integrity Threats
Attackers can now leverage reverse-engineering / code modification attack techniques inside mobile device applications to realize the following threats:

Spoofing Identity
Attackers may attempt to modify the mobile application code on a victim’s device to force the application to transmit a user’s authentication credentials (username and password) to a third party malicious site. Hence, the attacker can masquerade as the user in future transactions;
Tampering
Attackers may wish to alter higher-level business logic embedded within the application to gain some additional value for free. For instance, an attacker may alter digital rights management code embedded in a mobile application to attain digital assets like music for free;
Repudiation
Attackers may disable logging or auditing controls embedded within the mobile application to prevent an organization from verifying that the user performed particular transactions;
Information Disclosure
Attackers may modify a mobile application to disclose highly sensitive assets contained within the mobile application. Assets of interest include: digital keys, certificates, credentials, metadata, and proprietary algorithms;
Denial of Service
Attackers may alter a mobile device application and force it to periodically crash or permanently disable itself to prevent the user from accessing online services through their device; and
Elevation of Privilege
Attackers may modify a mobile application and redistribute it in a repackaged form to perform actions that are outside of the scope of what the user should be able to do with the app.