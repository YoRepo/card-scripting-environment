--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Performapal Thunderhino  (ID: 70458081)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Rock
-- Level: 3
-- ATK 200 | DEF 1800
-- Setcode: 0x9f
-- Scope: OCG / TCG
--
-- Effect Text:
-- Monsters your opponent controls cannot target face-up "Performapal" monsters for attacks, except
-- this one.
-- If a "Performapal" card(s) you control, except "Performapal Thunderhino", would be destroyed by
-- battle or card effect while this card is in your Graveyard, you can banish this card instead.
--[[ __CARD_HEADER_END__ ]]

--EMジンライノ
function c70458081.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c70458081.atlimit)
	c:RegisterEffect(e1)
	--destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetTarget(c70458081.reptg)
	e2:SetValue(c70458081.repval)
	e2:SetOperation(c70458081.repop)
	c:RegisterEffect(e2)
end
function c70458081.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x9f) and c~=e:GetHandler()
end
function c70458081.repfilter(c,tp)
	return c:IsFaceup() and c:IsSetCard(0x9f) and not c:IsCode(70458081)
		and c:IsOnField() and c:IsControler(tp) and c:IsReason(REASON_EFFECT+REASON_BATTLE) and not c:IsReason(REASON_REPLACE)
end
function c70458081.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemove() and eg:IsExists(c70458081.repfilter,1,nil,tp) end
	return Duel.SelectEffectYesNo(tp,e:GetHandler(),96)
end
function c70458081.repval(e,c)
	return c70458081.repfilter(c,e:GetHandlerPlayer())
end
function c70458081.repop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end
