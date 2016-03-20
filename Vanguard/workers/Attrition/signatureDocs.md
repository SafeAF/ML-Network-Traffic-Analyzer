






# Once ban engaged setup snort to detect any traffic from that banned address and log

# Snort

activate tcp any any -> 192.168.1.21 22 (content:"/bin/sh"; activates:1; \
msg:"Possible SSH buffer overflow"; )
dynamic tcp any any -> 192.168.1.21 22 (activated_by:1; count:100;)
These two rules aren't completely foolproof, but if someone were to run an exploit with shell code against an SSH
daemon, it would most likely send the string /bin/sh in the clear in order to spawn a shell on the system being attacked.
In addition, since SSH is encrypted, strings like that wouldn't be sent to the daemon under normal circumstances. Once
the first rule is triggered, it will activate the second one, which will record 100 packets and then stop. Th


For example, this specifies a logical message whenever Snort notices any traffic that is sent from 192.168.1.35:
alert tcp 192.168.1.35 any -> any any (msg:"Traffic from 192.168.1.35";


This rule will trigger when it sees the digit 0x90:
alert tcp any any -> any any (msg:"Possible
exploit"; content:"|90|";)
This digit is the hexadecimal equivalent of the NOP instruction on the x86 architecture and is often seen in exploit code
since it can be used to make buffer overflow exploits easier to write.
The offset and depth options can be used in conjunction with the content option to limit the searched portion of
the data payload to a specific range of bytes.
If you wanted to limit content matches for NOP instructions to between bytes 40 and 75 of the data portion of a packet,
you could modify the previously shown rule to look like this:
alert tcp any any -> any any (msg:"Possible
offset:40; depth:75;)

many shell code payloads can be very large compared to the normal amount of data carried in a packet sent to a
particular service. You can check the size of a packet's data payload by using the dsize optio

For example:
alert tcp any any -> any any (msg:"Possible
offset:40; depth:75; dsize: >6000;)
exploit"; content:"|90|";
\
This modifies the previous rule to match only if the data payload's size is greater than 6000 bytes, in addition to the
other options criteria.
To check the TCP flags of a packet, Snort provides the flags option. This option is especially useful for detecting
portscans that employ various invalid flag combinations.
For example, this rule will detect when the SYN and FIN flags are set at the same time:
alert any any -> any any (flags: SF,12; msg: "Possible SYN FIN scan";)
Valid flags are S for SYN, F for FIN, R for RST, P for PSH, A for ACK, and U for URG






# ModSecurity


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