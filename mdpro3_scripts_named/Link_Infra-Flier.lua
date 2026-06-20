--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 连接设施飞行员  (ID: 65100616)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Cyberse
-- Level 2
-- ATK 0 | DEF 1800
--
-- Effect Text:
-- 这个卡名的①的方法的特殊召唤1回合只能有1次。
-- ①：这张卡可以从手卡往作为场上的连接怪兽所连接区的自己场上特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--リンク・インフライヤー
function c65100616.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,65100616+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c65100616.spcon)
	e1:SetValue(c65100616.spval)
	c:RegisterEffect(e1)
end
function c65100616.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	local zone=Duel.GetLinkedZone(tp)
	return Duel.GetLocationCount(tp,LOCATION_MZONE,tp,LOCATION_REASON_TOFIELD,zone)>0
end
function c65100616.spval(e,c)
	return 0,Duel.GetLinkedZone(c:GetControler())
end
