--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Moissa Knight, the Comet General  (ID: 66736715)
-- Type: Monster / Effect / Pendulum
-- Attribute: LIGHT
-- Race: Warrior
-- Level: 1
-- ATK 100 | DEF 100
-- Pendulum Scale: L11 / R11
-- Scope: OCG / TCG
--
-- Effect Text:
-- Pendulum Scale = 11
-- [ Pendulum Effect ]
-- If you Pendulum Summon a monster(s): Place this card on either the top or bottom of the Deck.
-- ----------------------------------------
-- [ Monster Effect ]
-- When you draw this card: You can reveal it; during your Main Phase this turn, you can conduct 1
-- Pendulum Summon of a monster(s) from your hand in addition to your Pendulum Summon.
-- (You can only gain this effect once per turn.)
--[[ __CARD_HEADER_END__ ]]

--彗聖の将－ワンモア・ザ・ナイト
local s,id,o=GetID()
function s.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--return to deck
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(s.tdcon)
	e1:SetTarget(s.tdtg)
	e1:SetOperation(s.tdop)
	c:RegisterEffect(e1)
	--second pendulum summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,3))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DRAW)
	e2:SetCost(s.expcost)
	e2:SetTarget(s.exptg)
	e2:SetOperation(s.expop)
	c:RegisterEffect(e2)
end
function s.cfilter(c,tp)
	return c:IsSummonPlayer(tp) and c:IsSummonType(SUMMON_TYPE_PENDULUM)
end
function s.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp)
end
function s.tdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TODECK,e:GetHandler(),1,0,0)
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		local opt=aux.SelectFromOptions(tp,
			{true,aux.Stringid(id,1),SEQ_DECKTOP},
			{true,aux.Stringid(id,2),SEQ_DECKBOTTOM})
		Duel.SendtoDeck(c,nil,opt,REASON_EFFECT)
	end
end
function s.expcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not e:GetHandler():IsPublic() end
end
function s.exptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 end
end
function s.expop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,4))
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_EXTRA_PENDULUM_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCountLimit(1,id)
	e1:SetValue(s.pendvalue)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
end
function s.pendvalue(e,c)
	return c:IsLocation(LOCATION_HAND)
end
