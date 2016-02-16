require 'rubygems'
require 'inline'
require 'pcaplet'

class Libsniffer
inline :C do |builder|
	# prefix required for structs, #defines and #includes
	builder.prefix %q{
		#include <stdio.h>
		#include <pcap.h>
		#include <string.h>
		#include <stdlib.h>
		#include <ctype.h>
		#include <errno.h>
		#include <sys/types.h>
		#include <sys/socket.h>
		#include <netinet/in.h>
		#include <arpa/inet.h>
		#define SNAP_LEN 1518
		#define SIZE_ETHERNET 14
		#define ETHER_ADDR_LEN	6
		struct sniff_ethernet {
        	u_char  ether_dhost[ETHER_ADDR_LEN];
        	u_char  ether_shost[ETHER_ADDR_LEN];
        	u_short ether_type;
			};
		struct sniff_ip {
        	u_char  ip_vhl;
        	u_char  ip_tos;
        	u_short ip_len;
        	u_short ip_id;
        	u_short ip_off;
        	#define IP_RF 0x8000
        	#define IP_DF 0x4000
        	#define IP_MF 0x2000
        	#define IP_OFFMASK 0x1fff
        	u_char  ip_ttl;
        	u_char  ip_p;
        	u_short ip_sum;
        	struct  in_addr ip_src, ip_dst;
			};
		#define IP_HL(ip)               (((ip)->ip_vhl) & 0x0f)
		#define IP_V(ip)                (((ip)->ip_vhl) >> 4)
		typedef u_int tcp_seq;
		struct sniff_tcp {
        	u_short th_sport;
        	u_short th_dport;
        	tcp_seq th_seq;
        	tcp_seq th_ack;
        	u_char  th_offx2;
			#define TH_OFF(th)      (((th)->th_offx2 & 0xf0) >> 4)
        	u_char  th_flags;
        	#define TH_FIN  0x01
       		#define TH_SYN  0x02
        	#define TH_RST  0x04
        	#define TH_PUSH 0x08
        	#define TH_ACK  0x10
        	#define TH_URG  0x20
        	#define TH_ECE  0x40
        	#define TH_CWR  0x80
        	#define TH_FLAGS        (TH_FIN|TH_SYN|TH_RST|TH_ACK|TH_URG|TH_ECE|TH_CWR)
        	u_short th_win;
        	u_short th_sum;
        	u_short th_urp;
			};
		FILE *logfile;
		}

builder.c %q{
	void got_packet(u_char *args, const struct pcap_pkthdr *header, const 	u_char *packet) {
	static int count = 1;                   /* packet counter */
	
	/* declare pointers to packet headers */
	const struct sniff_ethernet *ethernet;  /* The ethernet header [1] */
	const struct sniff_ip *ip;              /* The IP header */
	const struct sniff_tcp *tcp;            /* The TCP header */
	const char *payload;                    /* Packet payload */

	int size_ip;
	int size_tcp;
	int size_payload;
	
	printf("\nPacket number %d:\n", count);
	count++;
	
	/* define ethernet header */
	ethernet = (struct sniff_ethernet*)(packet);
	
	/* define/compute ip header offset */
	ip = (struct sniff_ip*)(packet + SIZE_ETHERNET);
	size_ip = IP_HL(ip)*4;
	if (size_ip < 20) {
		printf("   * Invalid IP header length: %u bytes\n", size_ip);
		return;
	}

	/* print source and destination IP addresses */
	printf("       From: %s\n", inet_ntoa(ip->ip_src));
	printf("         To: %s\n", inet_ntoa(ip->ip_dst));
	
	/* determine protocol */	
	switch(ip->ip_p) {
		case IPPROTO_TCP:
			printf("   Protocol: TCP\n");
			break;
		case IPPROTO_UDP:
			printf("   Protocol: UDP\n");
			return;
		case IPPROTO_ICMP:
			printf("   Protocol: ICMP\n");
			return;
		case IPPROTO_IP:
			printf("   Protocol: IP\n");
			return;
		default:
			printf("   Protocol: unknown\n");
			return;
	}
	
	/*
	 *  OK, this packet is TCP.
	 */
	
	/* define/compute tcp header offset */
	tcp = (struct sniff_tcp*)(packet + SIZE_ETHERNET + size_ip);
	size_tcp = TH_OFF(tcp)*4;
	if (size_tcp < 20) {
		printf("   * Invalid TCP header length: %u bytes\n", size_tcp);
		return;
		}
	
	printf("   Src port: %d\n", ntohs(tcp->th_sport));
	printf("   Dst port: %d\n", ntohs(tcp->th_dport));
	
	/* define/compute tcp payload (segment) offset */
	payload = (u_char *)(packet + SIZE_ETHERNET + size_ip + size_tcp);
	
	/* compute tcp payload (segment) size */
	size_payload = ntohs(ip->ip_len) - (size_ip + size_tcp);
	
	if (size_payload > 0) {
		printf("   Payload (%d bytes):\n", size_payload);
		// write capture to log file
		fprintf(logfile, "%s::%s::%d::%d~~~", inet_ntoa(ip->ip_src), inet_ntoa(ip->ip_dst), ntohs(tcp->th_sport), ntohs(tcp->th_dport) );
		const u_char *ch = payload;
		int i;
		for (i = 0; i < size_payload; i++) {
			fprintf(logfile, "%02x", *ch);
			ch++;
			}
		fprintf(logfile, "\n");
		}
	return;
	}
	}
builder.c %q{
	void sniff(char *interface, char *filter, char *log_location) {
		char errbuf[PCAP_ERRBUF_SIZE];
		pcap_t *handle;
		struct bpf_program fp;
		bpf_u_int32 net_mask;
		bpf_u_int32 net_ip;
		struct pcap_pkthdr header;
		logfile = fopen(log_location, "w");

	handle = pcap_open_live(interface, BUFSIZ, 0, 1000, errbuf);
	if (handle == NULL) {
		fprintf(stderr, "Couldn't open interface %s: %s\n", interface, errbuf);
		return(2);
		}
	// get device details
	if (pcap_lookupnet(interface, &net_ip, &net_mask, errbuf) == -1) {
		fprintf(stderr, "Couldn't get netmask for device %s: %s\n", interface, errbuf);
		net_ip = 0;
		net_mask = 0;
		}
	// compile filter
	if (pcap_compile(handle, &fp, filter, 0, net_ip) == -1) {
		fprintf(stderr, "Couldn't parse filter %s: %s\n", filter, 				pcap_geterr(handle));
		return(2);
		}
	// set filter
	if (pcap_setfilter(handle, &fp) == -1) {
		fprintf(stderr, "Couldn't install filter %s: %s\n", 		 				filter, pcap_geterr(handle));
		return(2);
		}
	printf("Interface: %s\n", interface);
	printf("Filter: %s\n", filter);
	printf("Log Location: %s\n", log_location);
	printf("got_packet address: %x\n", got_packet);
	pcap_loop(handle, -1, *got_packet, NULL);
	pcap_freecode(&fp);
	pcap_close(handle);
	return;
	}

	}
end
end
