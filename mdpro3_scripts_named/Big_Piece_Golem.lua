--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 大块石人  (ID: 25247218)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 5
-- ATK 2100 | DEF 0
--
-- Effect Text:
-- 对方场上有怪兽存在，自己场上没有怪兽存在的场合，这张卡可以不用解放作召唤。
--[[ __CARD_HEADER_END__ ]]

--ビッグ・ピース・ゴーレム
function c25247218.initial_effect(c)
	--summon with no tribute
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25247218,0))
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SUMMON_PROC)
	e1:SetCondition(c25247218.ntcon)
	c:RegisterEffect(e1)
end
function c25247218.ntcon(e,c,minc)
	if c==nil then return true end
	return minc==0 and c:IsLevelAbove(5) and Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),LOCATION_MZONE,0)==0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>0
end
