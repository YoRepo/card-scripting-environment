--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 机械猎犬  (ID: 22512237)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 7
-- ATK 2800 | DEF 1500
--
-- Effect Text:
-- 只要自己手卡数目是0张，对方不能发动魔法卡。
--[[ __CARD_HEADER_END__ ]]

--メカニカル・ハウンド
function c22512237.initial_effect(c)
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,1)
	e1:SetValue(c22512237.aclimit)
	e1:SetCondition(c22512237.condition)
	c:RegisterEffect(e1)
end
function c22512237.condition(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)==0
end
function c22512237.aclimit(e,re,tp)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL)
end
