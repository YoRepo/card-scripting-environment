--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Fortune Vision  (ID: 91407982)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- When this card is activated: You can add 1 "Fortune Lady" card from your Deck to your hand.
-- Once per turn, if a card(s) you control is banished by card effect (except during the Damage Step):
-- You can activate this effect; this turn, monsters you control cannot be destroyed by card effects
-- (even if this card leaves the field).
-- Once per turn, if a card(s) your opponent controls is banished by card effect (except during the
-- Damage Step): You can make the next battle damage you take this turn become 0 (even if this card
-- leaves the field).
-- You can only activate 1 "Fortune Vision" per turn.
--[[ __CARD_HEADER_END__ ]]

--フォーチュン・ヴィジョン
function c91407982.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,91407982+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c91407982.activate)
	c:RegisterEffect(e1)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(91407982,1))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_REMOVE)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c91407982.indcon)
	e2:SetOperation(c91407982.indop)
	c:RegisterEffect(e2)
	--avoid battle damage
	local e3=e2:Clone()
	e3:SetDescription(aux.Stringid(91407982,2))
	e3:SetCondition(c91407982.damcon)
	e3:SetOperation(c91407982.damop)
	c:RegisterEffect(e3)
end
function c91407982.filter(c)
	return c:IsSetCard(0x31) and c:IsAbleToHand()
end
function c91407982.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c91407982.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(91407982,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c91407982.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsPreviousControler(tp) and c:IsReason(REASON_EFFECT)
end
function c91407982.indcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c91407982.cfilter,1,nil,tp)
end
function c91407982.indop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetValue(1)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c91407982.damcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c91407982.cfilter,1,nil,1-tp)
end
function c91407982.damop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_AVOID_BATTLE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
