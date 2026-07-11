--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Maharaghi  (ID: 40695128)
-- Type: Monster / Effect / Spirit
-- Attribute: EARTH
-- Race: Rock
-- Level: 4
-- ATK 1200 | DEF 1700
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card cannot be Special Summoned.
-- This card returns to the owner's hand during the End Phase of the turn that this card is Normal
-- Summoned or flipped face-up.
-- If this card is Normal Summoned or flipped face-up, look at 1 card on the top of your Deck during
-- your next Draw Phase (before you draw), and return the card to the top or the bottom of your Deck.
--[[ __CARD_HEADER_END__ ]]

--磨破羅魏
function c40695128.initial_effect(c)
	--spirit return
	aux.EnableSpiritReturn(c,EVENT_SUMMON_SUCCESS,EVENT_FLIP)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--summon success
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(40695128,1))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e4:SetCode(EVENT_SUMMON_SUCCESS)
	e4:SetOperation(c40695128.regop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_FLIP)
	c:RegisterEffect(e5)
end
function c40695128.regop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFlagEffect(tp,40695128)~=0 then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetCondition(c40695128.condition)
	e1:SetOperation(c40695128.operation)
	e1:SetReset(RESET_PHASE+PHASE_DRAW+RESET_SELF_TURN,1)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,40695128,RESET_PHASE+PHASE_END,0,2)
end
function c40695128.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0
end
function c40695128.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.ConfirmCards(tp,g)
	local tc=g:GetFirst()
	local opt=Duel.SelectOption(tp,aux.Stringid(40695128,2),aux.Stringid(40695128,3))
	if opt==1 then
		Duel.MoveSequence(tc,opt)
	end
end
