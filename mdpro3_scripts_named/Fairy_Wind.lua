--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Fairy Wind  (ID: 73507661)
-- Type: Trap
-- Scope: OCG / TCG
--
-- Effect Text:
-- Destroy as many face-up Spells/Traps on the field as possible, except this card, and if you do, each
-- player takes damage equal to the total number of cards destroyed by this effect x 300.
--[[ __CARD_HEADER_END__ ]]

--妖精の風
function c73507661.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c73507661.target)
	e1:SetOperation(c73507661.activate)
	c:RegisterEffect(e1)
end
function c73507661.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c73507661.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.IsExistingMatchingCard(c73507661.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c) end
	local sg=Duel.GetMatchingGroup(c73507661.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,c)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,sg:GetCount()*300)
end
function c73507661.activate(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(c73507661.filter,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,aux.ExceptThisCard(e))
	local ct=Duel.Destroy(sg,REASON_EFFECT)
	Duel.Damage(tp,ct*300,REASON_EFFECT,true)
	Duel.Damage(1-tp,ct*300,REASON_EFFECT,true)
	Duel.RDComplete()
end
