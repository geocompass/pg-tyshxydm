CREATE OR REPLACE FUNCTION "public"."is_tyshxydm"("tyshxydm" varchar)
  RETURNS "pg_catalog"."bool" AS $BODY$
DECLARE
		is_correct      BOOLEAN;
		ysgx_18         JSON;--18位的映射关系
		jqyz_18         JSON;--18位的加权因子
--     jqyz_18         VARCHAR;
		ysgx_9          JSON;--9位的映射关系
		jqyz_9          JSON;--9位的加权因子
--     jqyz_9          VARCHAR; 
		
		Ancode          VARCHAR; --统一社会信用代码的每一个值
		Ancodevalue     int; --统一社会信用代码每一个值的权重
		total           int;
		y_arr           JSON;
		logiccheckcode  VARCHAR;
		i               int;
		checkcode       VARCHAR;
		code            VARCHAR;
		sum_rule        int;
		countSum        int;
		jymCode         int;
		elementA        int;
		elementB        int;
		elementD        int;
BEGIN
raise NOTICE '0的值为： %',is_correct ;
		is_correct := true;
		
		raise NOTICE '0的值为： %',is_correct ;
		ysgx_18 :='{"0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, 
		"9": 9, "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15, "G": 16, "H": 17, 
		"J": 18, "K": 19, "L": 20, "M": 21, "N": 22, "P": 23, "Q": 24, "R": 25, "T": 26, 
		"U": 27, "W": 28, "X": 29, "Y": 30}'::json;
		ysgx_9 :='{ "0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, 
		"8": 8, "9": 9, "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15, "G": 16, 
		"H": 17, "I": 18, "J": 19, "K": 20, "L": 21, "M": 22, "N": 23, "O": 24, "P": 25,
		"Q": 26,"R": 27, "S": 28, "T": 29, "U": 30, "V": 31, "W": 32, "X": 33, "Y": 34,
		"Z": 35}'::json;
    jqyz_18 :='{"0":1,"1":3,"2":9,"3":27,"4":19,"5":26,"6":16,"7":17,"8":20,"9":29,"10":25,"11":13,      "12":8,"13":24,"14":10,"15":30,"16":28}'::json;
    jqyz_9 :='{"0":3,"1":7,"2":9,"3":10, "4":5, "5":8, "6":4, "7":2}'::json;
		 y_arr:= '{"0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, 
		"9": 9, "10":"A" ,"11":"B" , "12":"C" ,"13" :"D" , "14":"E" , "15":"F" , "16":"G" ,"17" :"H" , 
		"18":"J" , "19":"K" ,"20" :"L" , "21":"M" , "22":"N" , "23":"P" , "24":"Q" , "25":"R" , "26":"T" , 
		"27":"U" , "28":"W" , "29":"X" , "30":"Y" }'::json;
		if(length(tyshxydm) != 18 and length(tyshxydm) != 9) THEN
				is_correct := false;
				return is_correct;
		END IF;
		--正则，判断传入的编码是否不符合规则的字符
		select tyshxydm ~ '^[0-9A-Z]+$' into is_correct;
		IF(is_correct = false) THEN
				return is_correct;
		END IF;
		--
		if (length(tyshxydm) = 18) THEN
		i:=0;
		total:=0;
		-- 循环遍历参数的每一位
	  while i < length(tyshxydm)-1  Loop
			Ancode :=substr(tyshxydm,i+1, 1);
			Ancodevalue := ysgx_18->Ancode ;
			--判断，如果Ancodevalue的值为null，则取-1
				if Ancodevalue  is NULL then
					Ancodevalue:= -1;
				end if;
				
			elementA := jqyz_18->(i)::VARCHAR;
			total := total + Ancodevalue * elementA;
			i:=i+1;
		end Loop;
		
		logiccheckcode = 31-(total % 31);
		if(logiccheckcode::int = 31) then
			logiccheckcode := 0;
		END IF ;
		
		logiccheckcode := y_arr->logiccheckcode;
		
		if(logiccheckcode::VARCHAR != substr(tyshxydm,18,1)) THEN
		    is_correct := false;
				return is_correct;
		end if;
		return is_correct;
		end if;
		if(length(tyshxydm) = 18 or length(tyshxydm) = 9) then 
			 if length(tyshxydm) =18 then 
					tyshxydm := substr(tyshxydm,9,9);
			 end if ;
			 i := 0;
			 countSum:=0;
			 while i<length(tyshxydm)-1 Loop
			 elementA:=ysgx_9->substr(tyshxydm,i+1,1);
			 elementB:=jqyz_9->i::VARCHAR;
			 sum_rule := elementA * elementB;
			 countSum :=countSum + sum_rule; 
				 i:=i+1;
			 end Loop;
			jymCode := 11 - countSum % 11;
-- 		 	raise NOTICE 'jymCode的值为： %',jymCode ;
		 if jymCode =10 then 
			 if (length(tyshxydm) =9 and  substr(tyshxydm,9, 1) = "X") then
				is_correct := true;
				return  is_correct;
				end if ;
			end if ;
-- 			raise NOTICE '17的值为： %',is_correct ;
			 if jymCode =11 then 
				 if (length(tyshxydm) =9 and  substr(tyshxydm,9, 1) = "0") then
					is_correct := true;
					end if ;
			end if ;
			  elementD := ysgx_18->substr(tyshxydm,9,1);
-- 				raise NOTICE 'd： %',d ;
				if elementD!=jymCode then 
				is_correct := false;
				return  is_correct;
				end if ;
			end if;
			return  is_correct;
END;

 $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;