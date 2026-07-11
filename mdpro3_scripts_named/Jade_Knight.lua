--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Jade Knight  (ID: 44364207)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level: 4
-- ATK 1000 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- While this card is in Attack Position, Machine monsters you control with 1200 or less ATK cannot be
-- destroyed by Trap effects.
-- When this card is destroyed by battle and sent to the GY: You can add 1 Level 4 LIGHT Machine
-- monster from your Deck to your hand.
--[[ __CARD_HEADER_END__ ]]

--ジェイドナイト
function c44364207.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCondition(c44364207.indescon)
	e1:SetTarget(c44364207.indestg)
	e1:SetValue(c44364207.indesval)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(44364207,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c44364207.condition)
	e2:SetTarget(c44364207.target)
	e2:SetOperation(c44364207.operation)
	c:RegisterEffect(e2)
end
function c44364207.indescon(e)
	return e:GetHandler():IsAttackPos()
end
function c44364207.indestg(e,c)
	return c:IsRace(RACE_MACHINE) and c:IsAttackBelow(1200)
end
function c44364207.indesval(e,re)
	return re:GetHandler():IsType(TYPE_TRAP)
end
function c44364207.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE) and c:IsPreviousPosition(POS_FACEUP)
end
function c44364207.filter(c)
	return c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsLevel(4) and c:IsAbleToHand()
end
function c44364207.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c44364207.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c44364207.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c44364207.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
