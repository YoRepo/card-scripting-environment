--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 隐密忍法帖  (ID: 79324191)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
-- Setcode: 97
--
-- Effect Text:
-- ①：1回合1次，从手卡把1只「忍者」怪兽送去墓地才能发动。从卡组选「隐密忍法帖」以外的1张「忍法」魔法·陷阱卡在自己场上盖放。
--[[ __CARD_HEADER_END__ ]]

--隠密忍法帖
function c79324191.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(79324191,0))
	e2:SetCategory(CATEGORY_SSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c79324191.setcost)
	e2:SetTarget(c79324191.settg)
	e2:SetOperation(c79324191.setop)
	c:RegisterEffect(e2)
end
function c79324191.costfilter(c)
	return c:IsSetCard(0x2b) and c:IsType(TYPE_MONSTER) and c:IsAbleToGraveAsCost()
end
function c79324191.setcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79324191.costfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c79324191.costfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c79324191.setfilter(c)
	return c:IsSetCard(0x61) and c:IsType(TYPE_SPELL+TYPE_TRAP) and not c:IsCode(79324191) and c:IsSSetable()
end
function c79324191.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79324191.setfilter,tp,LOCATION_DECK,0,1,nil) end
end
function c79324191.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c79324191.setfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g)
	end
end
