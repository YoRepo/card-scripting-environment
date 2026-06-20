--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 红莲守卫者  (ID: 72318602)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Fiend
-- Level 4
-- ATK 0 | DEF 2000
--
-- Effect Text:
-- ①：自己场上有「红莲魔」怪兽存在，对方的魔法·陷阱·怪兽的效果发动时，把这张卡从手卡送去墓地才能发动。这个回合，自己场上的怪兽不会被对方的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--レッド・ガードナー
function c72318602.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c72318602.condition)
	e1:SetCost(c72318602.cost)
	e1:SetOperation(c72318602.operation)
	c:RegisterEffect(e1)
end
function c72318602.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x1045)
end
function c72318602.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp and Duel.IsExistingMatchingCard(c72318602.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c72318602.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c72318602.operation(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetValue(aux.indoval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
