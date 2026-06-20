--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 土地锯  (ID: 77428945)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Reptile
-- Level 3
-- ATK 1600 | DEF 500
--
-- Effect Text:
-- 这张卡特殊召唤成功时，这张卡以外的场上的特殊召唤的怪兽全部变成里侧守备表示。「土地锯」的效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--土地鋸
function c77428945.initial_effect(c)
	--position
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(77428945,0))
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCountLimit(1,77428945)
	e1:SetTarget(c77428945.target)
	e1:SetOperation(c77428945.operation)
	c:RegisterEffect(e1)
end
function c77428945.filter(c)
	return c:IsFaceup() and c:IsCanTurnSet() and c:IsSummonType(SUMMON_TYPE_SPECIAL)
end
function c77428945.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c77428945.filter,tp,LOCATION_MZONE,LOCATION_MZONE,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c77428945.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c77428945.filter,tp,LOCATION_MZONE,LOCATION_MZONE,aux.ExceptThisCard(e))
	Duel.ChangePosition(g,POS_FACEDOWN_DEFENSE)
end
