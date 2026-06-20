--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 先史遗产 摩艾石像搬运器  (ID: 38007744)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 5
-- ATK 900 | DEF 1800
-- Setcode: 112
--
-- Effect Text:
-- 对方场上有卡存在，自己场上没有卡存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--先史遺産モアイキャリア
function c38007744.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c38007744.spcon)
	c:RegisterEffect(e1)
end
function c38007744.spcon(e,c)
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_ONFIELD,0)==0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_ONFIELD)>0
		and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
end
