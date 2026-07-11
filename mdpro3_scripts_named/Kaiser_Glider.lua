--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Kaiser Glider  (ID: 52824910)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Dragon
-- Level: 6
-- ATK 2400 | DEF 2200
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be destroyed by battle with a monster that has the same ATK.
-- If this card is destroyed and sent to the GY: Target 1 monster on the field; return that target to
-- the hand.
--[[ __CARD_HEADER_END__ ]]

--カイザー・グライダー
function c52824910.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(c52824910.indes)
	c:RegisterEffect(e1)
	--to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(52824910,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c52824910.condition)
	e2:SetTarget(c52824910.target)
	e2:SetOperation(c52824910.operation)
	c:RegisterEffect(e2)
end
function c52824910.indes(e,c)
	return c:IsAttack(e:GetHandler():GetAttack())
end
function c52824910.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY)
end
function c52824910.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsAbleToHand() end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RTOHAND)
	local g=Duel.SelectTarget(tp,Card.IsAbleToHand,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c52824910.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
