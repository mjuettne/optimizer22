class FifthJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    require 'json'
    require 'matrix'

    @python_forecat_port5 = JSON.parse(`python3 lib/assets/python/forecast.py "#{args[0]}" "#{args[1]}" "#{args[2]}" "#{args[3]}" "#{args[4]}" "#{args[5]}" "#{args[6]}" "#{args[7]}" "#{args[8]}" "#{args[9]}" "#{args[10]}" "#{args[11]}" "#{args[12]}" "#{args[13]}" "#{args[14]}" "#{args[15]}" "#{args[16]}" "#{args[17]}" "#{args[18]}" "#{args[19]}" "#{args[20]}" "#{args[21]}" "#{args[22]}" "#{args[23]}" "#{args[24]}" "#{args[25]}" "#{args[26]}" "#{args[27]}" "#{args[28]}" "#{args[29]}" "#{args[30]}" "#{args[31]}" "#{args[32]}" "#{args[33]}" "#{args[34]}" "#{args[35]}" "#{args[36]}" "#{args[37]}" "#{args[38]}" "#{args[39]}" "#{args[40]}" "#{args[41]}" "#{args[42]}" "#{args[43]}" "#{args[44]}" "#{args[45]}" "#{args[46]}" "#{args[47]}" "#{args[48]}" "#{args[49]}" "#{args[50]}" "#{args[51]}" "#{args[52]}" "#{args[53]}" "#{args[54]}" "#{args[55]}" "#{args[56]}" "#{args[57]}" "#{args[58]}" "#{args[59]}" "#{args[60]}" "#{args[61]}" "#{args[62]}" "#{args[63]}" "#{args[64]}" "#{args[65]}" "#{args[66]}" "#{args[67]}" "#{args[68]}" "#{args[69]}" "#{args[70]}" "#{args[71]}" "#{args[72]}" "#{args[73]}" "#{args[74]}" "#{args[75]}" "#{args[76]}" "#{args[77]}" "#{args[78]}" "#{args[79]}" "#{args[80]}" "#{args[81]}" "#{args[82]}" "#{args[83]}" "#{args[84]}" "#{args[85]}" "#{args[86]}" "#{args[87]}" "#{args[88]}" "#{args[89]}" "#{args[90]}" "#{args[91]}" "#{args[92]}" "#{args[93]}" "#{args[94]}" "#{args[95]}" "#{args[96]}" "#{args[97]}" "#{args[98]}" "#{args[99]}" "#{args[100]}" "#{args[101]}" "#{args[102]}" "#{args[103]}" "#{args[104]}" "#{args[105]}" "#{args[106]}" "#{args[107]}" "#{args[108]}" "#{args[109]}" "#{args[110]}" "#{args[111]}" "#{args[112]}" "#{args[113]}" "#{args[114]}" "#{args[115]}" "#{args[116]}" "#{args[117]}" "#{args[118]}" "#{args[119]}" "#{args[120]}" "#{args[121]}" "#{args[122]}" "#{args[123]}" "#{args[124]}" "#{args[125]}" "#{args[126]}" "#{args[127]}" "#{args[128]}" "#{args[129]}" "#{args[130]}" "#{args[131]}" "#{args[132]}" "#{args[133]}" "#{args[134]}" "#{args[135]}" "#{args[136]}" "#{args[137]}" "#{args[138]}" "#{args[139]}" "#{args[140]}" "#{args[141]}" "#{args[142]}" "#{args[143]}" "#{args[144]}" "#{args[145]}" "#{args[146]}" "#{args[147]}" "#{args[148]}" "#{args[149]}" "#{args[150]}" "#{args[151]}" "#{args[152]}" "#{args[153]}" "#{args[154]}" "#{args[155]}" "#{args[156]}" "#{args[157]}" "#{args[158]}" "#{args[159]}" "#{args[160]}" "#{args[161]}" "#{args[162]}" "#{args[163]}" "#{args[164]}" "#{args[165]}" "#{args[166]}" "#{args[167]}" "#{args[168]}" "#{args[169]}" "#{args[170]}" "#{args[171]}" "#{args[172]}" "#{args[173]}" "#{args[174]}" "#{args[175]}" "#{args[176]}" "#{args[177]}" "#{args[178]}" "#{args[179]}" "#{args[180]}" "#{args[181]}" "#{args[182]}" "#{args[183]}"`)    
  end
end