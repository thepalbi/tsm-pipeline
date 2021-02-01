module TsmRepr {
    float getReprScore(string repr, string t){
     repr = "(parameter 0 (member query *))" and t = "snk" and result = 0.9310344828 or
     repr = "(parameter 0 (member findOne *))" and t = "snk" and result = 0.3750000000 or
     repr = "(member where (parameter 0 (member findOne *)))" and t = "snk" and result = 0.2500000000 or
     repr = "(member id (member where *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member run *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member all *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member each *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 1 (member run *))" and t = "snk" and result = 0.2500000000 or
     repr = "(parameter 0 (member all *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member get *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 0 (member each *))" and t = "snk" and result = 1.0000000000 or
     repr = "(parameter 1 (member query *))" and t = "snk" and result = 0.5000000000 or
     repr = "(parameter 0 (member create *))" and t = "snk" and result = 0.2500000000
     } 
  }
  