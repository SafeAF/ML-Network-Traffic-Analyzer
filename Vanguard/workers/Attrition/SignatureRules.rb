https://www.owasp.org/index.php/ModSecurity_CRS_Rule_Description_Template

RULE MESSAGE
Place Rule Message Here

RULE SUMMARY
Provide rule background. What is the rule looking for? What attack is trying to identify or prevent.

    IMPACT
This should be the Severity rating specified in the rule. (Example: 4 - Warning)

RULE
Provide the entire rule/rule chain here

DETAILED RULE INFORMATION
Provide detailed information about the rule construction such as:

Why the variable list specified was used What actions are used and why
A description of the regular expression used - what is is looking for
in plain english (Example RegEx analysis from Expresso tool)


EXAMPLE PAYLOAD Provide an example payload that will trigger this rule.
 log entry or HTTP payload captured by another tool EXAMPLE AUDIT LOG ENTRY Include an example ModSecurity Audit Log Entry for when this rule matchs.

                                                                                                                                                  Audit Log Entry ATTACK SCENARIOS
                                                                                                                           Provide any data around "how" the attack is carried out.

                                                                                                                                                                                   EASE OF ATTACK
                                                                                                                           How easy is it for an attacker to carry out the attack?

                                                                                                                                            EASE OF DETECTION
                                                                                                                                            How easy is it for a defender to use ModSecurity to accurately detect this attack?

                                                                                                                                                             FALSE POSITIVES If there are any known false positives - specify them here Also sign-up for the Reporting False Positives mail-list here: https://lists.sourceforge.net/lists/listinfo/mod-security-report-false-positives

                                                                                                                                                             Send FP Report emails here: mod-security-report-false-positiveslists.sourceforge.net

                                                                                                                                                             FALSE NEGATIVES Are there any know issues with evasions or how an attacker might bypass detection?

                                                                                                                                                             RULE MATURITY
                                                                                                                                                             10 point scale (0-9) where: 0 = Beta/Experimental 9 = Heavily Tested

                                                                                                                                                             RULE ACCURACY
                                                                                                                                                             10 point scale (0-9) where: 0 = High % of FP 5 = No false positives reported

                                                                                                                                                             RULE DOCUMENTATION CONTRIBUTOR(S)
                                                                                                                                                             Specify your name and email if you want credit for the rule or documentation of it. Example: Ryan Barnett - ryan.barnettowasp.org

                                                                                                                                                                                                            ADDITIONAL REFERENCES
                                                                                                                                                                                                            Provide any external reference links (e.g. - if this is a virtual patch for a known vuln link to the Bugtraq or CVE page).