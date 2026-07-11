--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Prohibitive Power Patron Purview - Vilaea  (ID: 99311889)
-- Type: Spell / Quick-Play
-- Setcode: 0x1ce
-- Scope: OCG / TCG
--
-- Effect Text:
-- Show 1 "Nerva the Power Patron of Creation", 1 "Jupiter the Power Patron of Destruction", and 1
-- "Junora the Power Patron of Tuning" from your Extra Deck, face-up Monster Zone, and/or GY, and if
-- you do, your opponent cannot activate cards or effects in response to the activation of your "Power
-- Patron" monster effects this turn.
-- If you would banish the top card(s) of your Deck to activate the effect of a "Power Patron" monster
-- you control, you can banish this card from your GY instead.
-- You can only use each effect of "Prohibitive Power Patron Purview - Vilaea" once per turn.
--[[ __CARD_HEADER_END__ ]]

--絶境なる獄神域－ヴィライア
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,53589300,68231287,5914858)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,id)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	--change cost
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCode(id)
	e2:SetCountLimit(1,id+o)
	c:RegisterEffect(e2)
end
function s.cfilter(c,tp)
	return (c:IsLocation(LOCATION_EXTRA) or c:IsFaceupEx()) and c:IsCode(53589300,68231287,5914858)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_EXTRA+LOCATION_MZONE+LOCATION_GRAVE,0,nil,tp)
	if chk==0 then return Duel.GetFlagEffect(tp,id)==0 and g:CheckSubGroup(aux.dncheck,3,3) end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_EXTRA+LOCATION_MZONE+LOCATION_GRAVE,0,nil,tp)
	if Duel.GetFlagEffect(tp,id)==0 and g:CheckSubGroup(aux.dncheck,3,3) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
		local sg=g:SelectSubGroup(tp,aux.dncheck,false,3,3,nil)
		Duel.ConfirmCards(1-tp,sg)
		if sg:IsExists(Card.IsLocation,1,nil,LOCATION_EXTRA) then
			Duel.ShuffleExtra(tp)
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_CHAINING)
		e1:SetOperation(s.actop)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
		Duel.RegisterFlagEffect(tp,id,RESET_PHASE+PHASE_END,0,1)
	end
end
function s.actop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp and re:GetHandler():IsSetCard(0x1ce) and re:IsActiveType(TYPE_MONSTER) then
		Duel.SetChainLimit(s.chainlm)
	end
end
function s.chainlm(e,rp,tp)
	return tp==rp
end
