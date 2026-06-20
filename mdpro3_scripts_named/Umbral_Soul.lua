--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 暗冥之魂  (ID: 86229493)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Reptile
-- Level 7
-- ATK 2000 | DEF 1500
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，场上表侧表示存在的暗属性怪兽以外的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--ダークネスソウル
function c86229493.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(86229493,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c86229493.condition)
	e1:SetTarget(c86229493.target)
	e1:SetOperation(c86229493.operation)
	c:RegisterEffect(e1)
end
function c86229493.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c86229493.filter(c)
	return (c:IsFacedown() or c:GetAttribute()~=ATTRIBUTE_DARK)
end
function c86229493.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c86229493.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c86229493.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c86229493.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
