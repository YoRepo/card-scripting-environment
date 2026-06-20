--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 死亡旋风  (ID: 59235795)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Reptile
-- Level 7
-- ATK 2000 | DEF 1500
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，场上表侧表示存在的风属性怪兽以外的怪兽全部破坏。
--[[ __CARD_HEADER_END__ ]]

--デスサイクロン
function c59235795.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(59235795,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c59235795.condition)
	e1:SetTarget(c59235795.target)
	e1:SetOperation(c59235795.operation)
	c:RegisterEffect(e1)
end
function c59235795.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c59235795.filter(c)
	return (c:IsFacedown() or c:GetAttribute()~=ATTRIBUTE_WIND)
end
function c59235795.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c59235795.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c59235795.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c59235795.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
