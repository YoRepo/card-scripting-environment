--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Spirit of the Breeze  (ID: 53530069)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Fairy
-- Level: 3
-- ATK 0 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as this card remains in face-up Attack Position on your side of the field, increase your
-- Life Points by 1000 points during each of your Standby Phases.
--[[ __CARD_HEADER_END__ ]]

--そよ風の精霊
function c53530069.initial_effect(c)
	--recover
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(53530069,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c53530069.condition)
	e1:SetTarget(c53530069.target)
	e1:SetOperation(c53530069.operation)
	c:RegisterEffect(e1)
end
function c53530069.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and e:GetHandler():IsAttackPos()
end
function c53530069.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c53530069.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local c=e:GetHandler()
	if c:IsPosition(POS_FACEUP_ATTACK) and c:IsRelateToEffect(e) then
		Duel.Recover(p,d,REASON_EFFECT)
	end
end
