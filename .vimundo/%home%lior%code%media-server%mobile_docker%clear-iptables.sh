Vim�UnDo� �z�lR'�ܣA �b��&�o#;J����px��      $ipt -S                             W�hW    _�                             ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                   5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 echo "5�_�                       0    ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 1echo "Stopping firewall and allowing everyone..."5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 ipt="5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 ipt="/sbin/iptables"5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 [5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 	[ ! -x "]5�_�      	                     ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 [ ! -x "$ipt"]5�_�      
           	          ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 [ ! -x "$ipt" ]5�_�   	              
          ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 [ ! -x "$ipt" ] && {5�_�   
                        ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 [ ! -x "$ipt" ] && { echo "}5�_�                       #    ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 %[ ! -x "$ipt" ] && { echo "$0: \"${"}5�_�                       &    ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 )[ ! -x "$ipt" ] && { echo "$0: \"${ipt}"}5�_�                       <    ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 >[ ! -x "$ipt" ] && { echo "$0: \"${ipt}\" command not found."}5�_�                       G    ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �                 H[ ! -x "$ipt" ] && { echo "$0: \"${ipt}\" command not found."; exit 1; }5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �      	         $ipt -P OUTPUT ACCEPT�      
         $ipt -F�   	            $ipt -X�   
            $ipt -t nat -F�               $ipt -t nat -X�               $ipt -t mangle -F5�_�                    	       ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �   
            $ipt -t nat -F�   	            $ipt -X�      
         $ipt -F5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �               $ipt iptables -t raw -F5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�g�    �               $ipt iptables -t raw -F5�_�                          ����                                                                                                                                                                                                                                                                                                                                                             W�h"     �                 $ipt -t raw -X5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�h(     �                 iptabl5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�h(     �                 itabl5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             W�h*     �                 iabl5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             W�h,     �                  5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             W�h2    �                5�_�                            ����                                                                                                                                                                                                                                                                                                                                                             W�hV    �                 $ipt -S5�_�                           ����                                                                                                                                                                                                                                                                                                                                                             W�g�     �   
            $ipt t nat -F5��