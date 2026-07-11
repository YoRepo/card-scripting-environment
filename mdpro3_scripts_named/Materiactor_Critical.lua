--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Materiactor Critical  (ID: 64767757)
-- Type: Trap / Counter
-- Setcode: 0x160
-- Scope: OCG / TCG
--
-- Effect Text:
-- When a Spell/Trap Card, or monster effect, is activated: Add 1 of your materials from a
-- "Materiactor" Xyz Monster you control to your hand, and if you do, negate the activation, then apply
-- the following effect based on the card type added.
-- ● Monster: Place 1 card from your hand on the bottom of the Deck.
-- ● Spell: "Materiactor" Xyz Monsters you control gain 1000 ATK.
-- ● Trap: You can Set that added card.
-- You can only activate 1 "Materiactor Critical" per turn.
--[[ __CARD_HEADER_END__ ]]

--原質の臨界超過
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_TOHAND+CATEGORY_TODECK+CATEGORY_ATKCHANGE+CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(s.condition)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.condition(e,tp,eg,ep,ev,re,r,rp)
	return (re:IsActiveType(TYPE_MONSTER) or re:IsHasType(EFFECT_TYPE_ACTIVATE)) and Duel.IsChainNegatable(ev)
end
function s.xyzfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x160)
end
function s.ovfilter(c,tp)
	return c:IsAbleToHand() and c:GetOwner()==tp
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local rg=Group.CreateGroup()
	local xg=Duel.GetMatchingGroup(s.xyzfilter,tp,LOCATION_MZONE,0,nil)
	if xg:GetCount()<1 then return false end
	for tc in aux.Next(xg) do
		local hg=tc:GetOverlayGroup()
		if hg:GetCount()>0 then
			rg:Merge(hg)
		end
	end
	if chk==0 then return rg and rg:FilterCount(s.ovfilter,nil,tp)>0 end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function s.atkfilter(c,e)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsSetCard(0x160)
		and not c:IsImmuneToEffect(e)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local rg=Group.CreateGroup()
	local xg=Duel.GetMatchingGroup(s.xyzfilter,tp,LOCATION_MZONE,0,nil)
	if xg:GetCount()<1 then return end
	for tc in aux.Next(xg) do
		local hg=tc:GetOverlayGroup()
		if hg:GetCount()>0 then
			rg:Merge(hg)
		end
	end
	if rg and rg:FilterCount(s.ovfilter,nil,tp)>0 then
		local tc=rg:FilterSelect(tp,s.ovfilter,1,1,nil,tp):GetFirst()
		if Duel.SendtoHand(tc,nil,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_HAND) then
			Duel.ConfirmCards(1-tp,tc)
			Duel.ShuffleHand(tp)
			if Duel.NegateActivation(ev) then
				Duel.BreakEffect()
				if tc:IsType(TYPE_MONSTER) and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,nil) then
					local sg=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
					Duel.SendtoDeck(sg,nil,SEQ_DECKBOTTOM,REASON_EFFECT)
				end
				if tc:IsType(TYPE_SPELL) and Duel.IsExistingMatchingCard(s.atkfilter,tp,LOCATION_MZONE,0,1,nil,e) then
					local g=Duel.GetMatchingGroup(s.atkfilter,tp,LOCATION_MZONE,0,nil,e)
					if g:GetCount()>0 then
						for ac in aux.Next(g) do
							local e1=Effect.CreateEffect(c)
							e1:SetType(EFFECT_TYPE_SINGLE)
							e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
							e1:SetCode(EFFECT_UPDATE_ATTACK)
							e1:SetValue(1000)
							e1:SetReset(RESET_EVENT+RESETS_STANDARD)
							ac:RegisterEffect(e1)
						end
					end
				end
				if tc:IsType(TYPE_TRAP)
					and (tc:IsType(TYPE_FIELD) or Duel.GetLocationCount(tp,LOCATION_SZONE)>0)
					and tc:IsSSetable(true)
					and Duel.SelectYesNo(tp,aux.Stringid(id,2)) then
					Duel.SSet(tp,tc)
				end
			end
		end
	end
end
