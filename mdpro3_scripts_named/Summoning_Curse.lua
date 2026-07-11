--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Summoning Curse  (ID: 61650133)
-- Type: Spell / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- If a monster(s) is Special Summoned: The current controller of that monster(s) banishes 1 card from
-- their hand.
-- Once per turn, during your End Phase, pay 500 LP or destroy this card.
--[[ __CARD_HEADER_END__ ]]

--召喚の呪詛
function c61650133.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--maintain
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(61650133,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c61650133.mtcon)
	e2:SetOperation(c61650133.mtop)
	c:RegisterEffect(e2)
	--remove
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(61650133,1))
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTarget(c61650133.rmtg)
	e3:SetOperation(c61650133.rmop)
	c:RegisterEffect(e3)
end
function c61650133.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c61650133.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckLPCost(tp,500) and Duel.SelectYesNo(tp,aux.Stringid(61650133,0)) then
		Duel.PayLPCost(tp,500)
	else
		Duel.Destroy(e:GetHandler(),REASON_COST)
	end
end
function c61650133.rmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
end
function c61650133.rmop(e,tp,eg,ep,ev,re,r,rp)
	local rm1=false
	local rm2=false
	local tc=eg:GetFirst()
	while tc do
		if tc:IsOnField() then
			if tc:IsControler(tp) then rm1=true else rm2=true end
		end
		tc=eg:GetNext()
	end
	local g=Group.CreateGroup()
	if rm1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local g1=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_HAND,0,1,1,nil)
		g:Merge(g1)
	end
	if rm2 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_REMOVE)
		local g2=Duel.SelectMatchingCard(1-tp,Card.IsAbleToRemove,1-tp,LOCATION_HAND,0,1,1,nil)
		g:Merge(g2)
	end
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end
