--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Sunny Pixie  (ID: 73837870)
-- Type: Monster / Effect / Tuner
-- Attribute: LIGHT
-- Race: Spellcaster
-- Level: 1
-- ATK 300 | DEF 400
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card is sent to the Graveyard for the Synchro Summon of a LIGHT Synchro Monster: Gain 1000
-- Life Points.
--[[ __CARD_HEADER_END__ ]]

--サニー・ピクシー
function c73837870.initial_effect(c)
	--lp rec
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(73837870,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BE_MATERIAL)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_DELAY)
	e1:SetCondition(c73837870.reccon)
	e1:SetTarget(c73837870.rectg)
	e1:SetOperation(c73837870.recop)
	c:RegisterEffect(e1)
end
function c73837870.reccon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and r==REASON_SYNCHRO
		and e:GetHandler():GetReasonCard():IsAttribute(ATTRIBUTE_LIGHT)
end
function c73837870.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,1000)
end
function c73837870.recop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
