SELECT CLI.COD_CLI AS CODIGO , CLI.NOME_CLI as [NOME CLIENTE]  , F.NOME_FUNC AS [NOME FUNCIONARIO]  FROM CLIENTES AS CLI 
INNER JOIN FUNCIONARIOS AS F ON F.COD_FUNC = CLI.COD_VEND
WHERE COD_CLI IN(
23103,
4644,
6099,
9138,
11724,
26087,
32137,
34303,
34857,
37153,
55963,
60062,
67222,
67235,
67236,
67237,
67238,
67240,
67241,
67244,
67245,
67248,
67249,
67251,
67274,
67275,
67276,
67277,
67278,
67279,
67282,
67283,
67284,
67285,
67286,

16, 
469,
2161,
13498,
18551,
21724,
42432,
65275,
65276,


1283 ,
18843,
26262,
28533,
28534,
28535,
28536,
28537,
25838,
28539,
28540,
28541,
28542,
28545,
28546,
28547,
28548,
28549,
28551,
28552,
28553,
28554,
28555,
28556,
28557,
28558,
28559,
28560,
28561,
28562,
28563,
28564,
28565,
28566,

55327,


10972 ,
21119 ,
55117 ,
65519 ,
65932 ,
66303 ,
66355 ,
66398 ,
66781 ,


43801 ,
18036,

18340,
43606,
62102,
4406,




55144,

63818 ,
37124,

21248,

6997,

11082,


45892 ,
60730 ,
58141,
60290,
54645,
65022,
54613,
64610)


