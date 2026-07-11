--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Dark Master - Zorc  (ID: 97642679)
-- Type: Monster / Effect / Ritual
-- Attribute: DARK
-- Race: Fiend
-- Level: 8
-- ATK 2700 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Ritual Summon this card with "Contract with the Dark Master".
-- Once per turn: You can roll a six-sided die, then destroy all monsters your opponent controls if you
-- roll 1 or 2, destroy 1 monster your opponent controls if you roll 3, 4 or 5, or destroy all monsters
-- you control if you roll 6.
--[[ __CARD_HEADER_END__ ]]

--闇の支配者－ゾーク
function c97642679.initial_effect(c)
	aux.AddCodeList(c,96420087)
	c:EnableReviveLimit()
	--dice
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(97642679,0))
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DICE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c97642679.target)
	e1:SetOperation(c97642679.operation)
	c:RegisterEffect(e1)
end
function c97642679.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
	local g1=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
	local g2=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
	if g1:GetCount()~=0 and g2:GetCount()~=0 then
		g1:Merge(g2)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,1,0,0)
	end
end
function c97642679.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.TossDice(tp,1)
	if d==1 or d==2 then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(g,REASON_EFFECT)
	elseif d==6 then
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_MZONE,0,nil)
		Duel.Destroy(g,REASON_EFFECT)
	elseif d>=3 and d<=5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.Destroy(g,REASON_EFFECT)
	end
end
