# Function to display the showLogo
# This function prints a stylized ASCII art showLogo for the t5 Server Installer
showLogo() {
    stty igncr
    clear
    printf "${COLORS[BLUE]}
                               .        ,;                            ,;           
                              ;W      f#i j.                        f#i j.         
  GEEEEEEEL                  f#E    .E#t  EW,                     .E#t  EW,        
  ,;;L#K;;.:${COLORS[RESET]},,,,,,,,,,${COLORS[BLUE]}     .E#f    i#W,   E##j       t      .DD. i#W,   E##j       
     t#E   ${COLORS[RESET]}E########D,${COLORS[BLUE]}    iWW;    L#D.    E###D.     EK:   ,WK. L#D.    E###D.     
     t#E   ${COLORS[RESET]}E#K......${COLORS[BLUE]}     L##Lffi:K#Wfff;  E#jG#W;    E#t  i#D :K#Wfff;  E#jG#W;    
     t#E   ${COLORS[RESET]}E#E${COLORS[BLUE]}          tLLG##L i##WLLLLt E#t t##f   E#t j#f  i##WLLLLt E#t t##f   
     t#E   ${COLORS[RESET]}E#Wfffff:${COLORS[BLUE]}      ,W#i   .E#L     E#t  :K#E: E#tL#i    .E#L     E#t  :K#E: 
     t#E   ${COLORS[RESET]}jLLLE##t${COLORS[BLUE]}      j#E.      f#E:   E#KDDDD###iE#WW,       f#E:   E#KDDDD###i
     t#E      ${COLORS[RESET]};#K,${COLORS[BLUE]}     .D#j         ,WW;  E#f,t#Wi,,,E#K:         ,WW;  E#f,t#Wi,,,
     t#E     ${COLORS[RESET]}j#D.${COLORS[BLUE]}     ,WK,           .D#; E#t  ;#W:  ED.           .D#; E#t  ;#W:  
      fE    ${COLORS[RESET]}G#f${COLORS[BLUE]}       EG.              tt DWi   ,KK: t               tt DWi   ,KK: 
       :   ${COLORS[RESET]}D#;${COLORS[BLUE]}        ,                                                            
           ${COLORS[RESET]}G:${COLORS[BLUE]}                                                                      
    ${COLORS[RESET]}
      ╔═══════════════════════════════════════════════════════════════════════════╗
      ║  ${COLORS[RED]}Name:${COLORS[GREY]} T5 Server Installer${COLORS[RESET]}                                                ║
      ║  ${COLORS[YELLOW]}Version:${COLORS[GREY]} 1.0.0${COLORS[RESET]}                                                           ║
      ║  ${COLORS[PURPLE]}Author:${COLORS[GREY]} Sterbweise${COLORS[RESET]}                                                       ║
      ║  ${COLORS[GREEN]}Last Updated:${COLORS[GREY]} 12/12/2024${COLORS[RESET]}                                                 ║
      ╠═══════════════════════════════════════════════════════════════════════════╣
      ║                       ${COLORS[LIGHT_BLUE]}\e]8;;https://github.com/Sterbweise\aGithub\e]8;;\a${COLORS[RESET]} | ${COLORS[RED]}\e]8;;https://youtube.com/@Sterbweise\aYoutube\e]8;;\a${COLORS[RESET]} | ${COLORS[ORANGE]}\e]8;;https://plutonium.pw\aPlutonium\e]8;;\a${COLORS[RESET]}                        ║
      ╚═══════════════════════════════════════════════════════════════════════════╝\n\n"
}