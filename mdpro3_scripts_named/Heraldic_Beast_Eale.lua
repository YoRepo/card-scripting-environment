--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 纹章兽 野迩  (ID: 82315772)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 4
-- ATK 1000 | DEF 1800
-- Setcode: 118
--
-- Effect Text:
-- 自己场上有名字带有「纹章兽」的怪兽2只以上存在的场合，这张卡可以从手卡特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--紋章獣エアレー
function c82315772.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c82315772.spcon)
	c:RegisterEffect(e1)
end
function c82315772.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x76)
end
function c82315772.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c82315772.filter,c:GetControler(),LOCATION_MZONE,0,2,nil)
end
