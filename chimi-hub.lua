--[[
   ____   _       _               _     _   _           _     
  / ___| | |__   (_)  _ __ ___   (_)   | | | |  _   _  | |__  
 | |     | '_ \  | | | '_ ` _ \  | |   | |_| | | | | | | '_ \ 
 | |___  | | | | | | | | | | | | | |   |  _  | | |_| | | |_) |
  \____| |_| |_| |_| |_| |_| |_| |_|   |_| |_|  \__,_| |_.__/                                                           
]]--

local v0 = tonumber;
local v1 = string.byte;
local v2 = string.char;
local v3 = string.sub;
local v4 = string.gsub;
local v5 = string.rep;
local v6 = table.concat;
local v7 = table.insert;
local v8 = math.ldexp;
local v9 = getfenv or function()
	return _ENV;
end;
local v10 = setmetatable;
local v11 = pcall;
local v12 = select;
local v13 = unpack or table.unpack;
local v14 = tonumber;
local function v15(v16, v17, ...)
	local v18 = 1;
	local v19;
	v16 = v4(v3(v16, 5), "..", function(v30)
		if (v1(v30, 2) == 81) then
			v19 = v0(v3(v30, 1, 1));
			return "";
		else
			local v81 = v2(v0(v30, 16));
			if v19 then
				local v90 = 0;
				local v91;
				while true do
					if (v90 == 1) then
						return v91;
					end
					if (v90 == 0) then
						v91 = v5(v81, v19);
						v19 = nil;
						v90 = 1;
					end
				end
			else
				return v81;
			end
		end
	end);
	local function v20(v31, v32, v33)
		if v33 then
			local v82 = (v31 / ((5 - (3 - 0)) ^ (v32 - (2 - 1)))) % ((3 - 1) ^ (((v33 - (2 - (1066 - (68 + 997)))) - (v32 - (620 - (555 + (1334 - (226 + 1044)))))) + (932 - (857 + 74))));
			return v82 - (v82 % (569 - (367 + 201)));
		else
			local v83 = 927 - (214 + 713);
			local v84;
			while true do
				if (v83 == (0 + 0)) then
					v84 = (1 + 1) ^ (v32 - (878 - (282 + 595)));
					return (((v31 % (v84 + v84)) >= v84) and (1638 - (1523 + 114))) or ((0 - 0) + 0);
				end
			end
		end
	end
	local function v21()
		local v34 = v1(v16, v18, v18);
		v18 = v18 + 1;
		return v34;
	end
	local function v22()
		local v35 = (297 - (67 + 113)) - (32 + 85);
		local v36;
		local v37;
		while true do
			if (v35 == (1 + 0)) then
				return (v37 * (469 - 213)) + v36;
			end
			if (v35 == 0) then
				v36, v37 = v1(v16, v18, v18 + 1 + 1);
				v18 = v18 + (959 - (892 + 65));
				v35 = 1;
			end
		end
	end
	local function v23()
		local v38, v39, v40, v41 = v1(v16, v18, v18 + 3 + 0);
		v18 = v18 + (9 - 5);
		return (v41 * 16777216) + (v40 * (48199 + 17337)) + (v39 * (1017 - 761)) + v38;
	end
	local function v24()
		local v42 = v23();
		local v43 = v23();
		local v44 = 953 - (802 + 150);
		local v45 = (v20(v43, 2 - 1, 36 - (454 - (145 + 293))) * ((2 + 0) ^ (1029 - (915 + 82)))) + v42;
		local v46 = v20(v43, (489 - (44 + 386)) - 38, 19 + 12);
		local v47 = ((v20(v43, 41 - 9) == (1188 - (1069 + 118))) and -1) or (2 - 1);
		if (v46 == (0 - 0)) then
			if (v45 == ((1486 - (998 + 488)) + 0)) then
				return v47 * (0 - 0);
			else
				local v92 = 0 + 0;
				while true do
					if (v92 == ((252 + 539) - (368 + 423))) then
						v46 = 1;
						v44 = 0 - 0;
						break;
					end
				end
			end
		elseif (v46 == (2065 - (10 + 8))) then
			return ((v45 == (0 - 0)) and (v47 * (1 / (442 - (416 + 26))))) or (v47 * NaN);
		end
		return v8(v47, v46 - (3266 - 2243)) * (v44 + (v45 / ((1 + 1) ^ ((75 + 16) - 39))));
	end
	local function v25(v48)
		local v49;
		if not v48 then
			v48 = v23();
			if (v48 == (772 - (201 + 571))) then
				return "";
			end
		end
		v49 = v3(v16, v18, (v18 + v48) - (1139 - (116 + 1022)));
		v18 = v18 + v48;
		local v50 = {};
		for v65 = 4 - 3, #v49 do
			v50[v65] = v2(v1(v3(v49, v65, v65)));
		end
		return v6(v50);
	end
	local v26 = v23;
	local function v27(...)
		return {...}, v12("#", ...);
	end
	local function v28()
		local v51 = (function()
			return 611 - (210 + 401);
		end)();
		local v52 = (function()
			return;
		end)();
		local v53 = (function()
			return;
		end)();
		local v54 = (function()
			return;
		end)();
		local v55 = (function()
			return;
		end)();
		local v56 = (function()
			return;
		end)();
		local v57 = (function()
			return;
		end)();
		local v58 = (function()
			return;
		end)();
		while true do
			if (0 ~= v51) then
			else
				local v87 = (function()
					return 0;
				end)();
				while true do
					if (2 == v87) then
						v51 = (function()
							return 1;
						end)();
						break;
					end
					if (v87 == (1821 - (1483 + 338))) then
						v52 = (function()
							return function(v108, v109, v110)
								local v111 = (function()
									return 1695 - (1229 + 466);
								end)();
								local v112 = (function()
									return;
								end)();
								while true do
									if (v111 == 0) then
										v112 = (function()
											return 578 - (386 + 192);
										end)();
										while true do
											if (0 == v112) then
												local v121 = (function()
													return 1206 - (696 + 510);
												end)();
												while true do
													if (v121 ~= (0 - 0)) then
													else
														v108[v109 - #"\\"] = (function()
															return v110();
														end)();
														return v108, v109, v110;
													end
												end
											end
										end
										break;
									end
								end
							end;
						end)();
						v53 = (function()
							return {};
						end)();
						v87 = (function()
							return 1;
						end)();
					end
					if (v87 ~= 1) then
					else
						v54 = (function()
							return {};
						end)();
						v55 = (function()
							return {};
						end)();
						v87 = (function()
							return 2;
						end)();
					end
				end
			end
			if (v51 == (1263 - (1091 + 171))) then
				local v88 = (function()
					return 0 + 0;
				end)();
				while true do
					if (v88 ~= 2) then
					else
						v51 = (function()
							return 6 - 4;
						end)();
						break;
					end
					if (v88 == (3 - 2)) then
						v58 = (function()
							return {};
						end)();
						for v103 = #"~", v57 do
							local v104 = (function()
								return 374 - (123 + 251);
							end)();
							local v105 = (function()
								return;
							end)();
							local v106 = (function()
								return;
							end)();
							local v107 = (function()
								return;
							end)();
							while true do
								if (v104 ~= (0 - 0)) then
								else
									v105 = (function()
										return 0;
									end)();
									v106 = (function()
										return nil;
									end)();
									v104 = (function()
										return 699 - (208 + 490);
									end)();
								end
								if (v104 == 1) then
									v107 = (function()
										return nil;
									end)();
									while true do
										if (v105 ~= (0 + 0)) then
										else
											local v119 = (function()
												return 0 + 0;
											end)();
											while true do
												if ((837 - (660 + 176)) == v119) then
													v105 = (function()
														return 1 + 0;
													end)();
													break;
												end
												if (v119 ~= 0) then
												else
													v106 = (function()
														return v21();
													end)();
													v107 = (function()
														return nil;
													end)();
													v119 = (function()
														return 203 - (14 + 188);
													end)();
												end
											end
										end
										if (v105 == (676 - (534 + 141))) then
											if (v106 == #"}") then
												v107 = (function()
													return v21() ~= 0;
												end)();
											elseif (v106 == 2) then
												v107 = (function()
													return v24();
												end)();
											elseif (v106 == #"19(") then
												v107 = (function()
													return v25();
												end)();
											end
											v58[v103] = (function()
												return v107;
											end)();
											break;
										end
									end
									break;
								end
							end
						end
						v88 = (function()
							return 1 + 1;
						end)();
					end
					if (v88 == 0) then
						v56 = (function()
							return {v53,v54,nil,v55};
						end)();
						v57 = (function()
							return v23();
						end)();
						v88 = (function()
							return 1 + 0;
						end)();
					end
				end
			end
			if (v51 == 2) then
				v56[#"91("] = (function()
					return v21();
				end)();
				for v93 = #"~", v23() do
					local v94 = (function()
						return 0;
					end)();
					local v95 = (function()
						return;
					end)();
					while true do
						if (v94 == 0) then
							v95 = (function()
								return v21();
							end)();
							if (v20(v95, #"{", #"~") == 0) then
								local v113 = (function()
									return 0;
								end)();
								local v114 = (function()
									return;
								end)();
								local v115 = (function()
									return;
								end)();
								local v116 = (function()
									return;
								end)();
								while true do
									if (v113 == 2) then
										if (v20(v115, #"}", #"~") ~= #".") then
										else
											v116[2 + 0] = (function()
												return v58[v116[2]];
											end)();
										end
										if (v20(v115, 2, 2) == #"~") then
											v116[#"asd"] = (function()
												return v58[v116[#"xnx"]];
											end)();
										end
										v113 = (function()
											return 3;
										end)();
									end
									if (v113 == (6 - 3)) then
										if (v20(v115, #"-19", #"asd") ~= #"[") then
										else
											v116[#"?id="] = (function()
												return v58[v116[#"asd1"]];
											end)();
										end
										v53[v93] = (function()
											return v116;
										end)();
										break;
									end
									if (v113 == 1) then
										local v118 = (function()
											return 0;
										end)();
										while true do
											if (v118 ~= (1 - 0)) then
											else
												v113 = (function()
													return 2;
												end)();
												break;
											end
											if (v118 == (0 - 0)) then
												v116 = (function()
													return {v22(),v22(),nil,nil};
												end)();
												if (v114 == (0 + 0)) then
													local v126 = (function()
														return 0;
													end)();
													while true do
														if (0 ~= v126) then
														else
															v116[#"91("] = (function()
																return v22();
															end)();
															v116[#"?id="] = (function()
																return v22();
															end)();
															break;
														end
													end
												elseif (v114 == #"|") then
													v116[#"xnx"] = (function()
														return v23();
													end)();
												elseif (v114 == (398 - (115 + 281))) then
													v116[#"91("] = (function()
														return v23() - ((4 - 2) ^ (14 + 2));
													end)();
												elseif (v114 ~= #"asd") then
												else
													local v378 = (function()
														return 0;
													end)();
													local v379 = (function()
														return;
													end)();
													while true do
														if (v378 == 0) then
															v379 = (function()
																return 0 - 0;
															end)();
															while true do
																if (v379 == (0 - 0)) then
																	v116[#"xxx"] = (function()
																		return v23() - ((869 - (550 + 317)) ^ (22 - 6));
																	end)();
																	v116[#".dev"] = (function()
																		return v22();
																	end)();
																	break;
																end
															end
															break;
														end
													end
												end
												v118 = (function()
													return 1;
												end)();
											end
										end
									end
									if (0 == v113) then
										v114 = (function()
											return v20(v95, 2 - 0, #"xxx");
										end)();
										v115 = (function()
											return v20(v95, #"0313", 6);
										end)();
										v113 = (function()
											return 2 - 1;
										end)();
									end
								end
							end
							break;
						end
					end
				end
				for v96 = #"{", v23() do
					v54, v96, v28 = (function()
						return v52(v54, v96, v28);
					end)();
				end
				return v56;
			end
		end
	end
	local function v29(v59, v60, v61)
		local v62 = v59[(590 - (300 + 4)) - (134 + 151)];
		local v63 = v59[1 + 1];
		local v64 = v59[1668 - (970 + 695)];
		return function(...)
			local v67 = v62;
			local v68 = v63;
			local v69 = v64;
			local v70 = v27;
			local v71 = 1;
			local v72 = -(1 - 0);
			local v73 = {};
			local v74 = {...};
			local v75 = v12("#", ...) - ((7 - 4) - 2);
			local v76 = {};
			local v77 = {};
			for v85 = 0 - 0, v75 do
				if (v85 >= v69) then
					v73[v85 - v69] = v74[v85 + (3 - 2)];
				else
					v77[v85] = v74[v85 + ((2187 - (112 + 250)) - (1195 + 629))];
				end
			end
			local v78 = (v75 - v69) + ((1 + 0) - 0);
			local v79;
			local v80;
			while true do
				local v86 = 241 - (187 + 54);
				while true do
					if ((v86 == (0 - 0)) or (393 >= 4242)) then
						v79 = v67[v71];
						v80 = v79[781 - (162 + 618)];
						v86 = 1 + 0;
					end
					if (v86 == (1 + 0)) then
						if (v80 <= (19 + 16)) then
							if ((v80 <= (12 + 5)) or (86 >= 3626)) then
								if (v80 <= (16 - 8)) then
									if ((2395 == 2395) and (v80 <= (4 - 1))) then
										if (v80 <= (1 + 0)) then
											if ((989 < 4859) and (v80 == (1636 - (1373 + 263)))) then
												v77[v79[1002 - (451 + 549)]][v79[1 + 2]] = v77[v79[5 - 1]];
											else
												local v129 = v79[2 - (0 + 0)];
												local v130 = v77[v79[1387 - (746 + 638)]];
												v77[v129 + 1 + 0] = v130;
												v77[v129] = v130[v79[5 - 1]];
											end
										elseif (v80 > (343 - (218 + 123))) then
											if (v77[v79[(785 + 798) - (1535 + 46)]] == v79[4 + 0]) then
												v71 = v71 + 1 + 0 + 0;
											else
												v71 = v79[2 + 1];
											end
										else
											v77[v79[562 - (306 + 254)]] = v61[v79[(1415 - (1001 + 413)) + 2]];
										end
									elseif (v80 <= ((19 - 10) - 4)) then
										if (v80 == (1471 - (899 + 568))) then
											local v136 = 0 + 0;
											local v137;
											while true do
												if (((0 - 0) == v136) or (4795 < 949)) then
													v137 = v79[605 - (268 + 335)];
													v77[v137] = v77[v137](v13(v77, v137 + (2 - 1), v79[293 - (60 + 230)]));
													break;
												end
											end
										else
											local v138 = 0 - 0;
											local v139;
											local v140;
											local v141;
											while true do
												if (v138 == (573 - (426 + 146))) then
													v141 = {};
													v140 = v10({}, {__index=function(v341, v342)
														local v343 = v141[v342];
														return v343[1][v343[1 + 1]];
													end,__newindex=function(v344, v345, v346)
														local v347 = 1456 - (282 + 1174);
														local v348;
														while true do
															if ((3780 > 2709) and (v347 == (811 - (569 + 242)))) then
																v348 = v141[v345];
																v348[2 - 1][v348[1 + 1]] = v346;
																break;
															end
														end
													end});
													v138 = 1026 - (706 + 318);
												end
												if ((3842 == 3842) and ((1996 - (109 + 1885)) == v138)) then
													for v349 = 1252 - (721 + 530), v79[1275 - (945 + 326)] do
														local v350 = 0 - 0;
														local v351;
														while true do
															if ((1747 <= 3601) and (v350 == (1 + 0))) then
																if (v351[1] == (735 - (271 + 429))) then
																	v141[v349 - (1 + 0)] = {v77,v351[3 + 0]};
																else
																	v141[v349 - (1289 - (993 + 295))] = {v60,v351[1174 - (418 + 753)]};
																end
																v76[#v76 + 1] = v141;
																break;
															end
															if (v350 == (0 + 0)) then
																v71 = v71 + 1 + 0;
																v351 = v67[v71];
																v350 = 1 + 0;
															end
														end
													end
													v77[v79[1 + 1]] = v29(v139, v140, v61);
													break;
												end
												if (v138 == (0 + 0)) then
													v139 = v68[v79[532 - (406 + 123)]];
													v140 = nil;
													v138 = 1;
												end
											end
										end
									elseif ((v80 <= (1775 - (1749 + (622 - (512 + 90))))) or (237 >= 2273) or (804 > 4359)) then
										local v142 = 0 + 0;
										local v143;
										local v144;
										while true do
											if ((v142 == (1323 - (1249 + 73))) or (2040 <= 703)) then
												for v352 = v143 + 1 + 0, v79[1437 - (797 + 636)] do
													v144 = v144 .. v77[v352];
												end
												v77[v79[9 - 7]] = v144;
												break;
											end
											if ((4670 >= 3623) and (v142 == (1619 - (1427 + 192)))) then
												v143 = v79[1148 - (466 + 679)];
												v144 = v77[v143];
												v142 = 1 + 0;
											end
										end
									elseif ((2065 < 2544) and (v80 == (16 - 9))) then
										local v255 = v79[(1908 - (1665 + 241)) + 0];
										local v256 = {v77[v255](v13(v77, v255 + (2 - 1), v72))};
										local v257 = 1900 - (106 + 1794);
										for v317 = v255, v79[3 + 1] do
											v257 = v257 + 1 + 0;
											v77[v317] = v256[v257];
										end
									else
										local v258 = v79[1 + 1];
										v77[v258] = v77[v258]();
									end
								elseif ((1311 <= 3359) and (v80 <= (35 - (740 - (373 + 344))))) then
									if ((3279 <= 3967) and (v80 <= (27 - 17))) then
										if (v80 > 9) then
											v77[v79[116 - (4 + 110)]] = v79[1809 - (1202 + 604)] ~= (584 - (57 + 238 + 289));
										elseif ((v79[1429 - (41 + 1386)] == v77[v79[107 - (17 + 86)]]) or (1988 == 877)) then
											v71 = v71 + 1 + 0 + 0;
										else
											v71 = v79[6 - 3];
										end
									elseif ((2717 <= 3156) and (v80 > 11)) then
										local v146 = v79[2 + 0];
										local v147 = {v77[v146](v77[v146 + 1])};
										local v148 = 166 - (122 + 44);
										for v228 = v146, v79[6 - 2] do
											v148 = v148 + 1;
											v77[v228] = v147[v148];
										end
									else
										local v149 = v79[6 - 4];
										local v150 = {};
										for v231 = 1 - 0, #v76 do
											local v232 = v76[v231];
											for v261 = 0 + 0, #v232 do
												local v262 = v232[v261];
												local v263 = v262[1 + (0 - 0)];
												local v264 = v262[3 - 1];
												if ((v263 == v77) and (v264 >= v149)) then
													v150[v264] = v263[v264];
													v262[66 - (30 + 35)] = v150;
												end
											end
										end
									end
								elseif ((4291 > 1912) and (v80 <= ((1109 - (35 + 1064)) + 4))) then
									if (v80 == (1270 - (1043 + 214))) then
										v77[v79[7 - 5]] = v77[v79[1951 - (798 + 298 + 852)]][v79[2 + 2]];
									elseif ((1081 < 4524) and (2003 < 2339) and (v77[v79[1214 - (323 + 889)]] == v77[v79[10 - 6]])) then
										v71 = v71 + (581 - (361 + 219));
									else
										v71 = v79[323 - (53 + 267)];
									end
								elseif ((440 >= 71) and (v80 <= (4 + 11))) then
									if ((432 == 432) and v77[v79[415 - (15 + 398)]]) then
										v71 = v71 + (983 - (18 + 964));
									else
										v71 = v79[1320 - (1114 + 203)];
									end
								elseif ((4934 > 2607) and (v80 == ((128 - 68) - 44))) then
									local v267 = v79[1 + 1 + 0];
									local v268 = v77[v79[2 + 1]];
									v77[v267 + 1 + 0] = v268;
									v77[v267] = v268[v79[4]];
								else
									local v272 = 850 - (20 + 830);
									local v273;
									local v274;
									local v275;
									while true do
										if (v272 == (1 + 0)) then
											v275 = 126 - (116 + 10);
											for v380 = v273, v79[1909 - (830 + 1075)] do
												local v381 = 0 + 0;
												while true do
													if (v381 == (738 - (542 + 196))) then
														v275 = v275 + 1;
														v77[v380] = v274[v275];
														break;
													end
												end
											end
											break;
										end
										if ((v272 == (0 - 0)) or (1145 >= 1253)) then
											v273 = v79[1 + 1];
											v274 = {v77[v273](v13(v77, v273 + 1 + 0, v72))};
											v272 = 1;
										end
									end
								end
							elseif ((v80 <= (68 - 42)) or (1400 > 3116)) then
								if ((525 < 1662) and (v80 <= (53 - 32))) then
									if ((v80 <= (1570 - ((2362 - (298 + 938)) + (1684 - (233 + 1026))))) or (876 > 2550)) then
										if ((219 <= 2456) and (v80 == ((2089 - (636 + 1030)) - (118 + 287)))) then
											local v153 = 0 - 0;
											local v154;
											local v155;
											local v156;
											local v157;
											while true do
												if (v153 == (1122 - (118 + 1003))) then
													v72 = (v156 + v154) - ((2 + 0) - (1 + 0));
													v157 = (112 + 265) - (142 + 235);
													v153 = 6 - 4;
												end
												if ((v153 == (9 - 7)) or (4219 == 1150)) then
													for v356 = v154, v72 do
														local v357 = 0 + 0;
														while true do
															if (v357 == (158 - (7 + 84 + 67))) then
																v157 = v157 + (978 - (553 + 424));
																v77[v356] = v155[v157];
																break;
															end
														end
													end
													break;
												end
												if (v153 == (0 + 0)) then
													v154 = v79[3 - 1];
													v155, v156 = v70(v77[v154](v13(v77, v154 + 1 + 0, v79[3 + 0])));
													v153 = 1 + 0;
												end
											end
										else
											v77[v79[773 - (326 + (666 - (55 + 166)))]][v79[1 + 1 + 1]] = v79[8 - 4];
										end
									elseif (((3418 > 2118) and (v80 == (9 + 11))) or (2989 <= 222)) then
										local v160 = v79[2];
										v77[v160](v77[v160 + 1 + 0]);
									else
										local v161 = v79[4 - 2];
										local v162, v163 = v70(v77[v161](v77[v161 + (2 - 1)]));
										v72 = (v163 + v161) - 1;
										local v164 = 0 - 0;
										for v233 = v161, v72 do
											v164 = v164 + 1 + 0;
											v77[v233] = v162[v164];
										end
									end
								elseif (v80 <= (111 - 88)) then
									if ((2258 > 1241) and (v80 > (50 - 28))) then
										local v165 = 753 - (239 + 514);
										local v166;
										while true do
											if ((3066 <= 3890) and (v165 == (0 + 0))) then
												v166 = v79[(134 + 1197) - (797 + 532)];
												v77[v166](v13(v77, v166 + 1 + 0, v79[2 + (3 - 2)]));
												break;
											end
										end
									else
										v77[v79[4 - 2]]();
									end
								elseif ((41 < 4259) and (v80 <= 24)) then
									if (not v77[v79[1204 - (373 + 829)]] or (1930 < 56)) then
										v71 = v71 + (732 - ((773 - (36 + 261)) + 255));
									else
										v71 = v79[1133 - (369 + 761)];
									end
								elseif ((3333 == 3333) and (v80 > (15 + 10))) then
									local v277 = v68[v79[5 - 2]];
									local v278;
									local v279 = {};
									v278 = v10({}, {__index=function(v322, v323)
										local v324 = 0 - 0;
										local v325;
										while true do
											if ((v324 == (238 - (64 + 174))) or (2998 >= 3281)) then
												v325 = v279[v323];
												return v325[1 + 0][v325[2 - 0]];
											end
										end
									end,__newindex=function(v326, v327, v328)
										local v329 = v279[v327];
										v329[337 - (144 + 192)][v329[218 - (42 + 174)]] = v328;
									end});
									for v331 = 1 + 0, v79[2 + 2] do
										v71 = v71 + 1 + 0;
										local v332 = v67[v71];
										if (v332[1 + 0] == (15 + (1303 - (1035 + 248)))) then
											v279[v331 - (1505 - (363 + 1141))] = {v77,v332[8 - 5]};
										else
											v279[v331 - (1 + 0)] = {v60,v332[2 + 1]};
										end
										v76[#v76 + (2 - 1)] = v279;
									end
									v77[v79[3 - 1]] = v29(v277, v278, v61);
								else
									v77[v79[1935 - ((1939 - 1374) + 1368)]] = v77[v79[3]] * v79[15 - 11];
								end
							elseif (v80 <= (1691 - (1477 + 184))) then
								if (v80 <= ((1005 - (478 + 490)) - 9)) then
									if ((v80 == (26 + 1)) or (4649 <= 2632)) then
										v77[v79[5 - 3]] = v60[v79[859 - (564 + 292)]];
									elseif (v77[v79[2 - 0]] == v77[v79[(6 + 5) - (1179 - (786 + 386))]]) then
										v71 = v71 + (3 - 2);
									else
										v71 = v79[7 - (12 - 8)];
									end
								elseif (v80 > (333 - (244 + 60))) then
									v77[v79[2 + 0]] = {};
								else
									v77[v79[478 - (41 + 435)]] = v79[(1389 - (1055 + 324)) - 7] ~= (1001 - (938 + 63));
								end
							elseif (v80 <= (25 + 7)) then
								if (v80 > (1156 - (936 + (1529 - (1093 + 247))))) then
									local v171 = v79[1 + 1];
									v77[v171] = v77[v171](v77[v171 + (1614 - (1565 + 48))]);
								else
									local v173 = v79[2 + 0];
									v77[v173] = v77[v173](v77[v173 + (1139 - (695 + 87 + 356))]);
								end
							elseif (v80 <= 33) then
								v77[v79[269 - (176 + 91)]] = {};
							elseif (v80 == (88 - 54)) then
								v77[v79[2 - 0]][v79[1095 - (975 + 117)]] = v79[1879 - (157 + 1718)];
							else
								v77[v79[2 + 0]] = v77[v79[10 - 7]];
							end
						elseif ((v80 <= (486 - (153 + 280))) or (3860 > 4872)) then
							if ((v80 <= (150 - 106)) or (2225 == 20)) then
								if (v80 <= (1057 - (697 + 321))) then
									if (v80 <= (100 - 63)) then
										if (v80 > (75 - 39)) then
											local v176 = v79[1 + 1];
											local v177 = {};
											for v236 = (1 + 1) - 1, #v76 do
												local v237 = 0 + 0;
												local v238;
												while true do
													if (((0 - 0) + 0) == v237) then
														v238 = v76[v236];
														for v368 = 0 - 0, #v238 do
															local v369 = 0 - 0;
															local v370;
															local v371;
															local v372;
															while true do
																if (v369 == (1228 - (322 + 905))) then
																	v372 = v370[(2080 - 1467) - ((1712 - 1110) + 9)];
																	if ((v371 == v77) and (v372 >= v176)) then
																		v177[v372] = v371[v372];
																		v370[(2990 - 1800) - (160 + 289 + 740)] = v177;
																	end
																	break;
																end
																if ((v369 == (872 - (826 + 46))) or (872 >= 3092)) then
																	v370 = v238[v368];
																	v371 = v370[948 - (245 + (2704 - 2002))];
																	v369 = 3 - (6 - 4);
																end
															end
														end
														break;
													end
												end
											end
										else
											local v178 = 0 + 0;
											local v179;
											while true do
												if (((0 + 0) == v178) or (3998 == 2298)) then
													v179 = v79[1900 - (260 + 1638)];
													v77[v179](v77[v179 + (441 - (382 + 58))]);
													break;
												end
											end
										end
									elseif ((4404 >= 3252) and (v80 > (121 - 83))) then
										v71 = v79[3 + 0];
									else
										v77[v79[3 - (1 + 0)]] = v60[v79[8 - 5]];
									end
								elseif ((1107 > 796) and (v80 <= (1246 - (902 + 303)))) then
									if (v80 > (87 - (119 - 72))) then
										local v183 = 0 - 0;
										local v184;
										local v185;
										local v186;
										while true do
											if (v183 == (0 + (688 - (364 + 324)))) then
												v184 = v79[1692 - ((3072 - 1951) + 569)];
												v185 = {v77[v184](v77[v184 + (1 - 0)])};
												v183 = 684 - ((2020 - 1537) + 200);
											end
											if (v183 == (1464 - (1404 + 59))) then
												v186 = 0 - 0;
												for v359 = v184, v79[4 - 0] do
													v186 = v186 + (766 - (468 + (474 - 177)));
													v77[v359] = v185[v186];
												end
												break;
											end
										end
									else
										v77[v79[564 - (334 + 228)]][v79[10 - 7]] = v77[v79[4]];
									end
								elseif (v80 <= (116 - 74)) then
									local v189 = v79[2 + 0];
									local v190, v191 = v70(v77[v189](v13(v77, v189 + ((5 - 3) - 1), v79[5 - 2])));
									v72 = (v191 + v189) - (1 + 0);
									local v192 = 0 + 0;
									for v239 = v189, v72 do
										v192 = v192 + (237 - (141 + (1363 - (1249 + 19))));
										v77[v239] = v190[v192];
									end
								elseif (v80 == (43 + 0)) then
									v77[v79[1 + 0 + 1]]();
								else
									local v287 = (0 - 0) - 0;
									local v288;
									while true do
										if ((959 == 959) and (v287 == (0 - 0))) then
											v288 = v79[1 + (1087 - (686 + 400))];
											v77[v288](v13(v77, v288 + (2 - 1), v79[3 + 0]));
											break;
										end
									end
								end
							elseif ((v80 <= (844 - (588 + 208))) or (8 >= 2739) or (245 >= 2204)) then
								if ((2590 == 2590) and (v80 <= (24 + 22))) then
									if ((3162 >= 2069) and (v80 > (1845 - (884 + 916)))) then
										if ((v77[v79[2 - 0]] == v79[3 + 0 + 1]) or (82 >= 1870)) then
											v71 = v71 + 1 + 0;
										else
											v71 = v79[166 - ((321 - (73 + 156)) + 71)];
										end
									else
										v77[v79[1 + 1]] = v77[v79[4 - 1]] * v79[(4 + 765) - (574 + 191)];
									end
								elseif (v80 == ((969 - (721 + 90)) - 111)) then
									v77[v79[607 - (316 + 289)]] = v79[7 - 4];
								elseif (((2624 < 4557) and not v77[v79[2 + 0]]) or (306 > 3081)) then
									v71 = v71 + (2 - 1);
								else
									v71 = v79[2 + 1];
								end
							elseif (v80 <= ((11 + 888) - (254 + 595))) then
								if (v80 > (175 - (55 + (230 - 159)))) then
									do
										return;
									end
								else
									local v196 = 0;
									local v197;
									while true do
										if (v196 == (0 - 0)) then
											v197 = v79[1792 - (573 + 1217)];
											v77[v197] = v77[v197](v13(v77, v197 + (2 - 1), v79[3]));
											break;
										end
									end
								end
							elseif (v80 <= (4 + 47)) then
								local v198 = v79[4 - 1];
								local v199 = v77[v198];
								for v242 = v198 + (940 - (714 + 225)), v79[11 - 7] do
									v199 = v199 .. v77[v242];
								end
								v77[v79[472 - (224 + 246)]] = v199;
							elseif ((v80 > (71 - 19)) or (3513 < 2706)) then
								v60[v79[1 + 2]] = v77[v79[2 - 0]];
							else
								v77[v79[808 - (118 + 688)]] = v61[v79[51 - (25 + 23)]];
							end
						elseif (v80 <= (13 + 49)) then
							if ((v80 <= (222 - 165)) or (3131 > 3542)) then
								if ((2978 < 3639) and (2577 >= 1578) and (v80 <= (1941 - (927 + 959)))) then
									if ((3682 >= 2888) and (v80 == (181 - 127))) then
										v77[v79[734 - (16 + 716)]] = v77[v79[(2 - 0) + 1]][v79[7 - 3]];
									else
										local v203 = v79[(181 - 82) - (11 + 86)];
										v77[v203] = v77[v203](v13(v77, v203 + (2 - 1), v72));
									end
								elseif ((4103 <= 4571) and (v80 == (341 - (175 + 110)))) then
									v71 = v79[6 - 3];
								else
									local v206 = v79[1 + 1];
									v77[v206] = v77[v206]();
								end
							elseif ((v80 <= (290 - 231)) or (1495 == 4787)) then
								if (v80 == (1854 - (503 + 1293))) then
									if ((149 < 479) and (v79[5 - 3] == v77[v79[3 + 1]])) then
										v71 = v71 + (1062 - (810 + 251));
									else
										v71 = v79[1 + 2 + 0];
									end
								else
									for v243 = v79[2 + 0], v79[1 + 2] do
										v77[v243] = nil;
									end
								end
							elseif (v80 <= (55 + 5)) then
								v77[v79[535 - (43 + 490)]] = v79[736 - (711 + 22)];
							elseif ((v80 > (206 - 145)) or (310 > 4434)) then
								do
									return;
								end
							else
								v77[v79[7 - 5]] = v77[v79[3]];
							end
						elseif ((1020 >= 567) and (v80 <= 66)) then
							if (v80 <= (923 - (177 + 63 + 619))) then
								if (v80 > (122 - 59)) then
									if ((2168 <= 4360) and v77[v79[1 + 1]]) then
										v71 = v71 + 1;
									else
										v71 = v79[1483 - (641 + 839)];
									end
								else
									local v210 = v79[2 - 0];
									local v211 = v79[1 + 3];
									local v212 = v210 + (1746 - ((2671 - 1327) + 400));
									local v213 = {v77[v210](v77[v210 + (406 - (255 + 150))], v77[v212])};
									for v245 = 1 + 0, v211 do
										v77[v212 + v245] = v213[v245];
									end
									local v214 = v213[(1994 - (1238 + 755)) + 0];
									if (((994 == 994) and v214) or (733 > 2469)) then
										v77[v212] = v214;
										v71 = v79[2 + 1];
									else
										v71 = v71 + (4 - 3);
									end
								end
							elseif (v80 > (209 - 144)) then
								local v215 = 1739 - (404 + 1335);
								local v216;
								local v217;
								local v218;
								local v219;
								while true do
									if ((1655 > 401) and (v215 == (407 - (183 + 223)))) then
										v72 = (v218 + v216) - (1 - 0);
										v219 = 0 + 0;
										v215 = 1 + 1;
									end
									if (v215 == (339 - (10 + 23 + 304))) then
										for v362 = v216, v72 do
											v219 = v219 + (1535 - (709 + 825)) + 0;
											v77[v362] = v217[v219];
										end
										break;
									end
									if ((3063 <= 3426) and (v215 == (338 - (118 + 220)))) then
										v216 = v79[1 + 1];
										v217, v218 = v70(v77[v216](v77[v216 + (1478 - (29 + 1448))]));
										v215 = 450 - (108 + 341);
									end
								end
							else
								local v220 = v77[v79[2 + 2]];
								if ((2497 == 2497) and v220) then
									v71 = v71 + 1;
								else
									local v301 = 0 - 0;
									while true do
										if (v301 == (0 - 0)) then
											v77[v79[1495 - ((1309 - 598) + 782)]] = v220;
											v71 = v79[1530 - (389 + 1138)];
											break;
										end
									end
								end
							end
						elseif (v80 <= (130 - 62)) then
							if ((3901 == 3901) and (1459 > 764) and (v80 > ((780 - 244) - (270 + 199)))) then
								local v221 = 0 + 0;
								local v222;
								while true do
									if ((v221 == 0) or (641 > 4334)) then
										v222 = v77[v79[1823 - (580 + 1239)]];
										if ((3399 >= 2260) and v222) then
											v71 = v71 + 1 + (864 - (196 + 668));
										else
											v77[v79[2 + 0]] = v222;
											v71 = v79[1548 - ((1263 - 943) + 1225)];
										end
										break;
									end
								end
							else
								for v248 = v79[2 - 0], v79[2 + 1] do
									v77[v248] = nil;
								end
							end
						elseif (v80 <= (204 - 135)) then
							local v223 = v79[2 + 0];
							local v224 = v79[4];
							local v225 = v223 + 1 + 1;
							local v226 = {v77[v223](v77[v223 + (2 - 1)], v77[v225])};
							for v250 = 1 + 0, v224 do
								v77[v225 + v250] = v226[v250];
							end
							local v227 = v226[1 + 0];
							if ((201 < 415) and v227) then
								v77[v225] = v227;
								v71 = v79[1170 - (645 + (1081 - 559))];
							else
								v71 = v71 + 1 + 0;
							end
						elseif (v80 == (1860 - (1010 + 780))) then
							v60[v79[(836 - (171 + 662)) + 0]] = v77[v79[9 - (100 - (4 + 89))]];
						else
							local v306 = v79[1 + 1];
							v77[v306] = v77[v306](v13(v77, v306 + (2 - 1), v72));
						end
						v71 = v71 + (1837 - (1045 + (2772 - 1981)));
						break;
					end
				end
			end
		end;
	end
	return v29(v28(), {}, v17)(...);
end
return v15("LOL!293Q00022Q00C09F6BE9E141030C3Q0046756E6B7920467269646179022Q00E0949A69014203143Q0053757276697665205A6F6D626965204172656E6103053Q00706169727303043Q0067616D6503063Q0047616D654964030A3Q004765745365727669636503073Q00506C6179657273030A3Q0052756E5365727669636503113Q005265706C69636174656453746F72616765030B3Q004C6F63616C506C61796572030A3Q006C6F6164737472696E6703073Q00482Q747047657403303Q00682Q7470733A2Q2F70722Q6F68696F2E6769746875622E696F2F6368696D6975696C69622F6C6962726172792E6C756103093Q004372656174654C696203083Q004368696D69202D2003053Q004368696D69028Q00027Q0040030A3Q004E657753656374696F6E03063Q00506C6179657203093Q004E6577536C6964657203053Q0053702Q6564030A3Q0057616C6B2073702Q6564026Q006940026Q00304003093Q004E6577546F2Q676C6503063Q004E6F636C6970026Q000840026Q00F03F030C3Q0057616974466F724368696C6403063Q0047756E48697403043Q004D61696E03093Q004B692Q6C204175726103093Q004E657742752Q746F6E03043Q005472697003063Q004E657754616203093Q00776F726B7370616365030D3Q005A6F6D626965735F4C6F63616C030A3Q0047756E52656D6F746573007E4Q001E5Q00020030133Q000100020030133Q000300042Q0043000100013Q001234000200054Q003D00036Q00290002000200040004273Q000D0001001234000700063Q00203600070007000700061C0007000D000100050004273Q000D00012Q003D000100063Q00063F00020008000100020004273Q0008000100063000010012000100010004273Q001200012Q00323Q00013Q001234000200063Q00201000020002000800122F000400094Q0031000200040002001234000300063Q00201000030003000800122F0005000A4Q0031000300050002001234000400063Q00201000040004000800122F0006000B4Q003100040006000200203600050002000C0012340006000D3Q001234000700063Q00201000070007000E00122F0009000F4Q0012000700094Q004700063Q00022Q003900060001000200203600070006001000122F000800114Q003D000900014Q000600080008000900122F000900124Q003100070009000200262E0001007C000100040004273Q007C000100122F000800134Q0043000900113Q000E3A00140048000100080004273Q004800010020100012000A001500122F001400164Q00310012001400022Q003D001000123Q00201000120010001700122F001400183Q00122F001500193Q00122F0016001A3Q00122F0017001B3Q00060500183Q000100012Q00233Q00054Q00170012001800012Q0043001100113Q00201000120010001C00122F0014001D3Q00122F0015001D3Q00060500160001000100032Q00233Q00114Q00233Q00034Q00233Q00054Q001700120016000100122F0008001E3Q00262E0008005D0001001F0004273Q005D00010020100012000C002000122F001400214Q00310012001400022Q003D000D00123Q00201000120009001500122F001400224Q00310012001400022Q003D000E00124Q0043000F000F3Q0020100012000E001C00122F001400233Q00122F001500233Q00060500160002000100042Q00233Q000F4Q00233Q00054Q00233Q000B4Q00233Q000D4Q001700120016000100122F000800143Q00262E000800660001001E0004273Q0066000100201000120010002400122F001400253Q00122F001500253Q00060500160003000100012Q00233Q00054Q00170012001600010004273Q007B000100262E00080030000100130004273Q0030000100201000120007002600122F001400224Q00310012001400022Q003D000900123Q00201000120007002600122F001400164Q00310012001400022Q003D000A00123Q001234001200273Q00201000120012002000122F001400284Q00310012001400022Q003D000B00123Q00201000120004002000122F001400294Q00310012001400022Q003D000C00123Q00122F0008001F3Q0004273Q003000012Q000B00086Q000B8Q00323Q00013Q00043Q00063Q00028Q00026Q00F03F03093Q0043686172616374657203163Q0046696E6446697273744368696C64576869636849734103083Q0048756D616E6F696403093Q0057616C6B53702Q656401273Q00122F000100014Q0043000200043Q00262E00010020000100020004273Q002000012Q0043000400043Q000E3A00010018000100020004273Q0018000100122F000500013Q00262E0005000C000100020004273Q000C000100122F000200023Q0004273Q0018000100262E00050008000100010004273Q000800012Q002600065Q00203600030006000300064100040016000100030004273Q0016000100201000060003000400122F000800054Q00310006000800022Q003D000400063Q00122F000500023Q0004273Q0008000100262E00020005000100020004273Q000500010006400004002600013Q0004273Q0026000100102Q000400063Q0004273Q002600010004273Q000500010004273Q0026000100262E00010002000100010004273Q0002000100122F000200014Q0043000300033Q00122F000100023Q0004273Q000200012Q00323Q00017Q00033Q0003073Q005374652Q70656403073Q00436F2Q6E656374030A3Q00446973636F2Q6E65637401113Q0006403Q000A00013Q0004273Q000A00012Q0026000100013Q00203600010001000100201000010001000200060500033Q000100012Q001B3Q00024Q00310001000300022Q003500015Q0004273Q001000012Q002600015Q0006400001001000013Q0004273Q001000012Q002600015Q0020100001000100032Q00240001000200012Q00323Q00013Q00013Q00083Q00028Q0003093Q0043686172616374657203053Q007061697273030E3Q0047657444657363656E64616E74732Q033Q0049734103083Q004261736550617274030A3Q0043616E436F2Q6C696465012Q00183Q00122F3Q00014Q0043000100013Q00262E3Q0002000100010004273Q000200012Q002600025Q0020360001000200020006400001001700013Q0004273Q00170001001234000200033Q0020100003000100042Q0015000300044Q001100023Q00040004273Q0013000100201000070006000500122F000900064Q00310007000900020006400007001300013Q0004273Q0013000100301300060007000800063F0002000D000100020004273Q000D00010004273Q001700010004273Q000200012Q00323Q00017Q00033Q00028Q0003043Q007461736B03053Q00737061776E01153Q0006403Q001200013Q0004273Q0012000100122F000100013Q00262E00010003000100010004273Q000300012Q001D000200014Q003500025Q001234000200023Q00203600020002000300060500033Q000100042Q001B8Q001B3Q00014Q001B3Q00024Q001B3Q00034Q00240002000200010004273Q001400010004273Q000300010004273Q001400012Q001D00016Q003500016Q00323Q00013Q00013Q00153Q00028Q0003093Q0043686172616374657203163Q0046696E6446697273744368696C64576869636849734103043Q00542Q6F6C026Q00F03F03053Q007061697273030B3Q004765744368696C6472656E2Q033Q0049734103053Q004D6F64656C030E3Q0046696E6446697273744368696C6403103Q0048756D616E6F6964522Q6F7450617274030A3Q004669726553657276657203043Q004E616D6503083Q00746F6E756D62657203063Q00737472696E6703053Q0073706C697403013Q005F027Q004003083Q00506F736974696F6E03043Q007461736B03043Q0077616974004F4Q00267Q0006403Q004E00013Q0004273Q004E000100122F3Q00014Q0043000100023Q00262E3Q0010000100010004273Q001000012Q0026000300013Q0020360001000300020006410002000F000100010004273Q000F000100201000030001000300122F000500044Q00310003000500022Q003D000200033Q00122F3Q00053Q000E3A0005000500013Q0004273Q000500010006400002004800013Q0004273Q00480001001234000300064Q0026000400023Q0020100004000400072Q0015000400054Q001100033Q00050004273Q0046000100201000080007000800122F000A00094Q00310008000A00020006400008004600013Q0004273Q0046000100122F000800014Q0043000900093Q00262E00080021000100010004273Q00210001002010000A0007000A00122F000C000B4Q0031000A000C00022Q003D0009000A3Q0006400009004600013Q0004273Q0046000100122F000A00014Q0043000B000B3Q00262E000A002B000100010004273Q002B000100122F000B00013Q00262E000B002E000100010004273Q002E00012Q0026000C00033Q002010000C000C000C002036000E0002000D001234000F000E3Q0012340010000F3Q00203600100010001000203600110007000D00122F001200114Q00310010001200020020360010001000122Q0020000F000200020020360010000900132Q0017000C00100001001234000C00143Q002036000C000C00152Q0016000C000100010004273Q004600010004273Q002E00010004273Q004600010004273Q002B00010004273Q004600010004273Q0021000100063F0003001A000100020004273Q001A0001001234000300143Q0020360003000300152Q00160003000100010004275Q00010004273Q000500010004275Q00012Q00323Q00017Q000B3Q00028Q00026Q00F03F03083Q00522Q6F7450617274030B3Q004368616E6765537461746503163Q00412Q73656D626C794C696E65617256656C6F6369747903063Q00434672616D65030A3Q004C2Q6F6B566563746F72026Q003E4003093Q0043686172616374657203163Q0046696E6446697273744368696C64576869636849734103083Q0048756D616E6F6964002B3Q00122F3Q00014Q0043000100033Q00262E3Q0016000100020004273Q0016000100064100030007000100020004273Q000700010020360003000200030006400003002A00013Q0004273Q002A000100122F000400013Q00262E0004000A000100010004273Q000A000100201000050002000400122F000700014Q001700050007000100203600050003000600203600050005000700202D00050005000800102Q0003000500050004273Q002A00010004273Q000A00010004273Q002A000100262E3Q0002000100010004273Q0002000100122F000400013Q00262E0004001D000100020004273Q001D000100122F3Q00023Q0004273Q0002000100262E00040019000100010004273Q001900012Q002600055Q00203600010005000900064100020027000100010004273Q0027000100201000050001000A00122F0007000B4Q00310005000700022Q003D000200053Q00122F000400023Q0004273Q001900010004273Q000200012Q00323Q00017Q00", v9(), ...);
