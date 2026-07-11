--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Share the Pain  (ID: 56830749)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- Tribute 1 monster; make your opponent Tribute 1 monster (for no effect).
--[[ __CARD_HEADER_END__ ]]

--痛み分け
function c56830749.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c56830749.cost)
	e1:SetTarget(c56830749.target)
	e1:SetOperation(c56830749.activate)
	c:RegisterEffect(e1)
end
function c56830749.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,nil,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c56830749.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroupEx(1-tp,nil,1,REASON_RULE,false,nil) end
end
function c56830749.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.SelectReleaseGroupEx(1-tp,nil,1,1,REASON_RULE,false,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.Release(g,REASON_RULE,1-tp)
	end
end
