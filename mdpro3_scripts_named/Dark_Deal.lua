--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 暗之取引  (ID: 65824822)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方的通常魔法发动时支付1000基本分才能发动。那个时候对方发动的通常魔法的效果变成「对方随机把手卡丢弃1张」。
--[[ __CARD_HEADER_END__ ]]

--闇の取引
function c65824822.initial_effect(c)
	--change effect
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c65824822.condition)
	e1:SetCost(c65824822.cost)
	e1:SetOperation(c65824822.activate)
	c:RegisterEffect(e1)
end
function c65824822.repop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	if g:GetCount()>0 then
		local sg=g:RandomSelect(1-tp,1)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
	end
end
function c65824822.condition(e,tp,eg,ep,ev,re,r,rp)
	local rc=re:GetHandler()
	return ep~=tp and rc:GetType()==TYPE_SPELL and re:IsHasType(EFFECT_TYPE_ACTIVATE)
		and Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)~=0
end
function c65824822.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c65824822.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Group.CreateGroup()
	Duel.ChangeTargetCard(ev,g)
	Duel.ChangeChainOperation(ev,c65824822.repop)
end
