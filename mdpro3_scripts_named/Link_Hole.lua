--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Link Hole  (ID: 73275815)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a Link-4 or higher monster: Destroy monsters your opponent controls, up to the number
-- of Link-3 or higher monsters you control.
-- You can only activate 1 "Link Hole" per turn.
--[[ __CARD_HEADER_END__ ]]

--リンケージ・ホール
function c73275815.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,73275815+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c73275815.condition)
	e1:SetTarget(c73275815.target)
	e1:SetOperation(c73275815.activate)
	c:RegisterEffect(e1)
end
function c73275815.cfilter(c)
	return c:IsFaceup() and c:IsLinkAbove(4)
end
function c73275815.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c73275815.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c73275815.filter(c)
	return c:IsFaceup() and c:IsLinkAbove(3)
end
function c73275815.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(c73275815.filter,tp,LOCATION_MZONE,0,nil)
	local dg=Duel.GetFieldGroup(tp,0,LOCATION_MZONE)
	if chk==0 then return ct>0 and dg:GetCount()>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg,1,0,0)
end
function c73275815.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetMatchingGroupCount(c73275815.filter,tp,LOCATION_MZONE,0,nil)
	if ct==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,nil,tp,0,LOCATION_MZONE,1,ct,nil)
	if g:GetCount()>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
