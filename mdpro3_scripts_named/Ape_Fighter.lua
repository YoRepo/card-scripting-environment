--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Ape Fighter  (ID: 41098335)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level: 4
-- ATK 1900 | DEF 1200
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card destroys an opponent's monster by battle: This card gains 300 ATK.
-- If this card does not attack during your turn, the ATK gained from this effect returns to 0 during
-- the End Phase of that turn.
--[[ __CARD_HEADER_END__ ]]

--ファイターズ・エイプ
function c41098335.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41098335,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c41098335.atkcon)
	e1:SetOperation(c41098335.atkop)
	c:RegisterEffect(e1)
	--atk clear
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TURN_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetOperation(c41098335.retop)
	c:RegisterEffect(e2)
end
function c41098335.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsRelateToBattle()
end
function c41098335.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c41098335.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetTurnPlayer()==tp and c:GetAttackedCount()==0 then
		c:ResetEffect(RESET_DISABLE,RESET_EVENT)
	end
end
