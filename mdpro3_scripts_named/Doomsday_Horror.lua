--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 终焉之精灵  (ID: 64379430)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK ? | DEF ?
--
-- Effect Text:
-- 这张卡的攻击力·守备力变成从游戏中除外的暗属性怪兽数量×300的数值。这张卡被破坏送去墓地时，从游戏中除外的暗属性怪兽全部回到墓地。
--[[ __CARD_HEADER_END__ ]]

--終焉の精霊
function c64379430.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(c64379430.value)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SET_DEFENSE)
	e2:SetValue(c64379430.value)
	c:RegisterEffect(e2)
	--return
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(64379430,0))
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c64379430.retcon)
	e3:SetTarget(c64379430.rettg)
	e3:SetOperation(c64379430.retop)
	c:RegisterEffect(e3)
end
function c64379430.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK)
end
function c64379430.value(e,c)
	return Duel.GetMatchingGroupCount(c64379430.filter,0,LOCATION_REMOVED,LOCATION_REMOVED,nil)*300
end
function c64379430.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c64379430.rettg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c64379430.filter,0,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,g:GetCount(),0,0)
end
function c64379430.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c64379430.filter,0,LOCATION_REMOVED,LOCATION_REMOVED,nil)
	Duel.SendtoGrave(g,REASON_EFFECT+REASON_RETURN)
end
