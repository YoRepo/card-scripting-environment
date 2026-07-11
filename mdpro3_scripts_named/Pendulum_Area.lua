--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Pendulum Area  (ID: 2359348)
-- Type: Trap
-- Setcode: 0xf2
-- Scope: OCG / TCG
--
-- Effect Text:
-- If all monsters you control are Pendulum Monsters (min. 1): Target 2 cards in your Pendulum Zones;
-- destroy both cards, and if you do, neither player can Special Summon for the rest of this turn,
-- except by Pendulum Summon.
--[[ __CARD_HEADER_END__ ]]

--ペンデュラム・エリア
function c2359348.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c2359348.condition)
	e1:SetTarget(c2359348.target)
	e1:SetOperation(c2359348.activate)
	c:RegisterEffect(e1)
end
function c2359348.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_PENDULUM)
end
function c2359348.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	return g:GetCount()>0 and g:FilterCount(c2359348.cfilter,nil)==g:GetCount()
end
function c2359348.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_PZONE,0,2,nil) end
	local g=Duel.GetFieldGroup(tp,LOCATION_PZONE,0)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
end
function c2359348.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	if sg:GetCount()==2 and Duel.Destroy(sg,REASON_EFFECT)==2 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
		e1:SetReset(RESET_PHASE+PHASE_END)
		e1:SetTargetRange(1,1)
		e1:SetTarget(c2359348.splimit)
		Duel.RegisterEffect(e1,tp)
	end
end
function c2359348.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return bit.band(sumtype,SUMMON_TYPE_PENDULUM)~=SUMMON_TYPE_PENDULUM
end
