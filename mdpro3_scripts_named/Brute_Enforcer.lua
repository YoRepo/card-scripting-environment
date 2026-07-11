--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Brute Enforcer  (ID: 63503850)
-- Type: Monster / Effect / Link
-- Attribute: DARK
-- Race: Cyberse
-- Link Rating: 2
-- Link Arrows: Bottom-Left, Bottom-Right
-- ATK 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- 2 Effect Monsters
-- You can discard 1 card, then target 1 face-up card your opponent controls; your opponent can discard
-- 1 card with the same original type (Monster/Spell/Trap) as that face-up card to negate this effect,
-- otherwise destroy that face-up card.
-- You can only use this effect of "Brute Enforcer" once per turn.
--[[ __CARD_HEADER_END__ ]]

--ブルートエンフォーサー
function c63503850.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	aux.AddLinkProcedure(c,aux.FilterBoolFunction(Card.IsLinkType,TYPE_EFFECT),2,2)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63503850,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,63503850)
	e1:SetCost(c63503850.descost)
	e1:SetTarget(c63503850.destg)
	e1:SetOperation(c63503850.desop)
	c:RegisterEffect(e1)
end
function c63503850.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDiscardable,tp,LOCATION_HAND,0,1,nil) end
	Duel.DiscardHand(tp,Card.IsDiscardable,1,1,REASON_COST+REASON_DISCARD)
end
function c63503850.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c63503850.cfilter(c,typ)
	return c:IsType(typ) and c:IsDiscardable(REASON_EFFECT)
end
function c63503850.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFacedown() then return end
	if Duel.IsChainDisablable(0) then
		local typ=bit.band(tc:GetOriginalType(),0x7)
		local sel=1
		Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(63503850,1))
		if Duel.IsExistingMatchingCard(c63503850.cfilter,tp,0,LOCATION_HAND,1,nil,typ) then
			sel=Duel.SelectOption(1-tp,1213,1214)
		else
			sel=Duel.SelectOption(1-tp,1214)+1
		end
		if sel==0 then
			Duel.DiscardHand(1-tp,c63503850.cfilter,1,1,REASON_EFFECT+REASON_DISCARD,nil,typ)
			Duel.NegateEffect(0)
			return
		end
	end
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
