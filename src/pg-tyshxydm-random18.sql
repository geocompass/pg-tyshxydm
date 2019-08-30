-----------------------------随机18位社会代码--------------------------------------------------------
CREATE OR REPLACE FUNCTION "public"."random_tyshxydm_18"("xzqh" varchar)
  RETURNS "pg_catalog"."varchar" AS $BODY$
DECLARE
-- 		is_correct      BOOLEAN;
		ysgx_18         JSON;--18位的映射关系
		jqyz_18         JSON;--18位的加权因子
		ysgx_9          JSON;--9位的映射关系
		ysdm_9          JSON;
		ysdm_18         JSON;
		jqyz_9          JSON;--9位的加权因子
		djglb           varchar[]; -- 登记管理部
		jglx            JSON; --机构类型
		btdm            VARCHAR; -- 9位的本体代码
		random_dm       VARCHAR;
		validate_dm     INTEGER;
		i 							INTEGER;
		total 					INTEGER;
		
BEGIN
		i :=0;
		total :=0;
		djglb := ARRAY['1','2','3','4','5','6','7','8','9','A','B', 'C', 'D', 'E', 'F', 'G','Y'];
		jglx := '{"1":[1,2,3,9],"2":[1,2,3,9],"3":[1,2,3,9],"4":[1],"5":[1],"6":[1],"7":[1],"8":[1],"9":[1],
						"A":[1],"B":[1],"C":[1],"D":[1],"E":[1],"F":[1],"G":[1],"Y":[1]}'::json;
		ysgx_18 :='{"0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, 
							"9": 9, "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15, "G": 16, "H": 17, 
							"J": 18, "K": 19, "L": 20, "M": 21, "N": 22, "P": 23, "Q": 24, "R": 25, "T": 26, 
							"U": 27, "W": 28, "X": 29, "Y": 30}'::json;
		ysgx_9 :='{ "0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, 
						"8": 8, "9": 9, "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15, "G": 16, 
						"H": 17, "I": 18, "J": 19, "K": 20, "L": 21, "M": 22, "N": 23, "O": 24, "P": 25,
						"Q": 26,"R": 27, "S": 28, "T": 29, "U": 30, "V": 31, "W": 32, "X": 33, "Y": 34,
						"Z": 35}'::json;
		ysdm_9 := '["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
							"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", 
							"K", "L", "M", "N", "O", "P","Q","R", "S", "T", 
							"U", "V", "W", "X", "Y","Z"]'::json;
		ysdm_18 := '["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
								"A", "B", "C", "D", "E", "F", "G", "H", "J", 
								"K", "L", "M", "N",  "P","Q","R",  "T", 
								"U",  "W", "X", "Y"]'::json;
		jqyz_18 :='[1, 3, 9, 27, 19, 26, 16, 17, 20, 29, 25, 13, 8, 24, 10, 30, 28]'::json;
		jqyz_9 :='[3, 7, 9, 10, 5, 8, 4, 2]'::json;
		--本体代码
		btdm := djglb[ceil(random()*17)::integer];
		btdm := btdm || '1'; --机构类型暂不随机
		btdm := btdm || xzqh;
		btdm := btdm || random_tyshxydm_9();
		random_dm := '';
		WHILE i < 17 LOOP
			
			total := total + (jqyz_18 -> i)::text::INTEGER	* ((ysgx_18 -> substr(btdm, i+1, 1))::text::INTEGER);
-- 			raise notice 'btdm 为： % ',ysgx_9 -> substr(btdm, i+1, 1);
			i := i + 1;
		END LOOP;
		i := 0;
		validate_dm := 31 -  total % 31;
		
		if validate_dm = 31 THEN
			validate_dm = 0;
		end if;
		btdm := btdm || (ysdm_18 -> validate_dm);
		return replace(btdm,'"','');
END;
 $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
  
  
  
