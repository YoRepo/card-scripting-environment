--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Gravekeeper's Watcher  (ID: 26084285)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level: 4
-- ATK 1000 | DEF 1000
-- Setcode: 0x2e
-- Scope: OCG / TCG
--
-- Effect Text:
-- During either player's turn, when your opponent activates a Spell/Trap Card or monster effect that
-- could make them discard when it resolves: You can send this card from your hand to the Graveyard;
-- negate the activation, and if you do, destroy it.
--[[ __CARD_HEADER_END__ ]]

--墓守の監視者
function c26084285.initial_effect(c)
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(26084285,0))
	e1:SetCategory(CATEGORY_NEGATE+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c26084285.condition)
	e1:SetCost(c26084285.cost)
	e1:SetTarget(c26084285.target)
	e1:SetOperation(c26084285.operation)
	c:RegisterEffect(e1)
end
function c26084285.condition(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or (not re:IsHasType(EFFECT_TYPE_ACTIVATE) and not re:IsActiveType(TYPE_MONSTER))
		or (not Duel.IsChainNegatable(ev)) then return false end
	local ex,tg,tc,p=Duel.GetOperationInfo(ev,CATEGORY_HANDES_SELF)
	return re:IsHasCategory(CATEGORY_HANDES_SELF) or ex
end
function c26084285.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c26084285.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
	if re:GetHandler():IsDestructable() and re:GetHandler():IsRelateToEffect(re) then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,1,0,0)
	end
end
function c26084285.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:GetHandler():IsRelateToEffect(re) then
		Duel.Destroy(eg,REASON_EFFECT)
	end
end
