--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Gem-Elephant  (ID: 19019586)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level: 3
-- ATK 400 | DEF 1900
-- Setcode: 0x47
-- Scope: OCG / TCG
--
-- Effect Text:
-- During your Main Phase: You can return this face-up card on the field to the hand.
-- Once per battle, during damage calculation, if this card battles (Quick Effect): You can send 1
-- Normal Monster from your hand to the GY; this card gains 1000 DEF during that damage calculation
-- only.
--[[ __CARD_HEADER_END__ ]]

--ジェムエレファント
function c19019586.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetDescription(aux.Stringid(19019586,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c19019586.thtg)
	e1:SetOperation(c19019586.thop)
	c:RegisterEffect(e1)
	--defup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(19019586,1))
	e2:SetCategory(CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c19019586.defcon)
	e2:SetCost(c19019586.defcost)
	e2:SetOperation(c19019586.defop)
	c:RegisterEffect(e2)
end
function c19019586.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetHandler(),1,0,0)
end
function c19019586.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		Duel.SendtoHand(c,nil,REASON_EFFECT)
	end
end
function c19019586.cfilter(c)
	return c:IsType(TYPE_NORMAL) and c:IsAbleToGraveAsCost()
end
function c19019586.defcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c==Duel.GetAttacker() or c==Duel.GetAttackTarget()
end
function c19019586.defcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(19019586)==0
		and Duel.IsExistingMatchingCard(c19019586.cfilter,tp,LOCATION_HAND,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c19019586.cfilter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:GetHandler():RegisterFlagEffect(19019586,RESET_PHASE+PHASE_DAMAGE_CAL,0,1)
end
function c19019586.defop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_DEFENSE)
	e1:SetReset(RESET_PHASE+PHASE_DAMAGE_CAL)
	e1:SetValue(1000)
	c:RegisterEffect(e1)
end
