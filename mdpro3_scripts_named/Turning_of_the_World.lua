--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 世界逆转  (ID: 95612049)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：等级合计直到变成仪式召唤的怪兽的等级以上为止，把手卡的仪式怪兽解放，从手卡·卡组把「破灭之女神 露茵」或者「终焉之王 迪米斯」仪式召唤。
--[[ __CARD_HEADER_END__ ]]

--リバース・オブ・ザ・ワールド
function c95612049.initial_effect(c)
	--Activate
	local e1=aux.AddRitualProcGreater2Code2(c,46427957,72426662,LOCATION_HAND+LOCATION_DECK,nil,c95612049.mfilter,true)
	e1:SetCountLimit(1,95612049+EFFECT_COUNT_CODE_OATH)
	c:RegisterEffect(e1)
end
function c95612049.mfilter(c)
	return not c:IsOnField() and c:IsType(TYPE_RITUAL)
end
