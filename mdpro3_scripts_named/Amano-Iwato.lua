--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 天岩户  (ID: 32181268)
-- Type: Monster / Effect / Spirit
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 1900 | DEF 1200
--
-- Effect Text:
-- 这张卡不能特殊召唤。
-- ①：只要这张卡在怪兽区域存在，双方不能把灵魂怪兽以外的怪兽的效果发动。
-- ②：这张卡召唤·反转的回合的结束阶段发动。这张卡回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--天岩戸
function c32181268.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--cannot act
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,1)
	e2:SetValue(c32181268.aclimit)
	c:RegisterEffect(e2)
end
function c32181268.aclimit(e,re,tp)
	return not re:GetHandler():IsType(TYPE_SPIRIT) and re:IsActiveType(TYPE_MONSTER)
end
