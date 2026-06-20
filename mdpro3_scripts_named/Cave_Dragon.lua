--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 巨龙  (ID: 93220472)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Dragon
-- Level 4
-- ATK 2000 | DEF 100
--
-- Effect Text:
-- 这张卡在自己场上至少有1只其他的怪兽存在不能召唤。自己场上没有这张卡以外的龙族怪兽存在时，这张卡不能攻击宣言。
--[[ __CARD_HEADER_END__ ]]

--グランド・ドラゴン
function c93220472.initial_effect(c)
	--sumlimit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c93220472.sumcon)
	c:RegisterEffect(e1)
	--atklimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetCondition(c93220472.atkcon)
	c:RegisterEffect(e2)
end
function c93220472.sumcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_MZONE,0)>0
end
function c93220472.afilter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON)
end
function c93220472.atkcon(e)
	return not Duel.IsExistingMatchingCard(c93220472.afilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
